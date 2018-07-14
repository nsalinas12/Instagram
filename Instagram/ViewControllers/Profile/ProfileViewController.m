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
#import "ParseUI.h"
#import "Parse/Parse.h"
#import "PFUser+ExtendedUser.h"


@interface ProfileViewController () <UICollectionViewDataSource, UICollectionViewDelegate >

@property (weak, nonatomic) IBOutlet UILabel *postCount;
@property (weak, nonatomic) IBOutlet UILabel *followerCount;
@property (weak, nonatomic) IBOutlet UILabel *followingCount;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet PFImageView *profilePictureView;

@property (weak, nonatomic) IBOutlet UICollectionView *postCollectionView;
@property (nonatomic, strong ) NSMutableArray *collectionPosts;

@property (nonatomic, strong ) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UIImageView *gradient;


@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.profilePictureView.layer.cornerRadius = self.profilePictureView.frame.size.width / 2;
    self.profilePictureView.clipsToBounds = YES;
    self.gradient.layer.cornerRadius = self.gradient.frame.size.width / 2;
    self.gradient.clipsToBounds = YES;
    
    //self.profilePictureButton setImage:self.user.profilePicture; forState:normal;
    
    self.postCollectionView.dataSource = self;
    self.postCollectionView.delegate = self;
    
    [self fetchPosts];
    [self getUser];
    [PFUser getCurrentUserInBackground];
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *) self.postCollectionView.collectionViewLayout;
    
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    
    
    
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.tintColor = [UIColor grayColor];
    [self.refreshControl addTarget:self action:@selector(fetchPosts) forControlEvents:UIControlEventValueChanged];
    [self.postCollectionView addSubview:self.refreshControl];
    self.postCollectionView.alwaysBounceVertical = YES;
    
    
    [self.postCollectionView reloadData];
    
    
    // Do any additional setup after loading the view.
}


- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self fetchPosts];
    [self getUser];
    
    self.descriptionLabel.text = self.user.biography;
    
    [PFUser getCurrentUserInBackground];
    
    [self.postCollectionView reloadData];

    
}

-(void)getUser {
    PFQuery *query = [PFUser query];
    //[query whereKey:@"profilePicture" equalTo:[PFUser currentUser]];
    

    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
         self.user = [objects firstObject];
        
        self.usernameLabel.text = self.user.username;
        
        self.profilePictureView.file = self.user.profilePicture;
        
        self.descriptionLabel.text = self.user.biography;
        
         [self.profilePictureView loadInBackground];
        
        NSLog( @"loaded user");
        
    }];
    
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



- (PFFile *)getPFFileFromImage: (UIImage * _Nullable)image {
    if (!image) {
        return nil;
    }
    NSData *imageData = UIImagePNGRepresentation(image);
    // get image data and check if that is not nil
    if (!imageData) {
        return nil;
    }
    return [PFFile fileWithName:@"image.png" data:imageData];
    
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
