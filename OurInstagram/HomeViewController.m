//
//  HomeViewController.m
//  OurInstagram
//
//  Created by Tony Dakhoul on 6/9/15.
//  Copyright (c) 2015 Tony Dakhoul. All rights reserved.
//

#import "HomeViewController.h"
#import <Parse/Parse.h>
#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import "FeedTableViewCell.h"
#import "Post.h"

@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property PFUser *currentUser;

@property (nonatomic)  NSArray *posts;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Get posts from friends(following) and currentUser.
    self.posts = [[NSArray alloc] init];

    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName: [UIFont fontWithName:@"Billabong" size:30], NSForegroundColorAttributeName: [UIColor whiteColor]};

//    NSArray *friends = self.currentUser[@"friends"];
//    for (PFObject *friend in friends) {
//        [self.posts addObject:friend[@"post"]];
//    }
//    NSMutableArray *userPosts = self.currentUser[@"posts"];
//    [self.posts addObjectsFromArray:userPosts];
}

-(void)viewWillAppear:(BOOL)animated {

    if ([PFUser currentUser] == nil) {
        [self bringUpLoginViewController];
    }

    [self fetchPostsForFeed];
}

-(void)viewDidAppear:(BOOL)animated {

    NSLog(@"In home view controller");

//    if ([PFUser currentUser] == nil) {
//        [self bringUpLoginViewController];
//    }
//
//    [self fetchUserPosts];

}

-(void)setPosts:(NSArray *)posts {

    NSLog(@"In setPosts");
    _posts = posts;
    [self.tableView reloadData];
}

-(void)fetchPostsForFeed {

    if ([PFUser currentUser]) {
        PFQuery *userPostsQuery = [PFQuery queryWithClassName:@"Post"];
        [userPostsQuery orderByDescending:@"createdAt"];
//        [userPostsQuery whereKey:@"user" equalTo:[PFUser currentUser]];
        [userPostsQuery findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {

            if (!error) {
                NSLog(@"Successfully retrieved %lu posts.", posts.count);

                NSMutableArray *mutablePosts = [[NSMutableArray alloc] init];

                for (PFObject *postObject in posts) {
//                    PFFile *imageFile = post[@"image"];
//                    [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
//                        if (data == nil) {
//                            NSLog(@"Failed to load image data.");
//                        } else {
//                            UIImage *image = [UIImage imageWithData:data];
//                            NSLog(@"Image results: %@", image);
//
//                            [self.posts addObject:image];
//                            NSLog(@"%lu", self.posts.count);
//                            [self.tableView reloadData];
//                        }
//                    }];

                    Post *post = [[Post alloc] initWithPostObject:postObject];

                    if (post.imagePFFile) {

                        [post.imagePFFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {

                            if (!error) {
                                UIImage *image = [UIImage imageWithData:data];
                                post.image = image;

                                NSLog(@"YA");
                                [self.tableView reloadData];
                            }
                        }];

                        NSLog(@"BOO");
                    }

                    [mutablePosts addObject:post];
                }

                self.posts = mutablePosts;
//                NSLog(@"Tableview reloaded.");
//                [self.tableView reloadData];
            } else {
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
        }];
    }
}

-(void)bringUpLoginViewController {

    NSLog(@"No current user, loading login screen.");
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];

    LoginViewController *loginVC = (LoginViewController*)[storyboard instantiateViewControllerWithIdentifier: @"LoginViewController"];

    [self presentViewController:loginVC animated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    FeedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];

    Post *post = self.posts[indexPath.row];

    cell.postImageView.contentMode = UIViewContentModeScaleAspectFill;
    cell.postImageView.clipsToBounds = YES;

    cell.postImageView.image = post.image;
    cell.postUsernameTextLabel.text = post.user.username;

    [self setProfileImageView:cell.userProfileImageView withImage:[self fetchUserProfileImageFromPost:post]];

    return cell;
}

-(void)setProfileImageView:(UIImageView*)imageView withImage:(UIImage *)image {

    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = imageView.frame.size.width/2;
    imageView.image = image;
}

-(UIImage *)fetchUserProfileImageFromPost:(Post *)post {

    UIImage *image = [UIImage new];
    PFUser *user = post.user;

    if (user) {

        PFFile *profileImageFile = [user objectForKey:@"profileImage"];

        if (profileImageFile) {

            image = [UIImage imageWithData:[profileImageFile getData]];
        }
    }

    return image;
}
@end
