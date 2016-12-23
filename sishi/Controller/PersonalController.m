//
//  PersonalController.m
//  sishi
//
//  Created by likeSo on 2016/12/21.
//  Copyright © 2016年 Channce. All rights reserved.
//

#import "PersonalController.h"
#import "SDCycleScrollView.h"
#import "UserInfoEditController.h"

@interface PersonalController ()
@property (weak, nonatomic) IBOutlet SDCycleScrollView *imageBanner;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *sexLabel;
@property (weak, nonatomic) IBOutlet UILabel *authLabel;
///"已认证"View高度的约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *authViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UIButton *hobbyBtn;
@property (weak, nonatomic) IBOutlet UIButton *confidenceValueLabel;
/**
 *  titleAttributes
 */
@property(nonatomic,strong)NSDictionary *titleAttributes;

@end

//当当前用户未认证时,将authViewHeightConstraint的约束值改为0
@implementation PersonalController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的信息";
    UIButton *editItem = [UIButton buttonWithType:UIButtonTypeSystem];
    editItem.frame = CGRectMake(0, 0, 25, 25);
    [editItem setBackgroundImage:[UIImage imageNamed:@"icon_edit_white.png"] forState:UIControlStateNormal];
    [editItem addTarget:self action:@selector(onEdit:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:editItem];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
}

- (void)onEdit:(UIBarButtonItem *)edit {
    UserInfoEditController *editController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"UserInfoEditController"];
    [self.navigationController pushViewController:editController animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.titleAttributes = self.navigationController.navigationBar.titleTextAttributes;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.titleTextAttributes = self.titleAttributes;
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setShadowImage:nil];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
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
