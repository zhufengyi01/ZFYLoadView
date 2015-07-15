//
//  ZFYLoading.m
//  ZFYLoading
//
//  Created by 朱封毅 on 14/07/15.
//  Copyright (c) 2015年 card. All rights reserved.
//

#import "ZFYLoading.h"
//#import "UIImage+Color.h"
///#import "Constant.h"
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
#pragma mark --Null dataMethod
+(void)showNullWithstatus:(NSString *)string inView:(UIView *) view;
{
    [self sharedView];
    [self sharedView].frame = CGRectMake(0, 0, view.frame.size.width,view.frame.size.height);
    [view addSubview:[self sharedView]];
    UILabel *lbl = [self createLableWithTitle:string frame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
    [[self sharedView] addSubview:lbl];
}
+(void)showNullWithImage:(UIImage *)image inView:(UIView *) view;
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
    //imageView.backgroundColor = [UIColor redColor];
    [[self sharedView] addSubview:imageView];
}
#pragma mark --Fail dataMethod
+(void)showFailWithstatus:(NSString *)string inView:(UIView *) view event:(void (^)(UIButton *sender)) fail;
{
    [self sharedView];
    [self sharedView].frame = CGRectMake(0, 0, view.frame.size.width,view.frame.size.height);
    [self sharedView].failblock = fail;
    [view addSubview:[self sharedView]];
    UIButton *button = [self createButtonWithTitle:string frame:CGRectMake((view.frame.size.width-80)/2, (view.frame.size.height-40)/2, 80, 40) backgrundImage:[self imageWithColor:VLight_GrayColor]];
    [button addTarget:self action:@selector(failEvent:) forControlEvents:UIControlEventTouchUpInside];
    [[self sharedView] addSubview:button];
    UILabel *lbl = [self createLableWithTitle:string frame:CGRectMake(0, button.frame.origin.y-40, 200, 40)];
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
    lable.font = [UIFont fontWithName:fontName size:14];
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
@end