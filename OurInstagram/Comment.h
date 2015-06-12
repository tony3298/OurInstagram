//
//  Comment.h
//  OurInstagram
//
//  Created by David Seitz Jr on 6/10/15.
//  Copyright (c) 2015 Tony Dakhoul. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface Comment : NSObject

@property PFObject *post;
@property NSString *commentText;
@property PFUser *user;
@property NSDate *dateCreated;

-(instancetype)initWithCommentObject:(PFObject *)comment;

@end
