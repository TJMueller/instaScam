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

    // Configure the view for the selected state
}

// TO-DO "Likes" button --> might trigger a segue; check out instagram for example

- (IBAction)onLikeButtonPressed:(UIButton *)sender {

}

- (IBAction)onCommentButtonPressed:(UIButton *)sender {

}

@end