//
//  ZFYLoading.m
//  ZFYLoading
//
//  Created by 朱封毅 on 14/07/15.
//  Copyright (c) 2015年 card. All rights reserved.
//

#import "ZFYLoading.h"
#import <QuartzCore/QuartzCore.h>
//旋转动画时间
const float  Rotation_InterVal = 1.3f;

#define View_backgroundcolor    [UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1]
#define VLight_GrayColor         [UIColor colorWithRed:140.0/255 green:140.0/255 blue:140.0/255 alpha:1]
#define FailButton_Color        [UIColor blueColor]
#define Width                   [UIScreen mainScreen].bounds.size.width
#define Height                  [UIScreen mainScreen].bounds.size.height
#define fontName    @"Thonburi-Light"
@implementation ZFYLoading
+ (ZFYLoading*)sharedView {
    static dispatch_once_t once;
    static ZFYLoading *sharedView;
    dispatch_once(&once, ^ { sharedView = [[self alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    });
    sharedView.backgroundColor = View_backgroundcolor;
    return sharedView;
}

#pragma mark ---Loading Method
+(void)showLoadViewInview:(UIView *) view;
{
    [self showLoadViewWithStatus:nil inView:view];
}

+(void)showLoadViewWithStatus:(NSString *) string inView:(UIView *) view;
{
    [self showLoadViewWithImage:nil status:string inview:view];
}

+(void)showLoadViewWithImage:(UIImage *)image status:(NSString*)string inview:(UIView*)view;
{
    
    [[self sharedView] removeAllSubView];
    [self sharedView];
    [self sharedView].frame = CGRectMake(0, 0, view.frame.size.width,view.frame.size.height);
    [view addSubview:[self sharedView]];
    UIImageView *imv =  [self createImageViewWithFrame:CGRectMake((view.frame.size.width-40)/2, (view.frame.size.height-40)/2, 40, 40) image:nil];
    if (!image) {
        NSString *image_url = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"ZFYLoad.bundle/images/loading_roll.png"];
        imv.image =[UIImage imageWithContentsOfFile:image_url];
    }else{
        imv.image = image;
    }
    CABasicAnimation *animation = [self Rotaionaimation];
    [imv.layer addAnimation:animation forKey:@"rotation"];
    [[self sharedView] addSubview:imv];
    UILabel *lbl = [self createLableWithTitle:string frame:CGRectMake(0, imv.frame.origin.y+imv.frame.size.height, view.frame.size.width, 40)];
    [[self sharedView] addSubview:lbl];
}


#pragma mark --Null dataMethod
+(void)showNullWithstatus:(NSString *)string inView:(UIView *) view;
{
    [self showNullWithImage:nil status:string inview:view];
}
+(void)showNullWithImage:(UIImage *)image inView:(UIView *) view;
{
    [self showNullWithImage:image status:nil inview:view];
}
+(void)showNullWithImage:(UIImage *)image status:(NSString*)string inview:(UIView*)view;
{
    [self sharedView];
    [self sharedView].frame = CGRectMake(0, 0, view.frame.size.width,view.frame.size.height);
    [view addSubview:[self sharedView]];
    UIImageView *imageView= [[UIImageView alloc] initWithFrame:CGRectMake((view.frame.size.width-60)/2, (view.frame.size.height-50)/2, 60, 50)];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    if (!image) {
        NSString *image_url = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"ZFYLoad.bundle/images/null.png"];
        imageView.image =[UIImage imageWithContentsOfFile:image_url];
    }
    else
    {
        imageView.image=image;
    }
    [[self sharedView] addSubview:imageView];
    UILabel *lbl = [self createLableWithTitle:string frame:CGRectMake(0, imageView.frame.origin.y+imageView.frame.size.height, view.frame.size.width, 40)];
    [[self sharedView] addSubview:lbl];
}




#pragma mark --Fail dataMethod
+(void)showFailWithstatus:(NSString *)string inView:(UIView *) view event:(void (^)(UIButton *sender)) fail;
{
    [[self sharedView] removeAllSubView];
    [self sharedView];
    [self sharedView].frame = CGRectMake(0, 0, view.frame.size.width,view.frame.size.height);
    [self sharedView].failblock = fail;
    [view addSubview:[self sharedView]];
    UIButton *button = [self createButtonWithTitle:string frame:CGRectMake((view.frame.size.width-80)/2, (view.frame.size.height-40)/2, 80, 40) backgrundImage:[self imageWithColor:VLight_GrayColor]];
    [button addTarget:self action:@selector(failEvent:) forControlEvents:UIControlEventTouchUpInside];
    [[self sharedView] addSubview:button];
    UILabel *lbl = [self createLableWithTitle:string frame:CGRectMake(0, button.frame.origin.y-40,view.frame.size.width, 40)];
    [[self sharedView] addSubview:lbl];
}

#pragma  mark ---custom UI
+(UIButton *)createButtonWithTitle:(NSString *) title frame:(CGRect) frame backgrundImage:(UIImage*) image;
{
    UIButton  *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = FailButton_Color;
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setTitle:@"重新加载" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont fontWithName:fontName size:12];
    button.layer.cornerRadius =4;
    button.clipsToBounds = YES;
    button.frame = CGRectMake(frame.origin.x,frame.origin.y,frame.size.width,frame.size.height);
    [button addTarget:self action:@selector(failEvent:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+(UILabel *)createLableWithTitle:(NSString *) title frame:(CGRect) frame
{
    UILabel *lable = [[UILabel alloc] initWithFrame:frame];
    lable.text = title;
    lable.font = [UIFont fontWithName:fontName size:12];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.textColor = VLight_GrayColor;
    return lable;
}
+(UIView *)createBgViewWithFrame:(CGRect) frame
{
    UIView *bgView= [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    bgView.backgroundColor = View_backgroundcolor;
    bgView.userInteractionEnabled = YES;
    return bgView;
}
+(UIImageView *)createImageViewWithFrame:(CGRect) frame image:(UIImage*) image;
{
    UIImageView *imageView= [[UIImageView alloc] initWithFrame:frame];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.image = image;
    return imageView;
}

+(void)failEvent:(UIButton *)sender
{
    [self sharedView].failblock(sender);
}
+(void)dismiss;
{
    if (self) {
        [UIView animateWithDuration:0.2 animations:^{
            [self sharedView].alpha=0;
        } completion:^(BOOL finished) {
            [[self sharedView] removeFromSuperview];
        }];
    }
    NSLog(@"====%@",[self sharedView]);
}

#pragma  mark --Others Method
+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
+(CABasicAnimation *)Rotaionaimation
{
    CABasicAnimation* rotationAnimation =
    [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];//"z"还可以是“x”“y”，表示沿z轴旋转
    rotationAnimation.toValue = [NSNumber numberWithFloat:(2 * M_PI) * 3];
    // 3 is the number of 360 degree rotations
    // Make the rotation animation duration slightly less than the other animations to give it the feel
    // that it pauses at its largest scale value
    rotationAnimation.duration = Rotation_InterVal;
    rotationAnimation.repeatCount = MAX_CANON;
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]; //缓入缓出
    return rotationAnimation;
    
}
-(void)removeAllSubView
{
    for (id  view in self.subviews) {
        if ([view isKindOfClass:[UIView class]]) {
            UIView *v = (UIView *) view;
            [v removeFromSuperview];
            v=nil;
        }
    }
}
@end