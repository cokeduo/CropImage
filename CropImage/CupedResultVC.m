//
//  CupedResultVC.m
//  CropImage
//
//  Created by change009 on 16/3/1.
//  Copyright © 2016年 change009. All rights reserved.
//

#import "CupedResultVC.h"

@interface CupedResultVC ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation CupedResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.resultImage) {
        CGSize imageSize = CGSizeMake(200, 200*self.resultImage.size.height/self.resultImage.size.width);
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.view.bounds)-imageSize.width)/2, (CGRectGetHeight(self.view.bounds)-imageSize.height)/2, imageSize.width, imageSize.height)];
        
        imageView.center = self.view.center;
        imageView.image = self.resultImage;
        //    imageView.backgroundColor = [UIColor colorWithRed:0.000 green:1.000 blue:1.000 alpha:0.290];
        [self.view addSubview:imageView];
    }
    

    
}

- (IBAction)BackAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


@end
