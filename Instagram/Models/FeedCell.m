//
//  FeedCell.m
//  Instagram
//
//  Created by Nico Salinas on 7/9/18.
//  Copyright © 2018 Nico Salinas. All rights reserved.
//

#import "FeedCell.h"
#import "Parse/Parse.h"
#import "Post.h"
#import "ParseUI.h"
#import "DateTools.h"

@implementation FeedCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setPost:(Post *)post {
    _post = post;
    
    
    self.dateLabel.text = [self.post.createdAt timeAgoSinceNow];
    self.usernameLabel.text = self.post.author.username;
    self.photoImageView.file = self.post.image;
    [self.photoImageView loadInBackground];
    
    self.captionLabel.text = self.post.caption;
    
    self.likeCountButton.text = [NSString stringWithFormat:@"%@", self.post.likeCount ];
    self.commentLabel.text = [NSString stringWithFormat:@"%@", self.post.commentCount];
    
}


- (IBAction)onTapLike:(id)sender {
    
    if (self.post.likeCount == 0 ){
        
        self.post.likeCount = @1;
        self.likeButton.selected = YES;
        self.likeCountButton.text = @"1";
        
    } else {
        
        self.post.likeCount = 0;
        self.likeButton.selected = NO;
        self.likeCountButton.text = @"0";
        
    }
    

    
    
    
}


- (IBAction)onTapComment:(id)sender {
    
    
    
}


@end
