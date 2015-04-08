//
//  CameraViewController.h
//  instaScam
//
//  Created by Ben Whitley on 4/8/15.
//  Copyright (c) 2015 Timothy Mueller. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface CameraViewController : UIViewController
- (IBAction)onTakePictureButtonTapped:(id)sender;
- (IBAction)onPostButtonPrest:(id)sender;
- (IBAction)onChoosePictureButtonTapped:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *postingImageView;
@property (weak, nonatomic) IBOutlet UITextField *commentTextField;

@end
