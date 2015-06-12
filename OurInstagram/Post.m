//
//  Post.m
//  OurInstagram
//
//  Created by David Seitz Jr on 6/10/15.
//  Copyright (c) 2015 Tony Dakhoul. All rights reserved.
//

#import "Post.h"

@implementation Post

-(instancetype)initWithPostObject:(PFObject *)post {

    self = [super init];

    if (self) {

//        [post fetchIfNeeded];
        PFUser *user = post[@"user"];
        [user fetchIfNeeded];
        self.user = user;
        self.imagePFFile = post[@"image"];
        self.dateCreated = post[@"createdAd"];


    }

    return self;
}

@end
