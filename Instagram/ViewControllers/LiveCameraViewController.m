//
//  LiveCameraViewController.m
//  Instagram
//
//  Created by Nico Salinas on 7/13/18.
//  Copyright © 2018 Nico Salinas. All rights reserved.
//

#import "LiveCameraViewController.h"

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
    AVCapturePhotoSettings *settings = [AVCapturePhotoSettings photoSettingsWithFormat:@{AVVideoCodecKey: AVVideoCodecTypeJPEG}];
    //Capture Photo
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
