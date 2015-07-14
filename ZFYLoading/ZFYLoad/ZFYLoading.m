//
//  ZFYLoading.m
//  ZFYLoading
//
//  Created by 朱封毅 on 14/07/15.
//  Copyright (c) 2015年 card. All rights reserved.
//

#import "ZFYLoading.h"
#define View_backgroundcolor  [UIColor colorWithRed:200.0/255 green:200.0/255 blue:220.0/255 alpha:1]
#define Width   [UIScreen mainScreen].bounds.size.width
#define Height      [UIScreen mainScreen].bounds.size.height

@implementation ZFYLoading
+ (ZFYLoading*)sharedView {
    static dispatch_once_t once;
    static ZFYLoading *sharedView;
    dispatch_once(&once, ^ { sharedView = [[self alloc] initWithFrame:[[UIScreen mainScreen] bounds]]; });
    return sharedView;
}
+(void)showNullWithstatus:(NSString *)string inView:(UIView *) view;
{
    [self sharedView];
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0,0,view.frame.size.width,view.frame.size.height)];
    lable.text = @"没有数据...";
    lable.font = [UIFont systemFontOfSize:16];
    lable.textAlignment = NSTextAlignmentCenter;
    lable.textColor = [UIColor grayColor];
    [view addSubview:lable];
}
+(void)showNullWithImage:(UIImage *)image inView:(UIView *) view;
{
    [self sharedView];
    UIImageView *imageView= [[UIImageView alloc] initWithFrame:CGRectMake((view.frame.size.width-100)/2, (view.frame.size.height-100)/2, 100, 100)];
    imageView.backgroundColor = [UIColor redColor];
    [view addSubview:imageView];
}

+(void)showFailWithstatus:(NSString *)string inView:(UIView *) view;
{
    [self sharedView];
    
}


@end
