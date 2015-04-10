//
//  FollowViewController.m
//  instaScam
//
//  Created by Ben Whitley on 4/10/15.
//  Copyright (c) 2015 Timothy Mueller. All rights reserved.
//

#import "FollowViewController.h"

@interface FollowViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation FollowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}



@end
