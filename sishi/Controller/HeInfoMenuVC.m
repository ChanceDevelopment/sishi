//
//  HeInfoMenuVC.m
//  carTune
//
//  Created by Tony on 16/6/28.
//  Copyright © 2016年 Jitsun. All rights reserved.
//

#import "HeInfoMenuVC.h"
#import "HeHomePageVC.h"
#import "CustomNavigationController.h"

#define kMenuDisplayedWidth 280.0f

@interface HeInfoMenuVC ()
@property(strong,nonatomic)UITapGestureRecognizer *tap;

@end

@implementation HeInfoMenuVC
@synthesize rootVC;
@synthesize leftViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont boldSystemFontOfSize:20.0];
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        self.navigationItem.titleView = label;
        label.text = @"最新关注";
        [label sizeToFit];
        self.title = @"";
    }
    return self;
}

- (id)initWithRootController:(UIViewController *)root
{
    if (self = [super init]) {
        rootVC = root;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initializaiton];
    [self initView];
}


//变量资源的初始化
- (void)initializaiton
{
    
}

//视图的初始化
- (void)initView
{
    self.navigationController.navigationBarHidden = YES;
    CGFloat tabbarHeight = ((CustomNavigationController *)rootVC).navigationBar.frame.size.height + [UIApplication sharedApplication].statusBarFrame.size.height;
    if (SCREENHEIGH > 700) {
        //iPhone6 Plus
        //54：状态栏高度  132：导航栏高度
        tabbarHeight = (54 + 132 + tabbarHeight + 20 ) / 2.0;
    }
    rootVC.view.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGH - tabbarHeight);
    [self.view addSubview:rootVC.view];
    [self.view insertSubview:leftViewController.view atIndex:0];
    
    self.view.backgroundColor = APPDEFAULTVIEWCOLOR;
    
    if (!_tap) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        tap.delegate = (id<UIGestureRecognizerDelegate>)self;
        [self.view addGestureRecognizer:tap];
        [tap setEnabled:NO];
        _tap = tap;
    }
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 30, 20, 20);
    [button setBackgroundImage:[UIImage imageNamed:@"menuIcon.png"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"menuIcon.png"] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(showLeft:) forControlEvents:UIControlEventTouchUpInside];
    
//    [self.view addSubview:button];
//    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:button];
//    
//    UIViewController *topVC = [((UINavigationController *)rootVC).viewControllers firstObject];
//    topVC.navigationItem.leftBarButtonItem = leftItem;
}

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo
{
    if ([eventName isEqualToString:@"showLeft"]) {
        [self showLeft:nil];
    }
}
- (void)tap:(UITapGestureRecognizer *)gesture
{
    [gesture setEnabled:NO];
    [self showRootController:YES];
}

- (void)showRootController:(BOOL)animated {
    
    [_tap setEnabled:NO];
    rootVC.view.userInteractionEnabled = YES;
    
    CGRect frame = rootVC.view.frame;
    frame.origin.x = 0.0f;
    
    BOOL _enabled = [UIView areAnimationsEnabled];
    if (!animated) {
        [UIView setAnimationsEnabled:NO];
    }
    
    [UIView animateWithDuration:.3 animations:^{
        
        rootVC.view.frame = frame;
        
    } completion:^(BOOL finished) {
        
        if (leftViewController && leftViewController.view.superview) {
            [leftViewController.view removeFromSuperview];
        }
        
        
        [self showShadow:NO];
        
    }];
    
    if (!animated) {
        [UIView setAnimationsEnabled:_enabled];
    }
    
}

- (void)showRootController:(BOOL)animated pushController:(UIViewController *)controller
{
    [_tap setEnabled:NO];
    rootVC.view.userInteractionEnabled = YES;
    
    CGRect frame = rootVC.view.frame;
    frame.origin.x = 0.0f;
    
    BOOL _enabled = [UIView areAnimationsEnabled];
    if (!animated) {
        [UIView setAnimationsEnabled:NO];
    }
    
    [UIView animateWithDuration:.3 animations:^{
        
        rootVC.view.frame = frame;
        
    } completion:^(BOOL finished) {
        
        if (leftViewController && leftViewController.view.superview) {
            [leftViewController.view removeFromSuperview];
        }
        [self showShadow:NO];
    }];
    
    if (!animated) {
        [UIView setAnimationsEnabled:_enabled];
    }
    if ([rootVC isKindOfClass:[UINavigationController class]]) {
        [((UINavigationController *)rootVC) pushViewController:controller animated:YES];
    }
}

- (void)showShadow:(BOOL)val {
    if (!rootVC) return;
    
    rootVC.view.layer.shadowOpacity = val ? 0.8f : 0.0f;
    if (val) {
        rootVC.view.layer.cornerRadius = 4.0f;
        rootVC.view.layer.shadowOffset = CGSizeZero;
        rootVC.view.layer.shadowRadius = 4.0f;
        rootVC.view.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.view.bounds].CGPath;
    }
    
}

- (void)showLeft:(UIButton *)button
{
    [self showShadow:YES];
    
    CGFloat offsetDistance = 280;
    
    UIView *view = self.leftViewController.view;
    CGRect frame = self.view.bounds;
    frame.size.width = SCREENWIDTH;
    view.frame = frame;
    [self.view insertSubview:view atIndex:0];
    [self.leftViewController viewWillAppear:YES];
    
    [leftViewController viewWillAppear:YES];
    
    
    frame = rootVC.view.frame;
    frame.origin.x = CGRectGetMaxX(view.frame) - (SCREENWIDTH - offsetDistance);
    
    BOOL _enabled = [UIView areAnimationsEnabled];
    
    rootVC.view.userInteractionEnabled = NO;
    [UIView animateWithDuration:.3 animations:^{
        rootVC.view.frame = frame;
    } completion:^(BOOL finished) {
        NSLog(@"%@",rootVC);
        [_tap setEnabled:YES];
    }];
    
    [UIView setAnimationsEnabled:YES];
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    // Check for horizontal pan gesture
    if (gestureRecognizer == _tap) {
        
        return CGRectContainsPoint(rootVC.view.frame, [gestureRecognizer locationInView:self.view]);
        
        return NO;
        
    }
    
    return YES;
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if (gestureRecognizer == _tap) {
        return YES;
    }
    return NO;
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

#pragma mark - UINavigationControllerDelegate
-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([viewController isEqual:self]) {
        [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
    }
    else{
        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
    }
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{

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
