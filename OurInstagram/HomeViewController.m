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
#import "Post.h"

@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property PFUser *currentUser;
@property NSMutableArray *posts;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Get posts from friends(following) and currentUser.
    self.posts = [[NSMutableArray alloc] init];

    self.currentUser = [PFUser currentUser];

    if (self.currentUser != nil) {
        PFQuery *userPostsQuery = [PFQuery queryWithClassName:@"Post"];
        [userPostsQuery whereKey:@"user" equalTo:[PFUser currentUser]];
        [userPostsQuery findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
            if (!error) {
                NSLog(@"Successfully retrieved %lu posts.", posts.count);

                for (PFObject *post in posts) {

                    PFFile *imageFile = post[@"image"];
                    [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {

                        if (data == nil) {
                            NSLog(@"Failed to download post image.");
                        }
                        UIImage *image = [UIImage imageWithData:data];
                        NSLog(@"Post Image: %@", image);

                        [self.posts addObject:image];
                        NSLog(@"%lu", self.posts.count);
                        [self.tableView reloadData];
                    }];
                }

                NSLog(@"Tableview reloaded.");
                [self.tableView reloadData];
            } else {
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
        }];
    }



//    NSArray *friends = self.currentUser[@"friends"];
//    for (PFObject *friend in friends) {
//        [self.posts addObject:friend[@"post"]];
//    }
//    NSMutableArray *userPosts = self.currentUser[@"posts"];
//    [self.posts addObjectsFromArray:userPosts];

    // Sort self.posts ?
    // ...

    self.currentUser = [PFUser currentUser];
    if (self.currentUser == nil) {
        NSLog(@"No current user, loading login screen.");

        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        LoginViewController *loginVC = (LoginViewController*)[storyboard instantiateViewControllerWithIdentifier: @"LoginViewController"];
        [self presentViewController:loginVC animated:YES completion:nil];
    }

    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName: [UIFont fontWithName:@"Billabong" size:30], NSForegroundColorAttributeName: [UIColor whiteColor]};
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.posts.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];

    cell.imageView.image = self.posts[indexPath.row];
    cell.textLabel.text = @"Tony";

    return cell;
}
@end
