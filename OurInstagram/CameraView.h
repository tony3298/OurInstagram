//
//  CameraView.h
//  OurInstagram
//
//  Created by Tony Dakhoul on 6/10/15.
//  Copyright (c) 2015 Tony Dakhoul. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <Parse/Parse.h>

@interface CameraView : UIView

@property UIImagePickerController *pickerReference;

@property (weak, nonatomic) IBOutlet UIView *frameForCapture;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *captureButton;

@property PFUser *currentUser;

- (IBAction)takePhoto:(UIButton *)sender;

- (IBAction)dissmissView:(UIButton *)sender;
@end
