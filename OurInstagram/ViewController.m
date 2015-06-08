//
//  ViewController.m
//  OurInstagram
//
//  Created by Tony Dakhoul on 6/8/15.
//  Copyright (c) 2015 Tony Dakhoul. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [[[self.tabBarController.viewControllers objectAtIndex:0] tabBarItem]setFinishedSelectedImage:[UIImage imageNamed:@"Home"] withFinishedUnselectedImage:[UIImage imageNamed:@"Home"]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
