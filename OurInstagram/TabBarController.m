//
//  TabBarController.m
//  OurInstagram
//
//  Created by Tony Dakhoul on 6/9/15.
//  Copyright (c) 2015 Tony Dakhoul. All rights reserved.
//

#import "TabBarController.h"
//#import "TakePhotoViewController.h"
#import "CameraView.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    [[UINavigationBar appearance] setTranslucent:NO];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0.070 green:0.337 blue:0.533 alpha:1.0]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes: @{NSForegroundColorAttributeName: [UIColor whiteColor]}];

    NSArray *tabBarItemImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"Home"], [UIImage imageNamed:@"Search"], [UIImage imageNamed:@"Camera"], [UIImage imageNamed:@"Heart"], [UIImage imageNamed:@"Profile"] , nil];

    self.tabBar.selectionIndicatorImage = [self imageWithImage:[UIImage imageNamed:@"blackbackground"] scaledToSize:CGSizeMake(self.tabBar.frame.size.width/5, self.tabBar.frame.size.height)];;

    self.tabBar.tintColor = [UIColor whiteColor];
    self.tabBar.barTintColor = [UIColor blackColor];
    int i = 0;

    for (UITabBarItem *item in self.tabBar.items) {

        if (i < 5) {

            item.image = [self imageWithImage:tabBarItemImages[i] scaledToSize:CGSizeMake(30, 30)];
            item.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
            i++;
        }
    }

    [self createCenterCameraButton];
}

-(void)createCenterCameraButton {

    UIButton *cameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cameraButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    cameraButton.frame = CGRectMake(0.0, 0.0, self.tabBar.frame.size.width/5, self.tabBar.frame.size.height);
    UIImage *cameraImage = [self imageWithImage:[UIImage imageNamed:@"Camera"] scaledToSize:CGSizeMake(30, 30)];
    cameraImage = [cameraImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [cameraButton setImage:cameraImage forState:UIControlStateNormal];
    [cameraButton setTintColor:[UIColor whiteColor]];
    cameraButton.backgroundColor = [UIColor colorWithRed:0.070 green:0.337 blue:0.533 alpha:1.0];
    cameraButton.center = self.tabBar.center;

    [cameraButton addTarget:self action:@selector(cameraView) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:cameraButton];
}

-(void)cameraView {

    CameraView *cameraView = [[[NSBundle mainBundle] loadNibNamed:@"CameraView" owner:self options:nil] objectAtIndex:0];

    cameraView.frame = self.view.frame;
    cameraView.center = self.view.center;


    cameraView.frame = CGRectMake(0, cameraView.frame.size.height, cameraView.frame.size.width, cameraView.frame.size.height);


    [self.view addSubview:cameraView];

    [UIView animateWithDuration:0.3
                     animations:^{
                         cameraView.center = self.view.center;
                     } completion:^(BOOL finished) {

                         [[UIApplication sharedApplication] setStatusBarHidden:YES];
                     }];
//    TakePhotoViewController *takePhotoVC = self.viewControllers[2];
//    takePhotoVC.creatingPost = YES;

//    [self setSelectedIndex:2];

}

- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
