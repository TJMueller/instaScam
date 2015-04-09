//
//  HomeDetailViewController.m
//  instaScam
//
//  Created by Ben Whitley on 4/7/15.
//  Copyright (c) 2015 Timothy Mueller. All rights reserved.
//

#import "HomeDetailViewController.h"
#import "Person.h"

@interface HomeDetailViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property BOOL likesOrComments;
@property NSArray *likesArray;
@property NSArray *commentsArray;

@end

@implementation HomeDetailViewController

//  TO-DO: populate this tableview with either comments or users who have like the selected photo

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (self.likesOrComments) {
        return self.likesArray.count;
    } else {
        return self.commentsArray.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];

//    Person *person = self.likesArray[indexPath.row];

//    if (self.likesArray) {
//        cell.textLabel.text = person.userName;
//    } else {
//        cell.textLabel.text =
//    }

    return cell;
}

@end