//
//  LiveCameraViewController.m
//  Instagram
//
//  Created by Nico Salinas on 7/13/18.
//  Copyright © 2018 Nico Salinas. All rights reserved.
//

#import "LiveCameraViewController.h"
@import AVKit;

@interface LiveCameraViewController ()

@property (nonatomic) AVCaptureSession *session;
@property (nonatomic) AVCapturePhotoOutput *stillImageOutput;
@property (nonatomic) AVCaptureVideoPreviewLayer *videoPreviewLayer;

@end

@implementation LiveCameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // Setup your camera here...
    
    self.session = [AVCaptureSession new];
    self.session.sessionPreset = AVCaptureSessionPresetPhoto;
    
    AVCaptureDevice *backCamera = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    NSError *error;
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:backCamera error:&error];
    
    
    if (error) {
        NSLog(@"%@", error.localizedDescription);
    } else if (self.session && [self.session canAddInput:input]) {
        [self.session addInput:input];
        self.stillImageOutput = [AVCapturePhotoOutput new];
        
        
        if ([self.session canAddOutput:self.stillImageOutput]) {
            [self.session addOutput:self.stillImageOutput];
            
            self.videoPreviewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
            if (self.videoPreviewLayer) {
                self.videoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspect;
                self.videoPreviewLayer.connection.videoOrientation = AVCaptureVideoOrientationPortrait;
                [self.previewView.layer addSublayer:self.videoPreviewLayer];
                [self.session startRunning];
            }
        }
    }
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.videoPreviewLayer.frame = self.previewView.bounds;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)didTakePhoto:(id)sender {
    
    //NSLog( @"CAPTURE PHOTO!");
    
    AVCapturePhotoSettings *settings = [AVCapturePhotoSettings photoSettingsWithFormat:@{AVVideoCodecKey: AVVideoCodecTypeJPEG}];
    
    self.stillImageOutput = [AVCapturePhotoOutput new];
    
    [self.stillImageOutput capturePhotoWithSettings:settings delegate:self];
    
    //Capture Photo
    

}
- (void)captureOutput:(AVCapturePhotoOutput *)output didFinishProcessingPhoto:(AVCapturePhoto *)photo error:(nullable NSError *)error {
    
    NSData *imageData = photo.fileDataRepresentation;
    UIImage *image = [UIImage imageWithData:imageData];
    // Add the image to captureImageView here...
    
    self.captureView.image = nil;
    
    CGSize size = CGSizeMake(74, 100);

    
    UIImage *resizedImage = [self resizeImage:image withSize:size];
    
    self.captureView.image = resizedImage;
    
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
