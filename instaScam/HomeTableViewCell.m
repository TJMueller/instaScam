//
//  HomeTableViewCell.m
//  instaScam
//
//  Created by Ben Whitley on 4/7/15.
//  Copyright (c) 2015 Timothy Mueller. All rights reserved.
//

#import "HomeTableViewCell.h"

@implementation HomeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)likeButtonPressed:(id)sender {
    [self.delegate homeTableViewCell:self didTapLikeButton:sender];
}

- (IBAction)commentButtonPressed:(id)sender {
    [self.delegate homeTableViewCell:self didTapCommentButton:sender];
}

@end