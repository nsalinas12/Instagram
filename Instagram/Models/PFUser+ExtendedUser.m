//
//  PFUser+ExtendedUser.m
//  Instagram
//
//  Created by Nico Salinas on 7/12/18.
//  Copyright © 2018 Nico Salinas. All rights reserved.
//

#import "PFUser+ExtendedUser.h"
#import "Parse/Parse.h"
#import "ParseUI.h"

@implementation PFUser (ExtendedUser)

- (void) setProfilePicture:(PFFile *)profilePicture{
    
    self[@"profilePicture"] = profilePicture;
}

- (PFFile *) profilePicture {
    return self[@"profilePicture"];
    
}


- (void) setBiography:(NSString *)biography{
    
    self[@"biography"] = biography;
}

- (NSString *) biography {
    
    return self[@"biography"];
    
}



@end
