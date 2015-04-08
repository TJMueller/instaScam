//
//  HomeViewController.m
//  instaScam
//
//  Created by Ben Whitley on 4/7/15.
//  Copyright (c) 2015 Timothy Mueller. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeDetailViewController.h"
#import "HomeTableViewCell.h"

@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource>

@property NSArray *postsArray;
@property (weak, nonatomic) IBOutlet UITableView *homeTableView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

#pragma mark - TableView Delegates

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
    //    return self.postsArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];

    cell.backgroundColor = [UIColor blackColor];
    cell.homeCellImageView.image = [UIImage imageNamed:@"bluestar"];

    return  cell;
}

-(IBAction)unwindFromSegue:(UIStoryboardSegue *)segue {
    
}

@end