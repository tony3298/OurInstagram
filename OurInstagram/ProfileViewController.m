//
//  ProfileViewController.m
//  OurInstagram
//
//  Created by Tony Dakhoul on 6/9/15.
//  Copyright (c) 2015 Tony Dakhoul. All rights reserved.
//

#import "ProfileViewController.h"
#import <Parse/Parse.h>

@interface ProfileViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *settingsBarButton;
@property (weak, nonatomic) IBOutlet UILabel *displayNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *bioLabel;
@property (weak, nonatomic) IBOutlet UILabel *userUrlLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property PFUser *currentUser;

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



@end
