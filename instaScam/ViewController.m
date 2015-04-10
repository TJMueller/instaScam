//
//  ViewController.m
//  instaScam
//
//  Created by Timothy Mueller on 4/6/15.
//  Copyright (c) 2015 Timothy Mueller. All rights reserved.
//
// to do set up segues DAVE TEST


#import "ViewController.h"
#import "Person.h"

@interface ViewController ()<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *usernameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordConfirmationTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UIButton *logInButton;
@property (strong, nonatomic) IBOutlet UIButton *signUpButton;
@property BOOL signUp;
@property BOOL logIn;
@property BOOL shouldSignUp;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.passwordConfirmationTextField.alpha = 0;
    self.nameTextField.alpha = 0;
    self.emailTextField.alpha = 0;
    self.signUp = NO;
    self.logIn = YES;
    self.usernameTextField.delegate = self;
    self.passwordTextField.delegate = self;
    self.passwordConfirmationTextField.delegate = self;
    self.shouldSignUp = NO;

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.usernameTextField resignFirstResponder];
    [self.emailTextField resignFirstResponder];
    [self.passwordConfirmationTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    return YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    PFUser *user = [PFUser currentUser];
    if (user.username != nil) {
        self.shouldSignUp = YES;


//currentUser is our object
//        NSString *phone = [[PFUser currentUser] objectForKey:@"phone"];
//        NSLog(@"The number is %@", phone);

// posting a comment (with post pointer)
        //PFUser * user = [PFUser currentUser];
//        PFObject * comment = [PFObject objectWithClassName:@"Comment"];
//        PFObject * post = [PFObject objectWithClassName:@"Post"];
//        comment[@"commentText"] = @"a comment";
//        comment[@"post"]= post;
//        user[@"public"] = [NSNumber numberWithBool:YES];
//        post[@"user"] = user;

//        [user saveInBackground];
//        [post saveInBackground];
//        [comment saveInBackground];



//        PFQuery *commentQuery = [PFQuery queryWithClassName:@"Comment"];
//        [commentQuery includeKey:@"post.objectId"];
//
//
//        [commentQuery findObjectsInBackgroundWithBlock:^(NSArray *newsObjects, NSError *error)
//        {
//            if( !error )
//            {
//                NSLog(@"%@", newsObjects);
//                NSArray *queryArray = [[PFUser currentUser] objectForKeyedSubscript:@"posts"];
//                //NSLog(@"query array %@",queryArray[0]);
//                
//                NSString *user5 = [queryArray[0] objectForKey:@"user"];
//                NSLog(@"The user.............. is %@", user5);
//            }
//        }];





        // to log out
        
        //[PFUser logOut];

        [self performSegueWithIdentifier:@"login" sender:self];
    }
}
-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    [self checkFieldsComplete];
    return self.shouldSignUp;

}

- (IBAction)onLogInButtonPressed:(id)sender {
    [self.usernameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    if (self.logIn) {
        [PFUser logInWithUsernameInBackground:self.usernameTextField.text password:self.passwordTextField.text block:^(PFUser *user, NSError *error) {
            if (!error) {
                NSLog(@"Login user!");
                self.usernameTextField.text = nil;
                self.passwordTextField.text = nil;
                self.shouldSignUp = YES;
                [self performSegueWithIdentifier:@"login" sender:self];
            }
            if (error) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ooops!" message:@"Sorry we had a problem logging you in" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
        }];
    }else {
        self.passwordConfirmationTextField.alpha = 0;
        self.nameTextField.alpha = 0;
        self.emailTextField.alpha = 0;
        self.signUp = !self.signUp;
        self.logIn = !self.logIn;
    }
}

- (IBAction)onSignUpButtonPressed:(id)sender {
    
    [self.usernameTextField resignFirstResponder];
    [self.emailTextField resignFirstResponder];
    [self.passwordConfirmationTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    self.passwordConfirmationTextField.alpha = 1;
    self.nameTextField.alpha = 1;
    self.emailTextField.alpha = 1;
    //self.logInButton.alpha = 0;
    if (self.signUp) {
        [self checkFieldsComplete];
    }
    self.signUp = !self.signUp;
    self.logIn = !self.logIn;

}

- (void) checkFieldsComplete { 
    if ([self.usernameTextField.text isEqualToString:@""] || [self.emailTextField.text isEqualToString:@""] || [self.passwordTextField.text isEqualToString:@""] || [self.passwordConfirmationTextField.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oooopss!" message:@"You need to complete all fields" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else {
        [self checkPasswordsMatch];
    }
}

- (void) checkPasswordsMatch {
    if (![self.passwordTextField.text isEqualToString:self.passwordConfirmationTextField.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oooopss!" message:@"Passwords don't match" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else {
        [self registerNewUser];
    }
}

- (void) registerNewUser {
    NSLog(@"registering....");
    PFUser *newUser = [PFUser user];
    newUser.username = self.usernameTextField.text;
    newUser.email = self.emailTextField.text;
    newUser.password = self.passwordTextField.text;


    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            NSLog(@"Registration success!");
            PFObject * person = [PFObject objectWithClassName:@"Person"];
            person[@"email"] = self.emailTextField.text;
            person[@"userName"] = self.usernameTextField.text;
            person[@"userID"] = newUser.objectId;
            [person save];
            self.shouldSignUp = YES;
            [self performSegueWithIdentifier:@"login" sender:self];
        }
        else {
            NSLog(@"%@", error.description);
            NSLog(@"There was an error in registration");
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)unwindFromLogOut:(UIStoryboardSegue *)segue {

}

@end
