//
//  ProfileViewController.m
//  OurInstagram
//
//  Created by Tony Dakhoul on 6/9/15.
//  Copyright (c) 2015 Tony Dakhoul. All rights reserved.
//

#import "ProfileViewController.h"
#import "UserPostCollectionViewCell.h"
#import <Parse/Parse.h>

@interface ProfileViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *settingsBarButton;
@property (weak, nonatomic) IBOutlet UILabel *displayNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *bioLabel;
@property (weak, nonatomic) IBOutlet UILabel *userUrlLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property PFUser *currentUser;

@property NSArray *userPosts;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.settingsBarButton.title = @"\u2699";
    UIFont *f1 = [UIFont fontWithName:@"Helvetica" size:24.0];
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:f1, NSFontAttributeName, nil];
    [self.settingsBarButton setTitleTextAttributes:dict forState:UIControlStateNormal];

    self.currentUser = [PFUser currentUser];
    [self updateUserProfileInfo];
}

- (void) updateUserProfileInfo {
    // Fill up profile details
    self.displayNameLabel.text = self.currentUser[@"displayName"];
    self.usernameLabel.text = self.currentUser.username;
    self.bioLabel.text = self.currentUser[@"bio"];
    self.userUrlLabel.text = self.currentUser[@"userURL"];
    self.emailLabel.text = self.currentUser.email;
}

-(void)viewDidAppear:(BOOL)animated {
    [self updateUserProfileInfo];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.userPosts.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    UserPostCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellID" forIndexPath:indexPath];

    cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
    cell.imageView.clipsToBounds = YES;

    cell.imageView.image = self.userPosts[indexPath.row];


    return cell;
}

- (IBAction)onLogoutTapped:(UIBarButtonItem *)sender {

    if ([PFUser currentUser]) {

        NSLog(@"Logging out");

        [PFUser logOut];

//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
//        LoginViewController *loginVC = (LoginViewController*)[storyboard instantiateViewControllerWithIdentifier: @"LoginViewController"];
//        [self presentViewController:loginVC animated:YES completion:nil];

        self.tabBarController.selectedIndex = 0;
    }
}


@end
