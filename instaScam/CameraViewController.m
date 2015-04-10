//
//  CameraViewController.m
//  instaScam
//
//  Created by Ben Whitley on 4/8/15.
//  Copyright (c) 2015 Timothy Mueller. All rights reserved.
//

#import "CameraViewController.h"
#import "HomeViewController.h"

#import "Post.h"

@interface CameraViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Oops!"
                                                       message:@"Sorry, seems like your device has no camera."
                                                      delegate:nil
                                             cancelButtonTitle:@"OK"
                                             otherButtonTitles:nil];
        [alert show];
    }
}

#pragma mark ----------------- Actions -------------------------------

- (IBAction)onTakePictureButtonTapped:(id)sender {
    UIImagePickerController *picker = [UIImagePickerController new];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.allowsEditing = YES;
    [picker setNavigationBarHidden:YES animated:YES];

    [self presentViewController:picker animated:YES completion:nil];
}

- (IBAction)onPostButtonPrest:(id)sender {
    Post *post = [Post createPostWithPhoto:self.postingImageView.image];
    //post.comments = [[NSArray alloc]initWithObjects:self.commentTextField.text, nil ];
    post.personID = [PFUser currentUser].objectId;
    post.title = self.commentTextField.text;
    [post save];
}


- (IBAction)onChoosePictureButtonTapped:(id)sender {
    UIImagePickerController *picker = [UIImagePickerController new];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;

    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark -------- UIImagePickerController Methods -----------

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];

    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {

        UIImage *editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
        UIImageWriteToSavedPhotosAlbum(editedImage, nil, nil, nil);
        self.postingImageView.image = editedImage;
    }

    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{

    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark ---------- Navigation -------------

// - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//      UITabBarController *vc = segue.destinationViewController
//     vc = segue.destinationViewController;
//}

@end