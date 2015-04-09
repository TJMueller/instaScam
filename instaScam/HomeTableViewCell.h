//
//  HomeTableViewCell.h
//  instaScam
//
//  Created by Ben Whitley on 4/7/15.
//  Copyright (c) 2015 Timothy Mueller. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *homeCellImageView;

- (IBAction)likeButtonPressed:(UIButton *)sender;

- (IBAction)commentButtonPressed:(UIButton *)sender;

@end
