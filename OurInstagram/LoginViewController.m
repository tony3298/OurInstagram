//
//  LoginViewController.m
//  OurInstagram
//
//  Created by Bryon Finke on 6/10/15.
//  Copyright (c) 2015 Tony Dakhoul. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *signupButton;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self userSignUp];

    PFUser *currentUser = [PFUser currentUser];
    if (currentUser != nil) { //Don't show sign up button if user is already signed up
        self.signupButton.alpha = 0;
    }

    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    testObject[@"foo"] = @"bar";
    [testObject saveInBackground];

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults objectForKey:@"currentUser"] == nil) {
        //sign up / login


    } else {
        //set up current user and pass to each view
    }
}

- (void)userSignUp {

    // Simulating Sign Up
    PFUser *user = [PFUser user];
    user.username = self.usernameTextField.text;
    user.email = self.emailTextField.text;
    user.password = self.passwordTextField.text;

    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            PFUser *currentUser = [PFUser currentUser];
            NSLog(@"Signed up %@, who has a userID of %@", currentUser.username,currentUser[@"objectID"]);
        } else {   NSString *errorString = [error userInfo][@"error"];   // Show the errorString somewhere and let the user try again.
            NSLog(@"Error signing up user: %@", errorString);
        }
    }];

}

- (void) userLogOut {
    [PFUser logOutInBackground];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Logged Out" message:@"You have logged out." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles: nil];
    [alert show];
}

- (IBAction)onLoginTapped:(UIButton *)sender {
}

- (IBAction)onSignupTapped:(UIButton *)sender {
    [self userSignUp];
}
@end
