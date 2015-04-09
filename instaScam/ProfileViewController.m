//
//  ProfileViewController.m
//  instaScam
//
//  Created by Ben Whitley on 4/8/15.
//  Copyright (c) 2015 Timothy Mueller. All rights reserved.
//

#import "ProfileViewController.h"
#import <Parse/Parse.h>
#import "Person.h"

@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profilePicImageView;
@property (weak, nonatomic) IBOutlet UILabel *fullNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *postsLabel;
@property (weak, nonatomic) IBOutlet UILabel *followersLabel;
@property (weak, nonatomic) IBOutlet UILabel *followingLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    PFUser *user = [PFUser currentUser];
    PFQuery *query = [Person query];
    NSLog(@"%@", user.username);
    [query whereKey:@"userName" equalTo:user.username];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
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
    }];

    self.fullNameLabel.text = user[@"fullName"];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)logOutButtonPressed:(id)sender {
//    [PFUser logOut];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
