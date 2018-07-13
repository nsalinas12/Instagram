//
//  EditProfileViewController.m
//  Instagram
//
//  Created by Nico Salinas on 7/12/18.
//  Copyright © 2018 Nico Salinas. All rights reserved.
//

#import "EditProfileViewController.h"
#import "ParseUI.h"
#import "Parse/Parse.h"
#import "PFUser+ExtendedUser.h"


@interface EditProfileViewController ()

@property (weak, nonatomic) IBOutlet PFImageView *pictureImageView;
@property (weak, nonatomic) IBOutlet UITextField *editEmailTextField;
@property (weak, nonatomic) IBOutlet UITextField *editUsernameField;
@property (weak, nonatomic) IBOutlet UITextView *editDescriptionField;
@property (weak, nonatomic) IBOutlet UIButton *photoLibraryButton;
@property (weak, nonatomic) IBOutlet UIButton *cameraButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *doneButton;

@end

@implementation EditProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

    
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
    
    
    self.pictureImageView.file = nil;
    
    CGSize size = CGSizeMake(80, 80);
    
    UIImage *resizedImage = [self resizeImage:editedImage withSize:size];
    
    PFFile *imageFile = [self getPFFileFromImage:resizedImage];
    
     [imageFile saveInBackground];
     
     PFUser *user = [PFUser currentUser];
     [user setObject:imageFile forKey:@"profilePicture"];
     [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
     if (!error) {
         self.pictureImageView.file = user.profilePicture;
         
         [self.pictureImageView loadInBackground];
         
         NSLog( @"set new image" );
        
     }
     }];
    
    

    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
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

- (IBAction)onTapCancel:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
    
}

- (IBAction)onTapDone:(id)sender {
    
    
     [self dismissViewControllerAnimated:YES completion:nil];
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
