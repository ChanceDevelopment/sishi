//
//  HeBaseViewController.m
//  fuyang
//
//  Created by Tony on 16/1/5.
//  Copyright © 2016年 HeDongMing. All rights reserved.
//

#import "HeBaseViewController.h"
#import "RDVTabBarController.h"
#import "RDVTabBarItem.h"
#import "AppDelegate.h"
#import "HeInfoMenuVC.h"
#import "HeLoginVC.h"
#import "HeUserVC.h"
#import "HeRealTimeTrendVC.h"
#import "HeLogTableVC.h"
#import "HeSlideMenuVC.h"

@interface HeBaseViewController ()

@end

@implementation HeBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //代理置空，否则会闪退
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
    if ([self isMemberOfClass:[HeLoginVC class]] || [self isMemberOfClass:[HeSlideMenuVC class]] || [self isMemberOfClass:[HeRealTimeTrendVC class]] || [self isMemberOfClass:[HeLogTableVC class]]) {
        
        return;
    }
    
    if (self.navigationController == nil) {
        if (![self isMemberOfClass:[HeInfoMenuVC class]]) {
            [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
            return;
        }
    }
    if (![[[self.navigationController viewControllers] firstObject] isEqual:self] && self.navigationController != nil) {
        RDVTabBarController *tabbarVC = (RDVTabBarController *)((AppDelegate *)[UIApplication sharedApplication].delegate).window.rootViewController;
        [tabbarVC setTabBarHidden:YES animated:YES];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if ([self isMemberOfClass:[HeLoginVC class]] || [self isMemberOfClass:[HeSlideMenuVC class]] || [self isMemberOfClass:[HeRealTimeTrendVC class]] || [self isMemberOfClass:[HeLogTableVC class]]) {
        
        return;
    }
    
    if (self.navigationController == nil) {
        if (![self isMemberOfClass:[HeInfoMenuVC class]]) {
            [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
            return;
        }
    }
    
    if (![[[self.navigationController viewControllers] firstObject] isEqual:self]) {
        [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
        RDVTabBarController *tabbarVC = (RDVTabBarController *)((AppDelegate *)[UIApplication sharedApplication].delegate).window.rootViewController;
        [tabbarVC setTabBarHidden:NO animated:YES];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //开启iOS7的滑动返回效果
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        //只有在二级页面生效
        if ([self.navigationController.viewControllers count] >= 2) {
            self.navigationController.interactivePopGestureRecognizer.enabled = YES;
            self.navigationController.interactivePopGestureRecognizer.delegate = self;
        }
        else{
            self.navigationController.interactivePopGestureRecognizer.delegate = nil;
            self.navigationController.interactivePopGestureRecognizer.enabled = NO;
        }
    }
}

//变量资源的初始化
- (void)initializaiton
{
    
}

//视图的初始化
- (void)initView
{
    self.view.backgroundColor = APPDEFAULTVIEWCOLOR;
    
    if (![[[self.navigationController viewControllers] firstObject] isEqual:self]) {
        UIButton *backImage = [[UIButton alloc] init];
        [backImage setBackgroundImage:[UIImage imageNamed:@"navigationBar_back_icon"] forState:UIControlStateNormal];
        [backImage addTarget:self action:@selector(backItemClick:) forControlEvents:UIControlEventTouchUpInside];
        
        backImage.frame = CGRectMake(0, 0, 25, 25);
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backImage];
        backItem.target = self;
        self.navigationItem.leftBarButtonItem = backItem;
    }
    
}

- (void)backItemClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

//强制不支持横屏
- (BOOL)shouldAutorotate
{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
