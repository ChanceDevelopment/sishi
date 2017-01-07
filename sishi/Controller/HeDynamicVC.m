//
//  HeDynamicVC.m
//  sishi
//
//  Created by HeDongMing on 16/8/17.
//  Copyright © 2016年 Channce. All rights reserved.
//

#import "HeDynamicVC.h"
#import "HeLogTableVC.h"
#import "HeRealTimeTrendVC.h"
#import "NYSegmentedControl.h"
#import "HeDistributeInviteVC.h"
#import "AppDelegate.h"

@interface HeDynamicVC ()
{
    BOOL requestReply; //是否实时
}
@property(strong,nonatomic)HeLogTableVC *logVC;
@property(strong,nonatomic)HeRealTimeTrendVC *realTimeVC;
@property(strong,nonatomic)UIViewController *currentVC;
@property(strong,nonatomic)UIView *sectionHeaderView;
@property(nonatomic,strong) NYSegmentedControl *segmentedControl;

/**
 *  -.-
 */
@property(nonatomic,strong)UIScrollView *scrollView;


@end

@implementation HeDynamicVC
@synthesize logVC;
@synthesize realTimeVC;
@synthesize currentVC;
@synthesize sectionHeaderView;
@synthesize segmentedControl;

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
        label.text = @"动态";
        
        [label sizeToFit];
        self.title = @"";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initializaiton];
    requestReply = YES;
    [self initView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.rdv_tabBarController setTabBarHidden:NO animated:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.rdv_tabBarController setTabBarHidden:NO animated:YES];
}

//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:YES];
//    UIViewController *rootVC = ((AppDelegate *)[UIApplication sharedApplication].delegate).window.rootViewController;
//    UIImage *image = [Tool snapshot:rootVC.view];
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
//    imageView.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGH);
//    imageView.userInteractionEnabled = YES;
//    HeTabBarVC *tabBarVC = (HeTabBarVC *)((AppDelegate *)([UIApplication sharedApplication].delegate).window.rootViewController);
//    tabBarVC.currentSnapShot = imageView;
//}

- (void)initializaiton
{
    [super initializaiton];
    requestReply = NO;
}

