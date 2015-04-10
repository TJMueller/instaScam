//
//  FollowTableViewCell.m
//  instaScam
//
//  Created by Ben Whitley on 4/10/15.
//  Copyright (c) 2015 Timothy Mueller. All rights reserved.
//

#import "FollowTableViewCell.h"

@implementation FollowTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)followButtonPressed:(UIButton *)sender {
    [self.delegate FollowTableViewCell:self didTapRollowButton:sender atRow:self.indexPathRow person:self.person];
}

@end
