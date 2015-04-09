//
//  HomeViewController.m
//  instaScam
//
//  Created by Ben Whitley on 4/7/15.
//  Copyright (c) 2015 Timothy Mueller. All rights reserved.
//

#import <Parse/Parse.h>

#import "HomeViewController.h"
#import "HomeDetailViewController.h"
#import "HomeTableViewCell.h"
#import "Post.h"

@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource>

@property NSArray *postsArray;
@property (weak, nonatomic) IBOutlet UITableView *homeTableView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getPosts];
}

- (void)gotPostData:(NSArray *)data {
    self.postsArray = data;
    [self.homeTableView reloadData];
}

- (void)getPosts {
    PFQuery *query = [Post query];
    NSMutableArray *posts = [NSMutableArray new];

    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSLog(@"objects.count == %li", objects.count);
        NSLog(@"error == %@", error);
        if (!error) {
            for (Post *post in objects) {
                [posts addObject:post];
                NSLog(@"post.objectId == %@",post.objectId);
            }

            self.postsArray = [NSArray arrayWithArray:posts];
            [self.homeTableView reloadData];
        } else {
            NSLog(@"%@", error);
        }
    }];
}

#pragma mark - TableView Delegates

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.postsArray.count;
}

-(HomeTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    Post *post = self.postsArray[indexPath.row];

    cell.homeCellImageView.image = [post convertToImage];
    cell.backgroundColor = [UIColor blackColor];

    return  cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [self.homeTableView indexPathForSelectedRow];
    Post *post = self.postsArray[indexPath.row];

    HomeDetailViewController *homeDetailVC = segue.destinationViewController;
    homeDetailVC.post = post;
}

-(IBAction)unwindFromSegue:(UIStoryboardSegue *)segue {
    
}

@end