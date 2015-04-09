//
//  ProfileViewController.m
//  instaScam
//
//  Created by Ben Whitley on 4/8/15.
//  Copyright (c) 2015 Timothy Mueller. All rights reserved.
//

#import "ProfileViewController.h"
#import "ProfileCollectionViewCell.h"
#import <Parse/Parse.h>
#import "Person.h"

@interface ProfileViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *profilePicImageView;
@property (weak, nonatomic) IBOutlet UILabel *fullNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *postsLabel;
@property (weak, nonatomic) IBOutlet UILabel *followersLabel;
@property (weak, nonatomic) IBOutlet UILabel *followingLabel;
@property (strong, nonatomic) IBOutlet UITextView *bioLabel;


@end

@implementation ProfileViewController

@synthesize collectionView;

- (void)viewDidLoad {
    [super viewDidLoad];
    postsArray = [NSMutableArray new];
}

-(void)viewDidAppear:(BOOL)animated{
    PFUser *user = [PFUser currentUser];
    PFQuery *query = [Person query];
    NSLog(@"%@", user.username);
    [query whereKey:@"userName" equalTo:user.username];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (objects.count == 0) {
        } else {
        Person *person = objects[0];
        self.followersLabel.text = [NSString stringWithFormat:@"Followers: %lu", (unsigned long)person.followers.count];
        self.followingLabel.text = [NSString stringWithFormat:@"Following: %lu", (unsigned long)person.following.count];
        self.postsLabel.text = [NSString stringWithFormat:@"Posts: %lu", (unsigned long)person.posts.count];
        [person.profilePic getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if (!error) {
                self.profilePicImageView.image = [UIImage imageWithData:data];
            } else {
                NSLog(@"%@", error);
            }
        }];
        }
    }];
    self.bioLabel.text = user[@"bio"];
    self.fullNameLabel.text = user[@"fullName"];
    [self getPosts];
    [collectionView reloadData];
    collectionView.delegate = self;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)getPosts
{
    PFUser *user = [PFUser currentUser];
    PFQuery *personQuery = [Person query];
    [personQuery whereKey:@"userName" equalTo:user.username];
    PFQuery *query = [Post query];

    [query whereKey:@"personID" equalTo:[PFUser currentUser].objectId.description];

    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
     {
         if(!error) {
             for (Post *post in objects) {
                 [postsArray addObject:post];
                 [collectionView reloadData];
             }
         } else {
             NSLog(@"%@", error.description);
         }
     }];


}
- (IBAction)logOutButtonPressed:(id)sender {
    [PFUser logOut];
    //[self performSegueWithIdentifier:@"login" sender:self];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [postsArray count];
}

- (ProfileCollectionViewCell *)collectionView:(UICollectionView *)collectionViewType cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ProfileCollectionViewCell *cell = [collectionViewType dequeueReusableCellWithReuseIdentifier:@"CellID" forIndexPath:indexPath];

    Post *post = postsArray[indexPath.row];

    cell.imageView.image = [post convertToImage];

    return cell;
}

- (IBAction)logOutButtonPressed:(id)sender {
    [PFUser logOut];
    [self performSegueWithIdentifier:@"login" sender:self];
}



@end
