//
//  Comment.m
//  instaScam
//
//  Created by Timothy Mueller on 4/8/15.
//  Copyright (c) 2015 Timothy Mueller. All rights reserved.
//

#import "Comment.h"
#import <parse/PFObject+Subclass.h>
@implementation Comment
@dynamic commentText;
@dynamic user;
@dynamic post;


+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"Comment";
}
@end