- (void)initView
{
    [super initView];
    
    /*NSArray *titleArray = @[@"动态",@"实时"];
    segmentedControl = [[NYSegmentedControl alloc] initWithItems:titleArray];
    segmentedControl.frame = CGRectMake(0, 20, SCREENWIDTH, 40);
    segmentedControl.titleTextColor = [UIColor whiteColor];
    segmentedControl.selectedTitleTextColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"NavBarIOS7"]];
    segmentedControl.selectedTitleFont = [UIFont systemFontOfSize:13.0f];
    segmentedControl.segmentIndicatorBackgroundColor = [UIColor whiteColor];
    segmentedControl.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"NavBarIOS7"]];
    [segmentedControl addTarget:self action:@selector(segmentedControlValueChange:) forControlEvents:UIControlEventValueChanged];
    segmentedControl.borderWidth = 0.5f;
    segmentedControl.borderColor = [UIColor whiteColor];
    segmentedControl.segmentIndicatorBorderWidth = 0.0f;
    segmentedControl.segmentIndicatorInset = 0.0f;
    segmentedControl.segmentIndicatorBorderColor = [UIColor whiteColor];
    //[segmentedControl sizeToFit];
    segmentedControl.cornerRadius = 5.0;
    //[self.view addSubview:segmentedControl];
    self.navigationItem.titleView = segmentedControl;*/
    
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
//     self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:nil action:nil];
    
   sectionHeaderView = [[UIView alloc] initWithFrame:CGRectMake(-10, 0, SCREENWIDTH, 40)];
    sectionHeaderView.backgroundColor = [UIColor colorWithWhite:237.0 / 255.0 alpha:1.0];
    sectionHeaderView.userInteractionEnabled = YES;
    sectionHeaderView.clipsToBounds = YES;
    
    UIButton *activityButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [activityButton setTitle:@"动态" forState:UIControlStateNormal];
    activityButton.frame = CGRectMake(0, 0, CGRectGetWidth(sectionHeaderView.frame) * 0.5, CGRectGetHeight(sectionHeaderView.frame));
    [activityButton setTitleColor:[UIColor colorWithRed:255 / 255.0 green:64 / 255.0 blue:74 / 255.0 alpha:1] forState:UIControlStateNormal];
    [activityButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    activityButton.tag = 10000;
    [activityButton addTarget:self action:@selector(onSegment:) forControlEvents:UIControlEventTouchUpInside];
    activityButton.backgroundColor = [UIColor whiteColor];
    [sectionHeaderView addSubview:activityButton];
    
    UIButton *moodButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [moodButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [moodButton setTitle:@"心情" forState:UIControlStateNormal];
    moodButton.frame = CGRectMake(CGRectGetMaxX(activityButton.frame), 0, CGRectGetWidth(activityButton.frame), CGRectGetHeight(activityButton.frame));
    [moodButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    moodButton.backgroundColor = [UIColor whiteColor];
    moodButton.tag = 10001;
    [moodButton addTarget:self action:@selector(onSegment:) forControlEvents:UIControlEventTouchUpInside];
    [sectionHeaderView addSubview:moodButton];
    
    UIView *verticalLineView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(activityButton.frame), 0, 1, CGRectGetHeight(activityButton.frame) * 0.5)];
    verticalLineView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    CGPoint center = verticalLineView.center;
    center.y = sectionHeaderView.frame.size.height * 0.5;
    verticalLineView.center = center;
    [sectionHeaderView addSubview:verticalLineView];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(sectionHeaderView.frame) - 1, CGRectGetWidth(sectionHeaderView.frame), 1)];
    lineView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [sectionHeaderView addSubview:lineView];
    
    
  /*   NSArray *buttonArray = @[@"动态",@"实时"];
    for (NSInteger index = 0; index < [buttonArray count]; index++) {
        CGFloat buttonW = SCREENWIDTH / [buttonArray count];
        CGFloat buttonH = sectionHeaderView.frame.size.height;
        CGFloat buttonX = index * buttonW;
        CGFloat buttonY = 0;
        CGRect buttonFrame = CGRectMake(buttonX , buttonY, buttonW, buttonH);
        UIButton *button = [self buttonWithTitle:buttonArray[index] frame:buttonFrame];
        button.tag = index + 100;
        if (index == 0) {
            button.selected = YES;
        }
        [sectionHeaderView addSubview:button];
    }
    CGFloat centerLineW = 1;
    CGFloat centerLineH = 20;
    CGFloat centerLineX = (CGRectGetWidth(sectionHeaderView.frame) - centerLineW) / 2.0;
    CGFloat centerLineY = (CGRectGetHeight(sectionHeaderView.frame) - centerLineH) / 2.0;
    UIView *centerline = [[UIView alloc] initWithFrame:CGRectMake(centerLineX, centerLineY, centerLineW, centerLineH)];
    centerline.backgroundColor = [UIColor grayColor];
    [sectionHeaderView addSubview:centerline];
    
    CGFloat bottomX = 0;
    CGFloat bottomH = 1;
    CGFloat bottomW = CGRectGetWidth(sectionHeaderView.frame);
    CGFloat bottomY = CGRectGetHeight(sectionHeaderView.frame) - bottomH;
    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(bottomX, bottomY, bottomW, bottomH)];
    bottomLine.backgroundColor = [UIColor grayColor];
    [sectionHeaderView addSubview:bottomLine];
    
   
//    [self.view addSubview:sectionHeaderView];*/
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.titleView = sectionHeaderView;
    CGFloat viewHeight = SCREENHEIGH - 49 - 64;
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, viewHeight)];
    _scrollView.pagingEnabled = YES;
    _scrollView.scrollEnabled = NO;
    _scrollView.contentSize = CGSizeMake(SCREENWIDTH * 2, 0);
    _scrollView.delaysContentTouches = NO;
    [self.view addSubview:_scrollView];
    
    
    logVC = [[HeLogTableVC alloc] init];
    logVC.automaticallyAdjustsScrollViewInsets = NO;
    logVC.view.frame = CGRectMake(SCREENWIDTH, 0, SCREENWIDTH, viewHeight);
    [self addChildViewController:logVC];
    
    
    realTimeVC = [[HeRealTimeTrendVC alloc] init];
    realTimeVC.automaticallyAdjustsScrollViewInsets = NO;
    [self addChildViewController:realTimeVC];
    
    realTimeVC.view.frame = CGRectMake(0, 0, SCREENWIDTH, viewHeight);
    
    [_scrollView addSubview:realTimeVC.view];
    [_scrollView addSubview:logVC.view];
    
