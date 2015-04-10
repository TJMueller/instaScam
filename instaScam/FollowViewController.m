//
//  FollowViewController.m
//  instaScam
//
//  Created by Ben Whitley on 4/10/15.
//  Copyright (c) 2015 Timothy Mueller. All rights reserved.
//

#import "FollowViewController.h"
#import "Person.h"
#import <Parse/Parse.h>
#import "FollowTableViewCell.h"

@interface FollowViewController () <UITableViewDelegate, UITableViewDataSource,FollowTableViewCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property NSArray *persons;
@property Person *person;
@property NSMutableArray *activeArray;

@end

@implementation FollowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated {
    PFQuery *query = [Person query];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        self.persons = objects;
        [self.tableView reloadData];
    }];
    PFQuery *query1 = [Person query];
    [query1 whereKey:@"userID" equalTo:[PFUser currentUser].objectId];
    [query1 findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        self.person = objects[0];
        self.activeArray = [[NSMutableArray alloc] initWithArray:self.person.following];
        [self.tableView reloadData];
    }];
}

-(void)FollowTableViewCell:(FollowTableViewCell *)cell didTapRollowButton:(UIButton *)button atRow:(NSInteger)row person:(Person *)person{
    NSLog(@"%li", (long)row);
    if (cell.following) {
        [self.activeArray removeObject:person.userID];
    } else {
        [self.activeArray addObject:person.userID];
    }
    cell.following = !cell.following;

    [self.tableView reloadData];
}




-(void)viewWillDisappear:(BOOL)animated {
    self.person.following = self.activeArray;
    [self.person save];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.persons.count;
}

-(FollowTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FollowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    cell.indexPathRow = indexPath.row;
    cell.person = self.persons[indexPath.row];
    cell.delegate = self;
    Person *person = self.persons[indexPath.row];
    if ([self.activeArray containsObject:person.userID]){
        cell.following = true;
    }
    cell.textLabel.text = person.userName;
    if (cell.following) {
        cell.backgroundColor = [UIColor greenColor];
    } else {
        cell.backgroundColor = [UIColor whiteColor];
    }
    return cell;

}

@end
