# SDDDialogView
一个仿安卓DialogView的一个控件

### 使用
```
YSDDialogView *dialog = [[YSDDialogView alloc] initWithTitle:@"是否放弃任务"
                                                     message:@"放弃任务会扣除押金"
                                                      cancle:@"是"
                                                    otherBtn:@"否"];
WS(weakSelf);
dialog.cancleButtonBlock = ^{
    [weakSelf requestAbandonTask];
};
```

### 效果图
![](https://raw.githubusercontent.com/lover0920/SDDDialogView/master/效果图.png)
