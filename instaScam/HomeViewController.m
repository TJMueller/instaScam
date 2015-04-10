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
#import "Comment.h"

@interface HomeViewController () <UITableViewDelegate, UITableViewDataSource, HomeTableViewCellDelegate>


@property NSArray *postsArray;
@property Person *person;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];


}
-(void)viewWillAppear:(BOOL)animated{
    PFQuery *query =[Person query];
    [query whereKey:@"userID" equalTo:[PFUser currentUser].objectId];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            self.person = objects[0];
            [self getPosts];
//            PFQuery *query1 = [Person query];
//            [query1 whereKey:@"userID" containedIn:self.person.following];
        }

    }];
}

- (void)getPosts {
    PFQuery *query = [Post query];
    NSMutableArray *posts = [NSMutableArray new];
    [query whereKey:@"personID" containedIn:self.person.following];
    [query orderByAscending:@"createdAt"];
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
    cell.indexPathRow = indexPath.row;
    cell.delegate = self;
    Post *post = self.postsArray[indexPath.row];

    cell.homeCellImageView.image = [post convertToImage];
    cell.userLabel.text = post.title;

    return cell;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    NSIndexPath *indexPath = [self.homeTableView indexPathForSelectedRow];
    Post *post = self.postsArray[indexPath.row];

    HomeDetailViewController *homeDetailVC = segue.destinationViewController;
    homeDetailVC.post = post;

    if ([segue.identifier  isEqual: @"CommentsSegue"]) {
        homeDetailVC.Comments = TRUE;
    } else {
        homeDetailVC.Comments = false;
    }
}

-(IBAction)unwindFromSegue:(UIStoryboardSegue *)segue {
    
}


//somehow need to integrate NSIndexPath to tell which post to add the comment to; same for the liking an image
- (void)homeTableViewCell:(id)cell didTapCommentButton:(UIButton *)button atRow:(NSInteger)row {

    Post *post = self.postsArray[row];
    UIAlertController *commentController = [UIAlertController alertControllerWithTitle:@"Add comment" message:nil preferredStyle:UIAlertControllerStyleAlert];

    [commentController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        nil;
    }];

    UIAlertAction *commentAction = [UIAlertAction actionWithTitle:@"Okay"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction *action) {

                                                              UITextField *textField = commentController.textFields.firstObject;
                                                              Comment *comment = [Comment object];
                                                              [comment createComment:comment WithString:textField.text];
                                                              //                                                              comment.personID = [PFUser currentUser].objectId;
                                                              //                                                              [comment save];
                                                              NSString *formattedComment = [NSString stringWithFormat:@"%@: %@",[PFUser currentUser].username, comment.commentText];
                                                              [post addObject:formattedComment forKey:@"comments"];
                                                              [post save];
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

- (void)homeTableViewCell:(HomeTableViewCell *)cell didTapLikeButton:(UIButton *)button {
    
    Post *post = self.postsArray[cell.indexPathRow];
    PFUser *user = [PFUser currentUser];

    if(!post.likes) {
        post.likes = @[];
    }

    NSMutableArray *likes = [NSMutableArray arrayWithArray:post.likes];

    if (![likes containsObject:user.username]) {
        [likes addObject:user.username];
    } else {
        [likes removeObject:user.username];

    }

    post.likes = [NSArray arrayWithArray:likes];
    [post save];
}

@end