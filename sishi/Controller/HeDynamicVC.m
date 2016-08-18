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

@interface HeDynamicVC ()
{
    BOOL requestReply; //是否实时
}
@property(strong,nonatomic)HeLogTableVC *logVC;
@property(strong,nonatomic)HeRealTimeTrendVC *realTimeVC;
@property(strong,nonatomic)UIViewController *currentVC;
@property(strong,nonatomic)UIView *sectionHeaderView;
@property(nonatomic,strong) NYSegmentedControl *segmentedControl;

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
    [self initView];
}

- (void)initializaiton
{
    [super initializaiton];
    requestReply = NO;
}

- (void)initView
{
    [super initView];
    
    NSArray *titleArray = @[@"动态",@"实时"];
    segmentedControl = [[NYSegmentedControl alloc] initWithItems:titleArray];
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
    [segmentedControl sizeToFit];
    segmentedControl.cornerRadius = 5.0;
    
    
    sectionHeaderView = [[UIView alloc] initWithFrame:CGRectMake(-10, 0, SCREENWIDTH, 40)];
    sectionHeaderView.backgroundColor = [UIColor colorWithWhite:237.0 / 255.0 alpha:1.0];
    sectionHeaderView.userInteractionEnabled = YES;
    
    NSArray *buttonArray = @[@"动态",@"实时"];
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
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(sectionHeaderView.frame.size.width / 2.0, 10, 1, 20)];
    line.backgroundColor = [UIColor grayColor];
    [sectionHeaderView addSubview:line];
    
    self.navigationItem.titleView = sectionHeaderView;
//    [self.view addSubview:sectionHeaderView];
    
    logVC = [[HeLogTableVC alloc] init];
    [self addChildViewController:logVC];
    realTimeVC = [[HeRealTimeTrendVC alloc] init];
    [self addChildViewController:realTimeVC];
    
    
    realTimeVC.view.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGH);
    self.currentVC = logVC;
    [self.view addSubview:logVC.view];
}

- (UIButton *)buttonWithTitle:(NSString *)buttonTitle frame:(CGRect)buttonFrame
{
    UIButton *button = [[UIButton alloc] initWithFrame:buttonFrame];
    [button setTitle:buttonTitle forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithWhite:143.0 / 255.0 alpha:1.0] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [button addTarget:self action:@selector(filterButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[Tool buttonImageFromColor:[UIColor whiteColor] withImageSize:button.frame.size] forState:UIControlStateNormal];
//    [button setBackgroundImage:[Tool buttonImageFromColor:sectionHeaderView.backgroundColor withImageSize:button.frame.size] forState:UIControlStateNormal];
    
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
    
    [self addChildViewController:newController];
    [self transitionFromViewController:oldController toViewController:newController duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:^(BOOL finished) {
        
        if (finished) {
            
            [newController didMoveToParentViewController:self];
            [oldController willMoveToParentViewController:nil];
            [oldController removeFromParentViewController];
            self.currentVC = newController;
            
        }else{
            
            self.currentVC = oldController;
            
        }
    }];
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
