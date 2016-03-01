//
//  CupView.h
//  CropImage
//
//  Created by change009 on 16/3/1.
//  Copyright © 2016年 change009. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CupView : UIView

@property (nonatomic,strong) UIBezierPath *cupBezPath;
@property (nonatomic,strong) UIColor *lineColor;        //边线颜色
@property (nonatomic,assign) CGFloat lineWidth;         //边线宽度
@property (nonatomic,assign) CGRect WillCupRect;        //剪切区域

/**
 *  图片剪裁
 *
 *  @param imageView 图片视图源
 *
 *  @return 返回剪裁后的图片
 */
- (UIImage *)clipImageWithSoucreImageView:(UIImageView *)imageView;

@end
