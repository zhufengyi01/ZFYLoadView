//
//  ZFYLoading.h
//  ZFYLoading
//
//  Created by 朱封毅 on 14/07/15.
//  Copyright (c) 2015年 card. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ZFYLoading : UIView
@property(nonatomic,copy) void (^failblock)(UIButton *sender);

#pragma mark --Null dataMethod
+(void)showNullWithstatus:(NSString *)string inView:(UIView *) view;

// image size*height = 60*60;
+(void)showNullWithImage:(UIImage *)image inView:(UIView *) view;

#pragma mark --Fail dataMethod
+(void)showFailWithstatus:(NSString *)string inView:(UIView *) view event:(void (^)(UIButton *sender)) fail;


#pragma mark --dismissMethod;
+(void)dismiss;
@end
