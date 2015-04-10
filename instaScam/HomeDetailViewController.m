//
//  HomeDetailViewController.m
//  instaScam
//
//  Created by Ben Whitley on 4/7/15.
//  Copyright (c) 2015 Timothy Mueller. All rights reserved.
//

#import "HomeDetailViewController.h"
#import "Person.h"
#import "Comment.h"

@interface HomeDetailViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property BOOL likesOrComments;

@end

@implementation HomeDetailViewController

//  TO-DO: populate this tableview with either comments or users who have like the selected photo

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.navigationItem.title = self.post.objectId;
    NSLog(@"%@", self.commentsArray.firstObject);
}

//- (void)getComments {
//    PFQuery *query = [Post query];
//    NSMutableArray *comments = [NSMutableArray new];
//
//    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        if (!error) {
//            for (Comment *comment in objects) {
//                [comments addObject:comment];
//            }
//
//            self.commentsArray = [NSArray arrayWithArray:comments];
//            [self.tableView reloadData];
//        } else {
//            NSLog(@"%@", error);
//        }
//    }];
//}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

//    if (self.likesOrComments) {
//        return self.likesArray.count;
//    } else {
//        return self.commentsArray.count;
//    }
    return self.post.comments.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
//    Comment *comment = self.commentsArray[indexPath.row];
//    NSLog(@"%@", comment.objectId);
    cell.textLabel.text = self.post.comments[indexPath.row];
    return cell;
}

@end