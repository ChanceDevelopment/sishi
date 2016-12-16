//
//  HeTabBarVC.h
//  huayoutong
//
//  Created by HeDongMing on 16/3/2.
//  Copyright © 2016年 HeDongMing. All rights reserved.
//

#import "HeBaseViewController.h"
#import "RDVTabBarController.h"
#import "HeUserVC.h"
#import "HeHomePageVC.h"
#import "HeChatVC.h"
#import "HeInfoMenuVC.h"
#import "HeDynamicVC.h"
#import "HeLogTableVC.h"
#import "HeUserCenterVC.h"

@interface HeTabBarVC : RDVTabBarController<UIAlertViewDelegate>
@property(strong,nonatomic)HeSlideMenuVC *userVC;
@property(strong,nonatomic)HeHomePageVC *homePageVC;
@property(strong,nonatomic)HeChatVC *chatVC;
@property(strong,nonatomic)HeInfoMenuVC *menuVC;
@property(strong,nonatomic)HeDynamicVC *dynamicVC;
@property(strong,nonatomic)HeLogTableVC *logVC;
@property(strong,nonatomic)UIImageView *currentSnapShot;

@end
