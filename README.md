# ZFYLoadView
 //模拟加载失败，重新加载回调
  <pre><code>      [ZFYLoading showFailWithstatus:@"加载失败" inView:view event:^(UIButton *button) {
            NSLog(@"button ==%@",button);
            ///点击显示转圈
            [ZFYLoading showLoadViewInview:view];
        }];
    //数据加载完成后消失
     [self performSelector:@selector(dis) withObject:self afterDelay:4];

    //没有数据
    //    [ZFYLoading showNullWithstatus:@"没有数据" inView:view];
    //    [self performSelector:@selector(dis) withObject:self afterDelay:4];
    //[ZFYLoading showNullWithImage:[UIImage imageNamed:@"huoying"] inView:view];
    //[ZFYLoading showNullWithImage:[UIImage imageNamed:@"huoying"] status:@"呵呵..." inview:view];
    
    //正在加载
    ///[ZFYLoading showLoadViewInview:view];
    //[ZFYLoading showLoadViewWithStatus:@"正在加载..." inView:view];
    //[ZFYLoading showLoadViewWithImage:[UIImage imageNamed:@"huoying"] status:@"正在加载" inview:view];
</code></pre>


