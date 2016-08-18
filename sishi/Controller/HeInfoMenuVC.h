//
//  HeInfoMenuVC.h
//  carTune
//
//  Created by Tony on 16/6/28.
//  Copyright © 2016年 Jitsun. All rights reserved.
//

#import "HeBaseViewController.h"

@interface HeInfoMenuVC : HeBaseViewController<UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@property(strong,nonatomic)UIViewController *leftViewController;
@property(strong,nonatomic)UINavigationController *rootVC;

- (void)showRootController:(BOOL)animated;
- (void)showRootController:(BOOL)animated pushController:(UIViewController *)controller;
- (id)initWithRootController:(UIViewController *)root;

@end
