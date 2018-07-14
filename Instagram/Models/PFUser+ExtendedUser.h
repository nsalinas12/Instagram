//
//  PFUser+ExtendedUser.h
//  Instagram
//
//  Created by Nico Salinas on 7/12/18.
//  Copyright © 2018 Nico Salinas. All rights reserved.
//

#import "PFUser.h"
#import "Parse/Parse.h"
#import "ParseUI.h"

@interface PFUser (ExtendedUser)

@property (strong, nonatomic ) PFFile *profilePicture;
@property (strong, nonatomic ) NSString *biography;

@end
