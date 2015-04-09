//
//  ProfileViewController.h
//  instaScam
//
//  Created by Ben Whitley on 4/8/15.
//  Copyright (c) 2015 Timothy Mueller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileCollectionViewCell.h"
#import "Post.h"

@interface ProfileViewController : UIViewController{
    NSMutableArray *postsArray;
}

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end
