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
#import "Person.h"

@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *homeTableView;

@property NSArray *postsArray;
@property Person *person;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getPosts];
}

- (void)getPosts {
    PFQuery *query = [Post query];
    NSMutableArray *posts = [NSMutableArray new];

    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            for (Post *post in objects) {
                [posts addObject:post];
            }

            self.postsArray = [NSArray arrayWithArray:posts];
            [self.homeTableView reloadData];
        } else {
            NSLog(@"%@", error);
        }
    }];
}

#pragma mark - TableView Delegates

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.postsArray.count;
}

-(HomeTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    
    cell.delegate = self;
    Post *post = self.postsArray[indexPath.row];

    cell.homeCellImageView.image = [post convertToImage];

    return cell;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    NSIndexPath *indexPath = [self.homeTableView indexPathForSelectedRow];
    Post *post = self.postsArray[indexPath.row];

    HomeDetailViewController *homeDetailVC = segue.destinationViewController;
    homeDetailVC.post = post;

    if ([segue.identifier  isEqual: @"LikesSegue"]) {
//        homeDetailVC.likesArray = //array of users who have "liked the post"
    } else {
//        homeDetailVC.commentsArray = //array of comments on the post, and the users who wrote those comments
    }
}

-(IBAction)unwindFromSegue:(UIStoryboardSegue *)segue {
    
}


//somehow need to integrate NSIndexPath to tell which post to add the comment to; same for the liking an image
- (void)homeTableViewCell:(id)cell didTapCommentButton:(UIButton *)button {
    UIAlertController *commentController = [UIAlertController alertControllerWithTitle:@"Add comment" message:nil preferredStyle:UIAlertControllerStyleAlert];

    [commentController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        nil;
    }];

    UIAlertAction *commentAction = [UIAlertAction actionWithTitle:@"Okay"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction *action) {

                                                              UITextField *textField = commentController.textFields.firstObject;
                                                              //                                   Comment *comment = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Comment class]) inManagedObjectContext:self.moc];
                                                              //                                   comment.comment = textField.text;
                                                          }];

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action) {
                                                             nil;
                                                         }];

    [commentController addAction:cancelAction];
    [commentController addAction:commentAction];

    [self presentViewController:commentController animated:YES completion:^{
        nil;
    }];
}

- (void)homeTableViewCell:(id)cell didTapLikeButton:(UIButton *)button {
    
}

@end