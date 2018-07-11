//
//  DetailsViewController.h
//  Instagram
//
//  Created by Nico Salinas on 7/10/18.
//  Copyright © 2018 Nico Salinas. All rights reserved.
//

#import "FeedTableViewController.h"
#import "UIKit/UIKit.h"
#import "FeedCell.h"
#import "Post.h"

@protocol DetailsViewControllerDelegate;

@interface DetailsViewController : UIViewController


@property (weak, nonatomic) id<DetailsViewControllerDelegate> delegate;
@property (weak, nonatomic) Post *post;

- (void) loadPost;

@end
