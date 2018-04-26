# YXAlertView
两种模式带有图片的AlertView，和常规的AlertView，使用简单

#### 一、说明
由于项目需要自定义AlertView,将一个demo改写了，做出三种模式，如下效果：
###### 1. 常规提示框
****
![icon1](https://github.com/chenhongch/YXAlertView/blob/master/icon/Simulator%20Screen%20Shot%20-%20iPhone%208%20Plus%20-%202018-04-08%20at%2012.10.07.png)。
![icon2](https://github.com/chenhongch/YXAlertView/blob/master/icon/Simulator%20Screen%20Shot%20-%20iPhone%208%20Plus%20-%202018-04-08%20at%2012.11.02.png)

###### 2. 提示带有小图 

![icon3](https://github.com/chenhongch/YXAlertView/blob/master/icon/Simulator%20Screen%20Shot%20-%20iPhone%208%20Plus%20-%202018-04-08%20at%2012.03.44.png)![icon4](https://github.com/chenhongch/YXAlertView/blob/master/icon/Simulator%20Screen%20Shot%20-%20iPhone%208%20Plus%20-%202018-04-08%20at%2012.05.18.png)
###### 3.  提示带有大图  

![icon4](https://github.com/chenhongch/YXAlertView/blob/master/icon/Simulator%20Screen%20Shot%20-%20iPhone%208%20Plus%20-%202018-04-26%20at%2009.54.05.png)![icon5](https://github.com/chenhongch/YXAlertView/blob/master/icon/Simulator%20Screen%20Shot%20-%20iPhone%208%20Plus%20-%202018-04-26%20at%2009.55.34.png)


#### 二、使用：
```
YXAlertView *alter = [[YXAlertView alloc]initWithTitle:@"确定要退出吗？" icon:nil message:nil mode:YXAlertViewModeSmallIcon delegate:self buttonTitles:@"确定",@"退出",nil];
    [alter show];
```
事件回调需要遵循协议YXAlertViewDelegate

```
- (void)alertView:(YXAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"=====点击==%ld",buttonIndex);
}
```
