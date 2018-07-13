//
//  LiveCameraViewController.h
//  Instagram
//
//  Created by Nico Salinas on 7/13/18.
//  Copyright © 2018 Nico Salinas. All rights reserved.
//

#import <UIKit/UIKit.h>
@import AVKit;

@interface LiveCameraViewController : UIViewController <AVCapturePhotoCaptureDelegate>

@property (weak, nonatomic) IBOutlet UIView *previewView;
@property (weak, nonatomic) IBOutlet UIButton *takeButton;
@property (weak, nonatomic) IBOutlet UIImageView *captureView;

@end
