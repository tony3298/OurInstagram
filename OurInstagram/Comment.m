//
//  Comment.m
//  OurInstagram
//
//  Created by David Seitz Jr on 6/10/15.
//  Copyright (c) 2015 Tony Dakhoul. All rights reserved.
//

#import "Comment.h"

@implementation Comment

-(instancetype)initWithCommentObject:(PFObject *)comment {

    self = [super init];

    if (self) {

        self.user = comment[@"user"];
        self.post = comment[@"post"];
        self.commentText = comment[@"commentText"];
        self.dateCreated = comment[@"createdAt"];
    }

    return self;
}

@end
