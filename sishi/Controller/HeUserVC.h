//
//  HeUserVC.h
//  beautyContest
//
//  Created by HeDongMing on 16/7/30.
//  Copyright © 2016年 iMac. All rights reserved.
//

#import "HeBaseViewController.h"

typedef void(^UserViewControllerExitCallBack)(BOOL hasFocused);

@interface HeUserVC : UIViewController
/**
 *  用户Id
 */
@property(nonatomic,copy)NSString *uid;

/**
 *  是否已关注用户
 */
@property(nonatomic,assign)BOOL hasFocused;

/**
 *  页面退出时回调
 */
@property(nonatomic,copy)UserViewControllerExitCallBack onExit;


@end
