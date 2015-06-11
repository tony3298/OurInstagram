//
//  CameraView.m
//  OurInstagram
//
//  Created by Tony Dakhoul on 6/10/15.
//  Copyright (c) 2015 Tony Dakhoul. All rights reserved.
//

#import "CameraView.h"

@implementation CameraView

AVCaptureSession *session;
AVCaptureStillImageOutput *stillImageOutput;

-(id)initWithCoder:(NSCoder *)aDecoder {

    if(self = [super initWithCoder:aDecoder]) {

        NSLog(@"Test");
//        session = [[AVCaptureSession alloc] init];
//        [session setSessionPreset:AVCaptureSessionPresetPhoto];
//
//        AVCaptureDevice *inputDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
//        NSError *error;
//        AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:inputDevice error:&error];
//
//        if ([session canAddInput:deviceInput]) {
//            [session addInput:deviceInput];
//        }
//
//        AVCaptureVideoPreviewLayer *previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
//        [previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
//        CALayer *rootLayer = [self layer];
//        [rootLayer setMasksToBounds:YES];
//        CGRect frame = self.frameForCapture.frame;
//
//        NSLog(@"%f, %f", frame.size.width, frame.size.height);
//
//        [previewLayer setFrame:frame];
//        [rootLayer insertSublayer:previewLayer atIndex:0];
//
//        stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
//        NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG, AVVideoCodecKey, nil];
//        [stillImageOutput setOutputSettings:outputSettings];
//
//        [session addOutput:stillImageOutput];
//
//        [session startRunning];
//
//        if ([session isRunning]) {
//            NSLog(@"session running");
//        }
    }

    return self;
}

-(void)didMoveToSuperview {

    session = [[AVCaptureSession alloc] init];
    [session setSessionPreset:AVCaptureSessionPresetPhoto];

    AVCaptureDevice *inputDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error;
    AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:inputDevice error:&error];

    if ([session canAddInput:deviceInput]) {
        [session addInput:deviceInput];
    }

    AVCaptureVideoPreviewLayer *previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
    [previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    CALayer *rootLayer = [self layer];
    [rootLayer setMasksToBounds:YES];
//    CGRect frame = self.frameForCapture.frame;
    CGRect frame = CGRectMake(self.frameForCapture.frame.origin.x, self.frameForCapture.frame.origin.y, self.frame.size.width, self.frame.size.height/2);

    NSLog(@"%f, %f", frame.size.width, frame.size.height);

    [previewLayer setFrame:frame];
    [rootLayer insertSublayer:previewLayer atIndex:0];

    stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG, AVVideoCodecKey, nil];
    [stillImageOutput setOutputSettings:outputSettings];

    [session addOutput:stillImageOutput];

    [session startRunning];

    if ([session isRunning]) {
        NSLog(@"session running");
    }

}

- (IBAction)takePhoto:(UIButton *)sender {

    AVCaptureConnection *videoConnection = nil;

    for (AVCaptureConnection *connection in stillImageOutput.connections) {

        for (AVCaptureInputPort *port in [connection inputPorts]) {

            if ([[port mediaType] isEqual:AVMediaTypeVideo]) {
                videoConnection = connection;
                break;
            }
            if (videoConnection) {
                break;
            }
        }
    }
    [stillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        if (imageDataSampleBuffer != nil) {
            NSData *data = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
            UIImage *image = [UIImage imageWithData:data];
            self.imageView.layer.cornerRadius = 10.0;
            self.imageView.clipsToBounds = YES;
            self.imageView.image = image;
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        }
    }];
}

- (IBAction)dissmissView:(UIButton *)sender {

    [UIView animateWithDuration:0.3 animations: ^{

        self.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {

        [self removeFromSuperview];
    }];

    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}
@end
