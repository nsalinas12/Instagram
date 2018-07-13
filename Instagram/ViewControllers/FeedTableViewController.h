//
//  FeedTableViewController.h
//  Instagram
//
//  Created by Nico Salinas on 7/9/18.
//  Copyright © 2018 Nico Salinas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"

@protocol FeedTableViewControllerDelegate;

@interface FeedTableViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *logoutButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *composeButton;
@property (strong, nonatomic) IBOutlet UITableView *feedTableView;
@property (strong, nonatomic) NSMutableArray *feedArray;

@property (weak, nonatomic) id<FeedTableViewControllerDelegate> delegate;

@end
