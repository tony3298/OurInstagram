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
@property (weak, nonatomic) IBOutlet UIButton *chooseLoginButton;
@property (weak, nonatomic) IBOutlet UIButton *chooseSignUpButton;
@property (weak, nonatomic) IBOutlet UILabel *instagramLogoLabel;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupForSignUp];
    self.instagramLogoLabel.alpha = 0.6;
    self.passwordTextField.secureTextEntry = YES;
    [self.loginButton.layer setCornerRadius:self.loginButton.frame.size.width/5];
    [self.signupButton.layer setCornerRadius:self.signupButton.frame.size.width/5];
    self.instagramLogoLabel.font = [UIFont fontWithName:@"billabong" size:35.0];


    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    testObject[@"foo"] = @"bar";
    [testObject saveInBackground];

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults objectForKey:@"currentUser"] == nil) {
        
    }
}

- (void) userLogOut {
    [PFUser logOutInBackground];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Logged Out" message:@"You have logged out." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles: nil];
    [alert show];
}

- (IBAction)onLoginTapped:(UIButton *)sender {
    [self userLogIn];
}

- (IBAction)onSignupTapped:(UIButton *)sender {
    [self userSignUp];
}

-(void)userSignUp {
    PFUser *user = [PFUser new];
    user.username = self.usernameTextField.text;
    user.email = self.emailTextField.text;
    user.password = self.passwordTextField.text;

    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            [self dismissViewControllerAnimated:true completion:nil];
        } else {
            [self showAlert:@"Signup error" param2:error];
        }
    }];
}

-(void)userLogIn {
    [PFUser logInWithUsernameInBackground:self.usernameTextField.text password:self.passwordTextField.text block:^(PFUser *user, NSError *error) {
        if (!error) {
            [self dismissViewControllerAnimated:true completion:nil];
        } else {
            [self showAlert:@"Login error" param2:error];
        }
    }];
}

-(void)showAlert:(NSString *)message param2:(NSError *)error {
    UIAlertView *alert = [UIAlertView new];
    alert.title = message;
    alert.message = [error localizedDescription];
    [alert addButtonWithTitle:@"Dismiss"];
    alert.delegate = self;
    [alert show];
}

- (IBAction)chooseLoginButtonTapped:(id)sender {
    [self setupForLogIn];
}

- (IBAction)chooseSignUpButtonTapped:(id)sender {
    [self setupForSignUp];
}

- (void) setupForLogIn {
    self.chooseLoginButton.alpha = 0;
    self.signupButton.alpha = 0;
    self.emailTextField.alpha = 0;
    self.chooseSignUpButton.alpha = 1;
    self.loginButton.alpha = 1;
}

- (void) setupForSignUp {
    self.chooseLoginButton.alpha = 1;
    self.signupButton.alpha = 1;
    self.emailTextField.alpha = 1;
    self.chooseSignUpButton.alpha = 0;
    self.loginButton.alpha = 0;
}



@end
