//
//  SignUpViewController.h
//  Instagram
//
//  Created by Nico Salinas on 7/9/18.
//  Copyright © 2018 Nico Salinas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"

@protocol SignUpViewControllerDelegate;

@interface SignUpViewController : UIViewController

@property (nonatomic, weak) id<SignUpViewControllerDelegate> delegate;

@end
