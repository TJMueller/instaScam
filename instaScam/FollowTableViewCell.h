//
//  FollowTableViewCell.h
//  instaScam
//
//  Created by Ben Whitley on 4/10/15.
//  Copyright (c) 2015 Timothy Mueller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Person.h"
@protocol FollowTableViewCellDelegate <NSObject>

@optional

- (void)FollowTableViewCell:(id)cell didTapRollowButton:(UIButton *)button atRow:(NSInteger)row person:(Person *)person;

@end


@interface FollowTableViewCell : UITableViewCell

@property (nonatomic, assign) id <FollowTableViewCellDelegate> delegate;
@property NSInteger indexPathRow;
@property BOOL following;
@property Person *person;

@end
