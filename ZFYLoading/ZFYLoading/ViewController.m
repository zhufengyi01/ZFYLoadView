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
    //[ZFYLoading showNullWithstatus:@"没有数据" inView:self.view];
    //[ZFYLoading showNullWithImage:nil inView:self.view];
    [ZFYLoading showFailWithstatus:@"加载失败" inView:self.view event:^(UIButton *button) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
