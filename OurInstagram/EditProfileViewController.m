//
//  EditProfileViewController.m
//  OurInstagram
//
//  Created by Tony Dakhoul on 6/10/15.
//  Copyright (c) 2015 Tony Dakhoul. All rights reserved.
//

#import <Parse/Parse.h>
#import "EditProfileViewController.h"

@interface EditProfileViewController ()
@property (weak, nonatomic) IBOutlet UITextField *displayNameField;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *websiteField;
@property (weak, nonatomic) IBOutlet UITextField *bioField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UITextField *genderField;
@property PFUser *currentUser;

@end

@implementation EditProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentUser = [PFUser currentUser];
    PFUser *currentUser = self.currentUser;
    self.displayNameField.text = currentUser[@"displayName"];
    self.usernameField.text = currentUser[@"username"];
    self.websiteField.text = currentUser.email;
    self.bioField.text = currentUser[@"bio"];
}

- (IBAction)onSaveTapped:(UIBarButtonItem *)sender {
    self.currentUser.username = self.usernameField.text;
    self.currentUser[@"userURL"] = self.websiteField.text;
    self.currentUser[@"bio"] = self.bioField.text;
    self.currentUser.email = self.emailField.text;
    self.currentUser[@"displayName"] = self.displayNameField.text;
    [self.currentUser saveInBackground];
    [self hideKeyboard];
    [self dismissViewControllerAnimated:self completion:nil];
}

- (void) hideKeyboard {
    [self.displayNameField resignFirstResponder];
    [self.usernameField resignFirstResponder];
    [self.websiteField resignFirstResponder];
    [self.bioField resignFirstResponder];
    [self.emailField resignFirstResponder];
    [self.phoneField resignFirstResponder];
    [self.genderField resignFirstResponder];
}


@end
