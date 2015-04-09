//
//  Post.m
//  instaScam
//
//  Created by Timothy Mueller on 4/8/15.
//  Copyright (c) 2015 Timothy Mueller. All rights reserved.
//

#import "Post.h"
#import <parse/PFObject+Subclass.h>
#import "HomeViewController.h"

@implementation Post
@dynamic title;
@dynamic user;
@dynamic mediaData;
@dynamic likes;
@dynamic tags;
@dynamic comments;
@dynamic personID;

UIImage *image;

+ (instancetype)createPostWithPhoto:(UIImage *)photo
{
    Post *post = [Post object];
    if (post)
    {
        NSData *photoData = UIImageJPEGRepresentation(photo, 0.8f);
        post.mediaData = [PFFile fileWithData:photoData];
        PFUser *user = [PFUser currentUser];
        post.personID = user.objectId;

        //[post save];
    }
    return post;
}

- (UIImage *)convertToImage {
    NSLog(@"fetching image");
    return [UIImage imageWithData:[self.mediaData getData]];

}

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"Post";
}

@end