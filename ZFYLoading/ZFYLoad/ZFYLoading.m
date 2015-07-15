//
//  ZFYLoading.m
//  ZFYLoading
//
//  Created by 朱封毅 on 14/07/15.
//  Copyright (c) 2015年 card. All rights reserved.
//

#import "ZFYLoading.h"
#import "UIImage+Color.h"
#import "Constant.h"
#define View_backgroundcolor  [UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1]
#define FailButton_Color      [UIColor blueColor]
#define Width   [UIScreen mainScreen].bounds.size.width
#define Height      [UIScreen mainScreen].bounds.size.height

@implementation ZFYLoading
+ (ZFYLoading*)sharedView {
    static dispatch_once_t once;
    static ZFYLoading *sharedView;
    dispatch_once(&once, ^ { sharedView = [[self alloc] initWithFrame:[[UIScreen mainScreen] bounds]]; });
    return sharedView;
}
#pragma mark --Null dataMethod
+(void)showNullWithstatus:(NSString *)string inView:(UIView *) view;
{
    [self sharedView];
    UIView *bgview = [self createBgViewWithFrame:view.frame];
    [view addSubview:bgview];
    UILabel *lbl = [self createLableWithTitle:string frame:CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)];
    [bgview addSubview:lbl];
}
+(void)showNullWithImage:(UIImage *)image inView:(UIView *) view;
{
    [self sharedView];
    UIView *bgview = [self createBgViewWithFrame:view.frame];
    [view addSubview:bgview];
    UIImageView *imageView= [[UIImageView alloc] initWithFrame:CGRectMake((view.frame.size.width-100)/2, (view.frame.size.height-100)/2, 100, 100)];
    imageView.backgroundColor = [UIColor redColor];
    [bgview addSubview:imageView];
}
#pragma mark --Fail dataMethod
+(void)showFailWithstatus:(NSString *)string inView:(UIView *) view event:(void (^)(UIButton *sender)) fail;
{
    [self sharedView];
    UIView *bgview = [self createBgViewWithFrame:view.frame];
    [view addSubview:bgview];
    [self sharedView].failblock = fail;
    UIButton *button = [self createButtonWithTitle:string frame:CGRectMake((view.frame.size.width-80)/2, (view.frame.size.height-40)/2, 80, 40) backgrundImage:[UIImage imageWithColor:VLight_GrayColor]];
    [button addTarget:self action:@selector(failEvent:) forControlEvents:UIControlEventTouchUpInside];
    [bgview addSubview:button];
    UILabel *lbl = [self createLableWithTitle:string frame:CGRectMake((Width-200)/2, button.frame.origin.y-40, 200, 40)];
    [bgview addSubview:lbl];
}

#pragma  mark ---custom UI
+(UIButton *)createButtonWithTitle:(NSString *) title frame:(CGRect) frame backgrundImage:(UIImage*) image;
{
    UIButton  *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = FailButton_Color;
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setTitle:@"重新加载" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont fontWithName:KFontThin size:16];
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
    lable.font = [UIFont fontWithName:KFontThin size:16];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.textColor = VGray_color;
    return lable;
}
+(UIView *)createBgViewWithFrame:(CGRect) frame
{
    UIView *bgView= [[UIView alloc]initWithFrame:frame];
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
        [[self sharedView] removeFromSuperview];
    }
}


@end
