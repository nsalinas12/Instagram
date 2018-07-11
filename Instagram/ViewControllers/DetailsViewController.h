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


@interface DetailsViewController : UIViewController

@property (weak, nonatomic) Post *post;

- (void) loadPost;

@end
