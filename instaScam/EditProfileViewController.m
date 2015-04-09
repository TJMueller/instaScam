//
//  EditProfileViewController.m
//  instaScam
//
//  Created by Ben Whitley on 4/8/15.
//  Copyright (c) 2015 Timothy Mueller. All rights reserved.
//

#import "EditProfileViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <Parse/Parse.h>
#import "Person.h"

@interface EditProfileViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *bioTextField;

@end

@implementation EditProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    PFUser *user = [PFUser currentUser];
    self.nameTextField.text = [user objectForKey:@"fullName"];
    self.emailTextField.text = [user objectForKey:@"email"];
    self.bioTextField.text = [user objectForKey:@"bio"];
    self.userNameTextField.text = user.username;}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveEditsPressed:(UIButton *)sender {
    PFUser *user = [PFUser currentUser];
    PFQuery *query = [Person query];
    [query whereKey:@"userName" equalTo:user.username];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (objects.count == 0) {
        } else {
            Person *person = objects[0];
            person.userName = self.userNameTextField.text;
            person.bio = self.bioTextField.text;
            person.email = self.emailTextField.text;
            person.fullName = self.nameTextField.text;
        }
    }];
    user [@"fullName"] = self.nameTextField.text;
    user.email = self.emailTextField.text;
    user[@"bio"] = self.bioTextField.text;
    user.username = self.userNameTextField.text;
    [user save];

    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(IBAction)onEditPhotoPressed:(id)sender{
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

    [self presentViewController:picker animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];

    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {

        UIImage *editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
        UIImageWriteToSavedPhotosAlbum(editedImage, nil, nil, nil);
        PFUser *user = [PFUser currentUser];
        PFQuery *query = [Person query];
        [query whereKey:@"userName" equalTo:user.username];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (objects.count == 0) {
            } else {
                Person *person = objects[0];
                NSData *photoData = UIImageJPEGRepresentation(editedImage, 0.8f);
                person.profilePic = [PFFile fileWithData:photoData];
                [person saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {

                }];
            }
        }];

    }

    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{

    [picker dismissViewControllerAnimated:YES completion:nil];
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
