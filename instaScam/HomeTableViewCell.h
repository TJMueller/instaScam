//
//  HomeTableViewCell.h
//  instaScam
//
//  Created by Ben Whitley on 4/7/15.
//  Copyright (c) 2015 Timothy Mueller. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HomeTableViewCellDelegate <NSObject>

@optional

- (void)homeTableViewCell:(id)cell didTapCommentButton:(UIButton *)button;
- (void)homeTableViewCell:(id)cell didTapLikeButton:(UIButton *)button;

@end

@interface HomeTableViewCell : UITableViewCell

@property (nonatomic, assign) id <HomeTableViewCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *homeCellImageView;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;

//- (IBAction)likeButtonPressed:(UIButton *)sender;
//
//- (IBAction)commentButtonPressed:(UIButton *)sender;

@end
