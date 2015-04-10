//
//  Comment.h
//  instaScam
//
//  Created by Timothy Mueller on 4/8/15.
//  Copyright (c) 2015 Timothy Mueller. All rights reserved.
//

#import <Parse/Parse.h>
#import "Post.h"

@interface Comment : PFObject<PFSubclassing>


@property (nonatomic, strong) NSString *commentText;
@property (nonatomic, strong) NSString *postID;
@property (nonatomic, strong) NSString *personID;

+ (NSString *)parseClassName;

- (instancetype)createComment:(Comment *)comment WithString:(NSString *)commentText;

@end
