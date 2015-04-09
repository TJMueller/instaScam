//
//  Post.h
//  instaScam
//
//  Created by Timothy Mueller on 4/8/15.
//  Copyright (c) 2015 Timothy Mueller. All rights reserved.
//

#import <Parse/Parse.h>
#import "Person.h"

@interface Post : PFObject<PFSubclassing>

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) PFUser *user;
@property (nonatomic, strong) PFFile *mediaData;
@property (nonatomic, strong) NSArray *likes;
@property (nonatomic, strong) NSArray *tags;
@property (nonatomic, strong) NSArray *comments;
@property (nonatomic, strong) NSString *personID;


+ (instancetype)createPostWithPhoto:(UIImage *)photo;

+ (NSString *)parseClassName;

- (UIImage *)convertToImage;

@end