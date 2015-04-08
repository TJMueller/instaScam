//
//  Person.m
//  instaScam
//
//  Created by Timothy Mueller on 4/8/15.
//  Copyright (c) 2015 Timothy Mueller. All rights reserved.
//

#import "Person.h"
#import <parse/PFObject+Subclass.h>

@implementation Person
@dynamic userName;
@dynamic bio;
@dynamic posts;
@dynamic user;
@dynamic fullName;
@dynamic email;
@dynamic followers;
@dynamic following;
@dynamic profilePic;



+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"Person";
}
@end
