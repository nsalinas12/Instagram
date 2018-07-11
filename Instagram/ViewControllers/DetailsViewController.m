//
//  DetailsViewController.m
//  Instagram
//
//  Created by Nico Salinas on 7/10/18.
//  Copyright © 2018 Nico Salinas. All rights reserved.
//

#import "DetailsViewController.h"
#import "FeedCell.h"
#import "Post.h"
#import "FeedTableViewController.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet PFImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self loadPost];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loadPost {
    
    self.usernameLabel.text = self.post.author.username;
    
    self.mainImageView.file = self.post.image;
    
    self.captionLabel.text = self.post.caption;
    
   

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
