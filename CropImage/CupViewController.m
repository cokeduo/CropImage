//
//  CupViewController.m
//  图片剪裁Test2
//
//  Created by change009 on 16/2/19.
//  Copyright © 2016年 change009. All rights reserved.
//

#import "CupViewController.h"
#import "CupView.h"
#import "CupedResultVC.h"

#define KWidth self.view.bounds.size.width
#define KHeight self.view.bounds.size.height

#define KCupWidth 160
#define KCupHeight 200

#define ORIGINAL_MAX_WIDTH 640.0f

@interface CupViewController ()<UIGestureRecognizerDelegate>{
    CGRect _foreCupRect;
}

@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UIView *backGroundView;

@property (nonatomic,strong) CupView *myCupView;


@end

@implementation CupViewController

#pragma mark - 视图将要出现时
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}
#pragma mark - 视图将要消失时
-(void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:YES];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.myCupView];
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWidth, 50)];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, 44, 44)];
    [backBtn setTitle:@"Back" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:backBtn];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((KWidth - 80)/2, 11, 80, 22)];
    titleLabel.text = @"扣脸";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:17];
    titleLabel.textColor = [UIColor darkGrayColor];
    [topView addSubview:titleLabel];
    
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, KHeight-50, KWidth, 50)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    UIButton *finishBtn = [[UIButton alloc] initWithFrame:CGRectMake((KWidth-100)/2, 9, 100, 32)];
    [finishBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [finishBtn setTitle:@"完成" forState:UIControlStateNormal];
    [finishBtn addTarget:self action:@selector(finishedBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:finishBtn];
    
    
    
    UIView *backGroundView = [[UIView alloc] initWithFrame:self.view.bounds];
    backGroundView.backgroundColor = [UIColor whiteColor];
    
    UIRotationGestureRecognizer *rotationGes = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(backGroundViewRotationAction:)];
    rotationGes.delegate = self;
    [backGroundView addGestureRecognizer:rotationGes];
    
    UIPinchGestureRecognizer *pinchGes = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(backGroundViewPinchAction:)];
    pinchGes.delegate =self;
    [backGroundView addGestureRecognizer:pinchGes];
    
    UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(backGroundViewPanAction:)];
    [panGes setMinimumNumberOfTouches:1];
    [panGes setMaximumNumberOfTouches:1];
    panGes.delegate = self;
    [backGroundView addGestureRecognizer:panGes];
    
    self.backGroundView = backGroundView;
    
    [self.view addSubview:backGroundView];
    [self.view insertSubview:backGroundView atIndex:0];
    
}

#pragma mark 按钮点击事件
-(void)backBtnAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)finishedBtnAction{
    
    UIImage *cupedImage = [self.myCupView clipImageWithSoucreImageView:self.imageView];
    
    if (!cupedImage) {
        return;
    }
    
    CupedResultVC *ResultVC = [[CupedResultVC alloc] init];
    ResultVC.resultImage = cupedImage;
    [self presentViewController:ResultVC animated:YES completion:nil];
    
    
}

- (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage {
    if (sourceImage.size.width < ORIGINAL_MAX_WIDTH) return sourceImage;
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    if (sourceImage.size.width > sourceImage.size.height) {
        btHeight = ORIGINAL_MAX_WIDTH;
        btWidth = sourceImage.size.width * (ORIGINAL_MAX_WIDTH / sourceImage.size.height);
    } else {
        btWidth = ORIGINAL_MAX_WIDTH;
        btHeight = sourceImage.size.height * (ORIGINAL_MAX_WIDTH / sourceImage.size.width);
    }
    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    
    return [self scaleToSize:sourceImage size:targetSize];
}

- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}


#pragma mark 手势触发事件
-(void)backGroundViewPinchAction:(UIPinchGestureRecognizer *)gesture{
    
    UIView *view = self.imageView;
    
    if (gesture.state == UIGestureRecognizerStateBegan || gesture.state == UIGestureRecognizerStateChanged) {
        
        view.transform = CGAffineTransformScale(view.transform, gesture.scale, gesture.scale);
        gesture.scale = 1;
    }
    
}
-(void)backGroundViewPanAction:(UIPanGestureRecognizer *)gesture{
    
    if (gesture.numberOfTouches == 1) {
        if (gesture.state == UIGestureRecognizerStateBegan || gesture.state == UIGestureRecognizerStateChanged) {
            CGPoint transLation = [gesture translationInView:self.backGroundView];
            self.imageView.center = CGPointMake(self.imageView.center.x + transLation.x, self.imageView.center.y + transLation.y);
            [gesture setTranslation:CGPointZero inView:self.backGroundView];
        }
    }
}

-(void)backGroundViewRotationAction:(UIRotationGestureRecognizer *)gesture{
    
    self.imageView.transform = CGAffineTransformRotate(self.imageView.transform, gesture.rotation);
    
    gesture.rotation = 0;
    
}


#pragma mark - gesture delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if ([gestureRecognizer isKindOfClass:[UIPinchGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UIRotationGestureRecognizer class]]) {
        return YES;
    }else if ([gestureRecognizer isKindOfClass:[UIRotationGestureRecognizer class]] && [otherGestureRecognizer isKindOfClass:[UIPinchGestureRecognizer class]]){
        return YES;
    }else{
        return NO;
    }
    
}

#pragma mark property getter
- (UIImageView *)imageView{
    
    if (!_imageView) {
        
        UIImage *soucreImage = [self imageByScalingToMaxSize:_midImage];
        
        float _imageScale = KWidth / soucreImage.size.width;
        
        _imageView = [[UIImageView alloc] initWithImage:soucreImage];
        
        _imageView.frame = CGRectMake(0, (KHeight - soucreImage.size.height*_imageScale)/2, soucreImage.size.width*_imageScale, soucreImage.size.height*_imageScale);
        
        _imageView.userInteractionEnabled = NO;
    }
    return _imageView;
}

-(CupView *)myCupView{
    
    if (!_myCupView) {
        _myCupView = [[CupView alloc] initWithFrame:self.view.bounds];
    }
    return _myCupView;
}

@end
