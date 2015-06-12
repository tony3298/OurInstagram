//
//  Like.h
//  OurInstagram
//
//  Created by David Seitz Jr on 6/10/15.
//  Copyright (c) 2015 Tony Dakhoul. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface Like : NSObject

@property PFUser *user;
@property PFObject *post;

-(instancetype)initWithLikeObject:(PFObject *)like;

@end