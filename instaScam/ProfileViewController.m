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
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IBOutlet UITextView *bioLabel;

@property NSArray *postsArray;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.postsArray = [NSArray new];
}

-(void)viewWillAppear:(BOOL)animated{
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

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)logOutButtonPressed:(id)sender {
    [PFUser logOut];
    //[self performSegueWithIdentifier:@"login" sender:self];
}

- (ProfileCollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ProfileCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CellID" forIndexPath:indexPath];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.postsArray.count;
}

@end
