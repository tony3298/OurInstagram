//
//  Like.m
//  OurInstagram
//
//  Created by David Seitz Jr on 6/10/15.
//  Copyright (c) 2015 Tony Dakhoul. All rights reserved.
//

#import "Like.h"

@implementation Like

-(instancetype)initWithLikeObject:(PFObject *)like {

    self = [super init];

    if (self) {

        self.user = like[@"user"];
        self.post = like[@"post"];
    }

    return self;
}

@end
