//
//  FeedTableViewController.m
//  Instagram
//
//  Created by Nico Salinas on 7/9/18.
//  Copyright © 2018 Nico Salinas. All rights reserved.
//

#import "FeedTableViewController.h"
#import "FeedCell.h"
#import "LoginViewController.h"
#import "Parse/Parse.h"
#import "AppDelegate.h"
#import <UIKit/UIKit.h>
#import "Post.h"
#import "ComposeViewController.h"
#import "DetailsViewController.h"

@interface FeedViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, ComposeViewControllerDelegate>
@property (nonatomic, strong ) UIRefreshControl *refreshControl;

@end

@implementation FeedTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self fetchPosts];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    
    [self.refreshControl addTarget:self action:@selector(fetchPosts) forControlEvents:UIControlEventValueChanged];
    
    [self.feedTableView insertSubview:self.refreshControl atIndex:0];

    
    
}

- (void) viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:true];
    
     NSLog(@"Reloading table view");
    
    [self fetchPosts];
    
}


- (void) didPost:(Post *)post{
    
    NSLog(@"Reloading table view");
    
    [self.feedArray insertObject:post atIndex:0];
    [self.feedTableView reloadData];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) fetchPosts{
    // construct query
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    //[query whereKey:@"likesCount" greaterThan:@100];
    query.limit = 20;
    
     [query orderByDescending:@"createdAt"];
    
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            self.feedArray = (NSMutableArray *)posts;
            [self.feedTableView reloadData];
            
            [self.refreshControl endRefreshing];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
    
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
    return self.feedArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FeedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FeedCell"];
    
    Post *newPost = self.feedArray[indexPath.row];
    
    cell.post = newPost;

    NSLog( @"Loading new cell" );
    
    return cell;
}


- (IBAction)onTapLogout:(id)sender {
    
    /*AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
     LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];*/
    
    NSLog( @"Logging out" );
    
    [self dismissViewControllerAnimated:true completion:nil];
    
}


 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

     
     if( [segue.identifier isEqualToString:@"segueToDetailsViewController"]){
         
         DetailsViewController *detailsViewController = [segue destinationViewController];
         detailsViewController.delegate = self;
         
     }
     
 }


@end
