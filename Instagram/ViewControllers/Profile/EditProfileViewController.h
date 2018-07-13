//
//  EditProfileViewController.h
//  Instagram
//
//  Created by Nico Salinas on 7/12/18.
//  Copyright © 2018 Nico Salinas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Parse.h"
#import "ParseUI.h"

@interface EditProfileViewController : UIViewController

-(PFFile *)getPFFileFromImage: (UIImage * _Nullable)image;

@end
