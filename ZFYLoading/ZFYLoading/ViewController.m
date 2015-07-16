//
//  ViewController.m
//  ZFYLoading
//
//  Created by 朱封毅 on 14/07/15.
//  Copyright (c) 2015年 card. All rights reserved.
//

#import "ViewController.h"
#import "ZFYLoading.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor= [UIColor whiteColor];
    
    UIView *view= [[UIView alloc]initWithFrame:CGRectMake(50, 100, 200, 280)];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    
     //模拟加载失败，重新加载回调
//        [ZFYLoading showFailWithstatus:@"加载失败" inView:view event:^(UIButton *button) {
//            NSLog(@"button ==%@",button);
//            ///点击显示转圈
//            [ZFYLoading showLoadViewInview:view];
//        }];
//    //数据加载完成后消失
//     [self performSelector:@selector(dis) withObject:self afterDelay:4];
//
    //没有数据
    //    [ZFYLoading showNullWithstatus:@"没有数据" inView:view];
    //    [self performSelector:@selector(dis) withObject:self afterDelay:4];
    //[ZFYLoading showNullWithImage:[UIImage imageNamed:@"huoying"] inView:view];
    //[ZFYLoading showNullWithImage:[UIImage imageNamed:@"huoying"] status:@"呵呵..." inview:view];
    
    //正在加载
    [ZFYLoading showLoadViewInview:view];
    //[ZFYLoading showLoadViewWithStatus:@"正在加载..." inView:view];
    //[ZFYLoading showLoadViewWithImage:[UIImage imageNamed:@"huoying"] status:@"正在加载" inview:view];
    
}
//4秒后消失，也就是数据加载完成后执行
-(void)dis
{
   [ZFYLoading dismiss];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
