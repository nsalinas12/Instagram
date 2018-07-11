//
//  ComposeViewController.h
//  Instagram
//
//  Created by Nico Salinas on 7/9/18.
//  Copyright © 2018 Nico Salinas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"

@protocol ComposeViewControllerDelegate

- (void) didPost: (Post *)post;

@end


@interface ComposeViewController : UIViewController

@property (nonatomic, weak) id<ComposeViewControllerDelegate> delegate;

@end
