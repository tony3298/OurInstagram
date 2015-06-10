//
//  Comment.h
//  OurInstagram
//
//  Created by David Seitz Jr on 6/10/15.
//  Copyright (c) 2015 Tony Dakhoul. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Comment : NSObject

@property NSString *postID;
@property NSString *commentText;
@property NSString *authorUserID;
@property NSDate *dateCreated;

@end
