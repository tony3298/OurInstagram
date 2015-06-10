//
//  TakePhotoViewController.m
//  OurInstagram
//
//  Created by Tony Dakhoul on 6/9/15.
//  Copyright (c) 2015 Tony Dakhoul. All rights reserved.
//

#import "TakePhotoViewController.h"
#import "CameraView.h"

@interface TakePhotoViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property UIImagePickerController *picker;
@property CameraView *cameraView;

@end

@implementation TakePhotoViewController

//AVCaptureSession *session;
//AVCaptureStillImageOutput *stillImageOutput;

- (void)viewDidLoad {
    [super viewDidLoad];

    NSLog(@"In camera view controller");
}

//-(void)viewDidAppear:(BOOL)animated {
//
//    session = [[AVCaptureSession alloc] init];
//    [session setSessionPreset:AVCaptureSessionPresetPhoto];
//
//    AVCaptureDevice *inputDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
//    NSError *error;
//    AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:inputDevice error:&error];
//
//    if ([session canAddInput:deviceInput]) {
//        [session addInput:deviceInput];
//    }
//
//    AVCaptureVideoPreviewLayer *previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
//    [previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
//    CALayer *rootLayer = [self.view layer];
//    [rootLayer setMasksToBounds:YES];
//    //    CGRect frame = self.frameForCapture.frame;
//    CGRect frame = CGRectMake(self.frameForCapture.frame.origin.x, self.frameForCapture.frame.origin.y, self.frame.size.width, self.frame.size.height/2);
//
//    NSLog(@"%f, %f", frame.size.width, frame.size.height);
//
//    [previewLayer setFrame:frame];
//    [rootLayer insertSublayer:previewLayer atIndex:0];
//
//    stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
//    NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG, AVVideoCodecKey, nil];
//    [stillImageOutput setOutputSettings:outputSettings];
//
//    [session addOutput:stillImageOutput];
//
//    [session startRunning];
//
//    if ([session isRunning]) {
//        NSLog(@"session running");
//    }
//}
@end