//    self.currentVC = realTimeVC;
//    [self.view addSubview:logVC.view];
//    [self.view addSubview:realTimeVC.view];
}

- (IBAction)distributeButtonClick:(id)sender
{
    HeDistributeInviteVC *distributeVC = [[HeDistributeInviteVC alloc] init];
    distributeVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:distributeVC animated:YES];
}

- (UIButton *)buttonWithTitle:(NSString *)buttonTitle frame:(CGRect)buttonFrame
{
    UIButton *button = [[UIButton alloc] initWithFrame:buttonFrame];
    [button setTitle:buttonTitle forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithWhite:143.0 / 255.0 alpha:1.0] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [button addTarget:self action:@selector(filterButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[Tool buttonImageFromColor:[UIColor whiteColor] withImageSize:button.frame.size] forState:UIControlStateNormal];
    
    return button;
}

- (void)filterButtonClick:(UIButton *)button
{
    if ((requestReply == NO && button.tag == 100) || (requestReply == YES && button.tag == 101)) {
        return;
    }
    NSArray *subViewsArray = sectionHeaderView.subviews;
    for (UIView *subview in subViewsArray) {
        if ([subview isKindOfClass:[UIButton class]]) {
            ((UIButton *)subview).selected = !((UIButton *)subview).selected;
        }
    }
    if (button.tag == 100) {
        requestReply = NO;
        [self replaceController:currentVC newController:logVC];
    }
    else{
        requestReply = YES;
        [self replaceController:currentVC newController:realTimeVC];
    }
}

- (void)onSegment:(UIButton *) btn {
//    if ((btn.tag == 10000 && requestReply) || (btn.tag == 10001 && !requestReply)) {
//        return;
//    }
    [btn setTitleColor:[UIColor colorWithRed:255 / 255.0 green:64 / 255.0 blue:74 / 255.0 alpha:1] forState:UIControlStateNormal];
    for (UIView *subView in self.navigationItem.titleView.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            if (subView != btn)
                [(UIButton *)subView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
    }
//    if (btn.tag == 10000) {//动态
//        [self replaceController:logVC newController:realTimeVC];
//        requestReply = YES;
//    } else {
//        [self replaceController:realTimeVC newController:logVC];
//        requestReply = NO;
//    }
    if (btn.tag == 10000) {
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    } else {
        [self.scrollView setContentOffset:CGPointMake(SCREENWIDTH, 0) animated:YES];
    }
}

- (void)segmentedControlValueChange:(NYSegmentedControl *)sender
{
    NSLog(@"change");
    UIViewController *oldVC = self.currentVC;
    if (sender.selectedSegmentIndex == 0) {
        [self replaceController:oldVC newController:logVC];
    }
    else{
        [self replaceController:oldVC newController:realTimeVC];
    }
}

//切换各个标签内容
- (void)replaceController:(UIViewController *)oldController newController:(UIViewController *)newController
{
    /**
     *            着重介绍一下它
     *  transitionFromViewController:toViewController:duration:options:animations:completion:
     *  fromViewController      当前显示在父视图控制器中的子视图控制器
     *  toViewController        将要显示的姿势图控制器
     *  duration                动画时间(这个属性,old friend 了 O(∩_∩)O)
     *  options                 动画效果(渐变,从下往上等等,具体查看API)
     *  animations              转换过程中得动画
     *  completion              转换完成
     */
//    self.segmentedControl.enabled = NO;
    //一直crash,修改为直接修改视图层级
    /*[self transitionFromViewController:oldController toViewController:newController duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:^(BOOL finished) {
        
        if (finished) {
            
            [newController didMoveToParentViewController:self];
            [oldController willMoveToParentViewController:nil];
            [oldController removeFromParentViewController];
            self.currentVC = newController;
//            self.segmentedControl.enabled = YES;
        }else{
            
            self.currentVC = oldController;
            
        }
    }];*/
    [self.view bringSubviewToFront:newController.view];
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
