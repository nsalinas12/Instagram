//
//  ProfileViewController.m
//  Instagram
//
//  Created by Nico Salinas on 7/12/18.
//  Copyright © 2018 Nico Salinas. All rights reserved.
//

#import "ProfileViewController.h"
#import "PostCollectionViewCell.h"
#import "DetailsViewController.h"
#import "Post.h"


@interface ProfileViewController () <UICollectionViewDataSource, UICollectionViewDelegate >

@property (weak, nonatomic) IBOutlet UILabel *postCount;
@property (weak, nonatomic) IBOutlet UILabel *followerCount;
@property (weak, nonatomic) IBOutlet UILabel *followingCount;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UIButton *profilePictureButton;



@property (weak, nonatomic) IBOutlet UICollectionView *postCollectionView;
@property (nonatomic, strong ) NSMutableArray *collectionPosts;

@property (nonatomic, strong ) UIRefreshControl *refreshControl;


@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //self.profilePictureButton setImage:self.user.profilePicture; forState:normal;
    
    self.postCollectionView.dataSource = self;
    self.postCollectionView.delegate = self;
    
    [self fetchPosts];
    
    [self setProfile];
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *) self.postCollectionView.collectionViewLayout;
    
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    
    [self.refreshControl addTarget:self action:@selector(fetchPosts) forControlEvents:UIControlEventValueChanged];
    
    [self.postCollectionView reloadData];
    
    
    // Do any additional setup after loading the view.
}


- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self fetchPosts];
    
    [self.postCollectionView reloadData];

    
}

- (void) setProfile{
    
    if( self.user == nil ){
        self.user = PFUser.currentUser;
    }
    if( PFUser.currentUser ){
        self.usernameLabel.text = self.user.username;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) fetchPosts{
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    query.limit = 20;
    
    [query includeKeys:@[@"author", @"createdAt"]];
    [query orderByDescending:@"createdAt"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            
            
            self.collectionPosts = (NSMutableArray *)posts;
            self.postCount.text = [NSString stringWithFormat:@"%lu", self.collectionPosts.count];
            
            [self.postCollectionView reloadData];
            
            [self.refreshControl endRefreshing];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}



- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    PostCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PostCollectionViewCell" forIndexPath:indexPath];
    
    Post *post = self.collectionPosts[indexPath.item];
    
    cell.pictureImageView.file = post.image;
    
    return cell;
    
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    
    return self.collectionPosts.count;
}



 #pragma mark - Navigation
 
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

     if( [segue.identifier isEqualToString:@"segueFromCollectionDetail"]){
         
         UICollectionViewCell *tappedCell = sender;
         NSIndexPath *indexPath = [self.postCollectionView indexPathForCell:tappedCell];
         
         Post *sendingPost = self.collectionPosts[indexPath.row];
         
         DetailsViewController *detailsViewController = [segue destinationViewController];
         detailsViewController.post = sendingPost;
         
         
     }
     
     
 }


@end
