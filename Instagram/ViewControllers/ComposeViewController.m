//
//  ComposeViewController.m
//  Instagram
//
//  Created by Nico Salinas on 7/9/18.
//  Copyright © 2018 Nico Salinas. All rights reserved.
//

#import "ComposeViewController.h"
#import "Post.h"
#import "Parse/Parse.h"
#import "FeedTableViewController.h"

@interface ComposeViewController ()
@property (weak, nonatomic) IBOutlet UIButton *cameraRollButton;
@property (weak, nonatomic) IBOutlet UIButton *photoLibraryButton;
@property (weak, nonatomic) IBOutlet UITextView *captionText;
@property (strong, nonatomic) IBOutlet UIImageView *tempImage;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;


@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)onTapPhotoLibraryButton:(id)sender {
    
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}



- (IBAction)onTapCameraButton:(id)sender {
    
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    
    // Do something with the images (based on your use case)
    
    
    self.tempImage.image = nil;
    CGSize size = CGSizeMake(375, 375);
    
    UIImage *resizedImage = [self resizeImage:editedImage withSize:size];
    
    self.tempImage.image = resizedImage;
    
    NSLog( @"set new image" );
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onTapShare:(id)sender {
    
    NSLog( @"Sharing your post!" );
    
    //[Post postUserImage:self.tempImage.image withCaption:self.captionText.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
    
    [Post postUserImage:self.tempImage.image withCaption:self.captionText.text withCompletion:^(BOOL succeeded, NSError * _Nullable error, Post * _Nullable post) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
        } else {
            [self.delegate didPost:post];
            
            NSLog( @"Shared your post!" );
        }
    }];
    
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}


- (IBAction)onTapCancel:(id)sender {
    
    NSLog( @"YES" );
    
    [self dismissViewControllerAnimated:true completion:nil];
    
    
}


- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
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
