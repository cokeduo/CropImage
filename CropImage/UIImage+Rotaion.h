//
//  UIImage+Rotaion.h
//  CropImage
//
//  Created by change009 on 16/3/1.
//  Copyright © 2016年 change009. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Rotaion)

- (UIImage *)imageRotatedByRadians:(CGFloat)radians;
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;

@end
