//
//  HeTabBarVC.m
//  huayoutong
//
//  Created by HeDongMing on 16/3/2.
//  Copyright © 2016年 HeDongMing. All rights reserved.
//

#import "HeTabBarVC.h"
#import "RDVTabBarItem.h"
#import "RDVTabBar.h"
#import "RDVTabBarController.h"
#import "HeSlideMenuVC.h"
#import "HeSysbsModel.h"
#import "REFrostedViewController.h"
#import "HeSlideMenuVC.h"
#import "DEMONavigationController.h"
#import "DEMOMenuViewController.h"
#import "DEMOHomeViewController.h"

@interface HeTabBarVC ()

@end

@implementation HeTabBarVC
@synthesize userVC;
@synthesize homePageVC;
@synthesize chatVC;
@synthesize menuVC;
@synthesize dynamicVC;
@synthesize logVC;
@synthesize currentSnapShot;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self getUserInfo];
    //获取用户可操作的相册，在相册中需要用到
    [self getUserAlbum];
    //获取活动的类型还有地点
    [self getActivityTypeAddress];
    [self autoLogin];
    [self setupSubviews];
    
}

//后台自动登录
- (void)autoLogin
{
    
}

- (void)clearInfo
{
    
}

//获取用户的信息
- (void)getUserInfo
{
    
    
}

- (void)getUserAlbum
{
    
}

- (void)getActivityTypeAddress
{
    
}

//设置根控制器的四个子控制器
- (void)setupSubviews
{
    
    DEMONavigationController *navigationController = [[DEMONavigationController alloc] initWithRootViewController:[[HeHomePageVC alloc] init]];
    DEMOMenuViewController *mymenuController = [[DEMOMenuViewController alloc] initWithStyle:UITableViewStylePlain];
    
    // Create frosted view controller
    //
    
    
    homePageVC = [[HeHomePageVC alloc] init];
    homePageVC.view.userInteractionEnabled = YES;
    
    HeSlideMenuVC *homeMenuVC = [[HeSlideMenuVC alloc] init];
    CustomNavigationController *homeNav = [[CustomNavigationController alloc] initWithRootViewController:homePageVC];
    homeMenuVC.selectIndexDelegate = homePageVC;
    
    homeNav.navigationBarHidden = YES;
    homeNav.view.userInteractionEnabled = YES;
    
    REFrostedViewController *homefrostedVC = [[REFrostedViewController alloc] initWithContentViewController:homeNav menuViewController:homeMenuVC];
    homefrostedVC.view.userInteractionEnabled = YES;
    homefrostedVC.direction = REFrostedViewControllerDirectionRight;
    homefrostedVC.liveBlurBackgroundStyle = REFrostedViewControllerLiveBackgroundStyleLight;
    
//    CustomNavigationController *infoNav = [[CustomNavigationController alloc] initWithRootViewController:homePageVC];
//    
//    menuVC = [[HeInfoMenuVC alloc] initWithRootController:infoNav];
//    
//    HeSlideMenuVC *leftController = [[HeSlideMenuVC alloc] init];
//    leftController.hostVC = menuVC;
//    menuVC.leftViewController = leftController;
    
    dynamicVC = [[HeDynamicVC alloc] init];
    CustomNavigationController *dynamicNav = [[CustomNavigationController alloc] initWithRootViewController:dynamicVC];
    
//    logVC = [[HeLogTableVC alloc] init];
//    CustomNavigationController *logNav = [[CustomNavigationController alloc] initWithRootViewController:logVC];
    
    chatVC = [[HeChatVC alloc] init];
    CustomNavigationController *chatNav = [[CustomNavigationController alloc] initWithRootViewController:chatVC];
    
    userVC = [[HeUserCenterVC alloc] init];
    CustomNavigationController *userNav = [[CustomNavigationController alloc]
                                           initWithRootViewController:userVC];
    
    userNav.navigationBarHidden = YES;
    userNav.view.userInteractionEnabled = YES;
    
    HeSlideMenuVC *userMenuVC = [[HeSlideMenuVC alloc] init];
//    userMenuVC.customnav = userNav;
    REFrostedViewController *userfrostedVC = [[REFrostedViewController alloc] initWithContentViewController:userNav menuViewController:userMenuVC];
    userfrostedVC.view.userInteractionEnabled = YES;
    userfrostedVC.direction = REFrostedViewControllerDirectionRight;
    userfrostedVC.liveBlurBackgroundStyle = REFrostedViewControllerLiveBackgroundStyleLight;
    
    [self setViewControllers:@[homefrostedVC,dynamicNav,chatNav,userfrostedVC]];
    [self customizeTabBarForController];
}

//设置底部的tabbar
- (void)customizeTabBarForController{
    //    tabbar_normal_background   tabbar_selected_background
    UIImage *finishedImage = [UIImage imageNamed:@"tabbar_normal_background"];
    UIImage *unfinishedImage = [UIImage imageNamed:@"tabbar_normal_background"];
    NSArray *tabBarItemImages = @[@"tabar_homepage_icon", @"tabar_dynamic_icon", @"tabar_news_icon", @"tabar_user_icon"];
    
    NSInteger index = 0;
    for (RDVTabBarItem *item in [[self tabBar] items]) {
        [item setBackgroundSelectedImage:finishedImage withUnselectedImage:unfinishedImage];
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_active",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal",
                                                        [tabBarItemImages objectAtIndex:index]]];
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        
        index++;
    }
    self.view.userInteractionEnabled = YES;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 100) {
        //后台自动登录失败，退出登录
        [self clearInfo];
    }
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
