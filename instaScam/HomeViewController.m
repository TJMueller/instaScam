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

@property NSArray *postsArray;
@property (weak, nonatomic) IBOutlet UITableView *homeTableView;
@property Person *person;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.person = [Person new];
    self.person.userName = @"blw305";
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.postsArray.count;
}

-(HomeTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    Post *post = self.postsArray[indexPath.row];

    cell.userLabel.text = self.person.userName;
    cell.homeCellImageView.image = [post convertToImage];

    return cell;
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [self.homeTableView indexPathForSelectedRow];
    Post *post = self.postsArray[indexPath.row];

    HomeDetailViewController *homeDetailVC = segue.destinationViewController;
    homeDetailVC.post = post;
}

-(IBAction)unwindFromSegue:(UIStoryboardSegue *)segue {
    
}

- (void)homeTableViewCell:(id)cell didTapCommentButton:(UIButton *)button {
    UIAlertController *commentController = [UIAlertController alertControllerWithTitle:@"Add comment" message:nil preferredStyle:UIAlertControllerStyleAlert];

    [commentController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        nil;
    }];

    UIAlertAction *commentAction = [UIAlertAction actionWithTitle:@"Okay"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction *action) {

                                                              //                                   UITextField *textField = commentController.textFields.firstObject;
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