//
//  ProfileViewController.h
//  Instagram
//
//  Created by Nico Salinas on 7/12/18.
//  Copyright © 2018 Nico Salinas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParseUI.h"
#import "Parse/Parse.h"

@interface ProfileViewController : UIViewController

@property (strong, nonatomic) PFUser *user;

@end
