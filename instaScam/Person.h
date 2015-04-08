//
//  Person.h
//  instaScam
//
//  Created by Timothy Mueller on 4/8/15.
//  Copyright (c) 2015 Timothy Mueller. All rights reserved.
//

#import <Parse/Parse.h>

@interface Person : PFObject<PFSubclassing>


@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *bio;
@property (nonatomic, strong) NSString *fullName;
@property (nonatomic, strong) NSString *email;

@property (nonatomic, strong) PFFile *profilePic;

@property (nonatomic, strong) PFUser *user;
@property (nonatomic, strong) NSArray *posts;
@property (nonatomic, strong) NSArray *following;
@property (nonatomic, strong) NSArray *followers;


+ (NSString *)parseClassName;



@end
