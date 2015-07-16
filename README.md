# ZFYLoadView
###模拟加载失败，重新加载回调
<pre><code>[ZFYLoading showFailWithstatus:@"加载失败" inView:view event:^(UIButton *button) {
 NSLog(@"button ==%@",button);
     点击显示正在加载
   [ZFYLoading showLoadViewInview:view];
  }];
数据加载完成后消失
[self performSelector:@selector(dis) withObject:self afterDelay:4];
 //4秒后消失，也就是数据加载完成后执行
-(void)dis
{
    [ZFYLoading dismiss];
    
}
</code></pre>
###没有数据
  <pre><code>
   没有数据1
    [ZFYLoading showNullWithstatus:@"没有数据" inView:view];
    没有数据2
    [ZFYLoading showNullWithImage:[UIImage imageNamed:@"huoying"] inView:view];
    没有数据3
    [ZFYLoading showNullWithImage:[UIImage imageNamed:@"huoying"] status:@"呵呵..." inview:view];
    </code></pre>
###正在加载  
   <pre><code>
   正在加载1
    [ZFYLoading showLoadViewInview:view];
   正在加载2
    [ZFYLoading showLoadViewWithStatus:@"正在加载..." inView:view];
   正在加载3
    [ZFYLoading showLoadViewWithImage:[UIImage imageNamed:@"huoying"] status:@"正在加载" inview:view];
</code></pre>



