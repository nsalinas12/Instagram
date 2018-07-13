//
//  LoginViewController.m
//  Instagram
//
//  Created by Nico Salinas on 7/9/18.
//  Copyright © 2018 Nico Salinas. All rights reserved.
//

#import "LoginViewController.h"
#import "Parse/Parse.h"
#import "SignUpViewController.h"
#import "FeedTableViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *LogInButton;
@property (weak, nonatomic) IBOutlet UIButton *RegisterButton;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"Testing ns log function");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)loginUser  {
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
        } else {
            NSLog(@"User logged in successfully");
            
            // display view controller that needs to shown after successful login
        }
    }];
}


- (IBAction)onTapLogin:(id)sender {
    
    [self loginUser];
}





#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ( [segue.identifier isEqualToString:@"segueToSignUpViewController"]  ){
        
        NSLog(@"Segueing to Sign Up!");
        
        SignUpViewController *signUpViewController = [segue destinationViewController];
        //signUpViewController.delegate = self;
        
        
    } else if ( [segue.identifier isEqualToString:@"segueToTabBarController"] ){
        
        NSLog(@"Segueing to Feed!");
        
        UITabBarController *tabBarViewController=[segue destinationViewController];
        FeedTableViewController *feedTableViewController = (FeedTableViewController *)[tabBarViewController.viewControllers objectAtIndex:0];;
        
        feedTableViewController.delegate = self;
        
        
    }
}

@end
