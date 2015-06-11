//
//  HomeViewController.m
//  OurInstagram
//
//  Created by Tony Dakhoul on 6/9/15.
//  Copyright (c) 2015 Tony Dakhoul. All rights reserved.
//

#import "HomeViewController.h"
#import <Parse/Parse.h>
#import "LoginViewController.h"

@interface HomeViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property PFUser *currentUser;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.currentUser = [PFUser currentUser];
    if (self.currentUser == nil) {
        NSLog(@"No current user, loading login screen.");
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        [self presentViewController:loginVC animated:YES completion:nil];
    } else {
        NSLog(@"Current user exists, current user is: %@", self.currentUser.username);
        NSLog(@"Current userId: %@", [self.currentUser objectId]);
        NSLog(@"Current user email: %@", self.currentUser[@"email"]);
        self.currentUser[@"bio"] = @"CAN EDIT HERE"; // does not work
    }

//    for (NSString* family in [UIFont familyNames]) {
//        NSLog(@"%@", family);
//
//        for (NSString* name in [UIFont fontNamesForFamilyName: family]) {
//            NSLog(@"  %@", name);
//        }
//    }

    self.navigationController.navigationBar.titleTextAttributes = @{NSFontAttributeName: [UIFont fontWithName:@"Billabong" size:30], NSForegroundColorAttributeName: [UIColor whiteColor]};

//    [[UINavigationBar appearance] setTitleTextAttributes: @{NSForegroundColorAttributeName: [UIColor whiteColor]}];

}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

-(UICollectionViewCell * )collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellID" forIndexPath:indexPath];
    return cell;
}

@end
