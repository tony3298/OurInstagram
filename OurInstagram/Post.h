//
//  Post.h
//  OurInstagram
//
//  Created by David Seitz Jr on 6/10/15.
//  Copyright (c) 2015 Tony Dakhoul. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface Post : NSObject

@property PFFile *imagePFFile;
@property NSString *postID;
@property NSString *userID;
@property NSDate *dateCreated;

@end
