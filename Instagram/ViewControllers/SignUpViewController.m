//
//  SignUpViewController.m
//  Instagram
//
//  Created by Nico Salinas on 7/9/18.
//  Copyright © 2018 Nico Salinas. All rights reserved.
//

#import "SignUpViewController.h"
#import "Parse/Parse.h"
#import "LoginViewController.h"
#import "FeedTableViewController.h"

@interface SignUpViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)registerUser  {
    // initialize a user object
    PFUser *newUser = [PFUser user];
    
    // set user properties
    newUser.username = self.usernameField.text;
    newUser.email = self.emailField.text;
    newUser.password = self.passwordField.text;
    
    // call sign up function on the object
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        } else {
            NSLog(@"User registered successfully");
            
            // manually segue to logged in view
        }
    }];
}

- (IBAction)onTapRegister:(id)sender {
    
    [self registerUser];
    
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ( [segue.identifier isEqualToString:@"segueToLoginViewController"]  ){
        
        NSLog(@"Working!");
        
        LoginViewController *loginViewController = [segue destinationViewController];
        loginViewController.delegate = self;
        
        
    
    } else if ( [segue.identifier isEqualToString:@"segueToFeedTableViewController"] ){
        NSLog( @"Test" );
        
        UINavigationController *navigationController = [segue destinationViewController];
        FeedTableViewController *feedTableViewController = (FeedTableViewController*) navigationController.topViewController;
        feedTableViewController.delegate = self;
    }
}

@end
