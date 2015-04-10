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

- (void)getIndexPath:(NSIndexPath *)indexPath;
- (void)homeTableViewCell:(id)cell didTapCommentButton:(UIButton *)button atRow:(NSInteger)row;
- (void)homeTableViewCell:(id)cell didTapLikeButton:(UIButton *)button;

@end

@interface HomeTableViewCell : UITableViewCell

@property (nonatomic, assign) id <HomeTableViewCellDelegate> delegate;
@property NSInteger indexPathRow;
@property (weak, nonatomic) IBOutlet UIImageView *homeCellImageView;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;

@end
