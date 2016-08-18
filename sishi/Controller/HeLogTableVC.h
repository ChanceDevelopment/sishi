//
//  HeLogTableVC.h
//  huayoutong
//
//  Created by Tony on 16/3/8.
//  Copyright © 2016年 HeDongMing. All rights reserved.
//

#import "DFTimeLineViewController.h"

@interface HeLogTableVC : DFTimeLineViewController<MyTableViewDelgate,UIAlertViewDelegate,UIWebViewDelegate>
{
    NSInteger updateOption; //1:刷新 2:加载更多
}

@end
