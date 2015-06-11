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

@interface HomeViewController () <UITableViewDataSource, UITableViewDelegate>
@property PFUser *currentUser;
@property NSMutableArray *posts;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Get posts from friends(following) and currentUser.
    self.posts = [[NSMutableArray alloc] init];

    PFQuery *userPostsQuery = [PFQuery queryWithClassName:@"Post"];
    [userPostsQuery whereKey:@"user" equalTo:[PFUser currentUser]];
    [userPostsQuery findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (!error) {
            NSLog(@"Successfully retrieved %d posts.", posts.count);
            for (PFObject *post in posts) {
                PFUser *user = post[@"user"];
                NSLog(@"Post from %@", user[@"username"]);
            }
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];

    NSArray *friends = self.currentUser[@"friends"];
    for (PFObject *friend in friends) {
        [self.posts addObject:friend[@"post"]];
    }
    NSMutableArray *userPosts = self.currentUser[@"posts"];
    [self.posts addObjectsFromArray:userPosts];

    // Sort self.posts ?
    // ...

    self.currentUser = [PFUser currentUser];
    if (self.currentUser == nil) {
        NSLog(@"No current user, loading login screen.");
//        LoginViewController *loginVC = [[LoginViewController alloc] init];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        LoginViewController *loginVC = (LoginViewController*)[storyboard instantiateViewControllerWithIdentifier: @"LoginViewController"];
        [self presentViewController:loginVC animated:YES completion:nil];
    } else {
        NSLog(@"Current user exists, current user is: %@", self.currentUser.username);
        NSLog(@"Current userId: %@", [self.currentUser objectId]);
        NSLog(@"Current user email: %@", self.currentUser[@"email"]);
        self.posts = self.currentUser[@"posts"]; // Only grabbing posts from current user. Need to grab posts from every person user is following also.
    }
    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName: [UIFont fontWithName:@"Billabong" size:30], NSForegroundColorAttributeName: [UIColor whiteColor]};
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.posts.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];

    PFObject *post = [self.posts objectAtIndex:indexPath.row];
    PFFile *imageFile = post[@"image"];
    NSArray *comments = post[@"comments"];
    NSArray *likes = post[@"likes"];

    return cell;
}


@end
