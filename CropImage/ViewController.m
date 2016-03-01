//
//  ViewController.m
//  图片剪裁Test2
//
//  Created by change009 on 16/2/19.
//  Copyright © 2016年 change009. All rights reserved.
//

#import "ViewController.h"
#import "CupViewController.h"

@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (IBAction)camerBtnAction:(id)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    if ([self isSourceTypeAvailable]) {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    
    if ([self isCameraDeviceAvailable]) {
        picker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
    }
    
    picker.allowsEditing = NO;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
    
}


- (IBAction)photoBtnAction:(id)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    CupViewController *bvViewController = [[CupViewController alloc] init];
    bvViewController.midImage = image;
    [self presentViewController:bvViewController animated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (BOOL) isSourceTypeAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isCameraDeviceAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

@end
