//
//  HeUserCenterVC.m
//  sishi
//
//  Created by HeDongMing on 16/8/22.
//  Copyright © 2016年 Channce. All rights reserved.
//

#import "HeUserCenterVC.h"
#import "AppDelegate.h"
#import "HeSlideMenuVC.h"
#import "HeSearchVC.h"
#import "REFrostedViewController.h"
#import "HeTabBarVC.h"
#import "AppDelegate.h"

#define LEFTMARGIN 0

@interface HeUserCenterVC ()<SelectIndexPathProtocol>
@property(strong,nonatomic)HeSlideMenuVC *slideView;
@property(strong,nonatomic)UIImageView *imageView;

@end

@implementation HeUserCenterVC
@synthesize slideView;
@synthesize imageView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.backgroundColor = [UIColor clearColor];
        label.font = APPDEFAULTTITLETEXTFONT;
        label.textColor = APPDEFAULTTITLECOLOR;
        label.textAlignment = NSTextAlignmentCenter;
        self.navigationItem.titleView = label;
        label.text = @"我的";
        [label sizeToFit];
        
        self.title = @"";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initializaiton];
    [self initView];
    
}

- (void)initializaiton
{
    [super initializaiton];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismissMenu) name:@"dismissMenu" object:nil];
}
- (void)initView
{
    [super initView];
    
    
    
    self.navigationController.navigationBarHidden = YES;
    
//    slideView = [[HeSlideMenuVC alloc] init];
//    slideView.selectIndexDelegate = self;
//    [self addChildViewController:slideView];
//    slideView.view.hidden = YES;
}
//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:YES];
////    [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
////    RDVTabBarController *tabbarVC = (RDVTabBarController *)((AppDelegate *)[UIApplication sharedApplication].delegate).window.rootViewController;
////    [tabbarVC setTabBarHidden:YES animated:YES];
//    HeTabBarVC *tabBarVC = (HeTabBarVC *)((AppDelegate *)([UIApplication sharedApplication].delegate).window.rootViewController);
//    imageView = tabBarVC.currentSnapShot;
//    
//    
//    UIView *alphaView = [[UIView alloc] initWithFrame:imageView.bounds];
//    alphaView.backgroundColor = [UIColor blackColor];
//    alphaView.alpha = 0.6;
//    [imageView addSubview:alphaView];
//    imageView.userInteractionEnabled = YES;
//    [self.view addSubview:imageView];
//}
//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:YES];
//    
//    slideView.view.frame = CGRectMake(LEFTMARGIN, 0, SCREENWIDTH, SCREENHEIGH);
//    [self.view addSubview:slideView.view];
//    UIView *view = [self.view viewWithTag:10086];
//    [self.view addSubview:view];
//    
//    [self.navigationController performSelector:@selector(showMenu) withObject:nil afterDelay:0];
//}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)dismissMenu
{
    HeTabBarVC *tabBarVC = (HeTabBarVC *)((AppDelegate *)([UIApplication sharedApplication].delegate).window.rootViewController);
    NSInteger index = tabBarVC.preSelectIndex;
    if (index == -1 || index == 3) {
        index = 0;
    }
    [tabBarVC setSelectedIndex:index];
}


- (void)selectAtIndex:(NSIndexPath *)path animation:(BOOL)animation
{
    NSInteger row = 0;
    NSInteger section = 0;
    HeTabBarVC *tabBarVC = (HeTabBarVC *)((AppDelegate *)([UIApplication sharedApplication].delegate).window.rootViewController);
    switch (section) {
        case 0:
        {
            switch (row) {
                case 0:
                {
                    
                    REFrostedViewController *userfrostedVC = (REFrostedViewController *)[[tabBarVC viewControllers] objectAtIndex:3];
                    [userfrostedVC hideMenuViewController];
                    HeSearchVC *searchVC = [[HeSearchVC alloc] init];
                    searchVC.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:searchVC animated:YES];
                    break;
                }
                default:
                    break;
            }
            break;
        }
        default:
            break;
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
