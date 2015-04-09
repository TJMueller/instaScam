//
//  HomeDetailViewController.h
//  instaScam
//
//  Created by Ben Whitley on 4/7/15.
//  Copyright (c) 2015 Timothy Mueller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"

@interface HomeDetailViewController : UIViewController

@property Post *post;
@property NSArray *likesArray;
@property NSArray *commentsArray;

@end
