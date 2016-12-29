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
#import "ApiUtils.h"
#import "LabelSelectView.h"

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
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet UILabel *signLabel;
@property (weak, nonatomic) IBOutlet LabelSelectView *labelView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelViewHeightConstraint;

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
    self.nameLabel.text = [Tool defaultsForKey:kDefaultsUserNick];
    self.imageBanner.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    [self configPageInfo];
    
    self.labelView.labelFont = [UIFont systemFontOfSize:14];
    kWeakSelf;
    self.labelView.onChangeHeight = ^(CGFloat height) {
        weakSelf.labelViewHeightConstraint.constant = height;
        [weakSelf.containerView layoutIfNeeded];
    };
}

- (void)onEdit:(UIBarButtonItem *)edit {
    UserInfoEditController *editController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"UserInfoEditController"];
    editController.imageLinkgroup = self.imageBanner.imageURLStringsGroup;
    [self.navigationController pushViewController:editController animated:YES];
}

- (void)configPageInfo {
    //查询个人评价信息
    [ApiUtils queryCommentLabelsForUser:[Tool uid] withCompleteHandler:^(NSArray<UserCommentLabelModel *> *labels) {
        NSMutableArray *titleList = [NSMutableArray arrayWithCapacity:labels.count];
        for (UserCommentLabelModel *model in labels) {
            [titleList addObject:model.labelName];
        }
        
        self.labelView.labelList = [NSArray arrayWithArray:titleList];
    } errorHandler:^(NSString *responseErrorInfo) {
        
    }];
    
    [ApiUtils getMyWallPicsWithCompleteHandler:^(NSArray<NSString *> *responseImages) {//查询照片墙
        self.imageBanner.imageURLStringsGroup = responseImages;
    } errorHandler:^(NSString *responseErrorInfo) {
        [self showHint:responseErrorInfo];
    }];
    
    ///查询用户个人信息
    [ApiUtils queryCurrentUserInfoWithCompleteHander:^(UserFollowListModel*responseInfo) {
//        NSArray *imageNameList = [responseInfo.userHeader componentsSeparatedByString:@","];
//        NSMutableArray *imageLinkList = [NSMutableArray arrayWithCapacity:imageNameList.count];
//        for (NSString *imageName in imageNameList) {
//            if ([imageName hasPrefix:@"http"] || [imageName hasPrefix:@"HTTP"]) {
//                [imageLinkList addObject:imageName];
//            } else {
//                [imageLinkList addObject:[NSString stringWithFormat:@"%@%@",[ApiUtils baseUrl],imageName]];
//            }
//        }
//        self.imageBanner.imageURLStringsGroup = imageLinkList;
        NSString *gender = responseInfo.userSex;
        if ([gender isEqualToString:@"1"]) {
            self.sexLabel.text = @"男";
        } else if ([gender isEqualToString:@"@"]) {
            self.sexLabel.text = @"女";
        } else {
            self.sexLabel.text = @"";
        }
        self.ageLabel.text = [NSString stringWithFormat:@"%@",responseInfo.userAge];
        self.signLabel.text = responseInfo.userSign;
        
        if (!responseInfo.userPass) {//未认证
            self.authViewHeightConstraint.constant = 0;
            [self.containerView layoutIfNeeded];
        } else {
            self.authLabel.text = @"已认证";
        }
        NSString *hobbys = responseInfo.userCarlable ? responseInfo.userCarlable : @"";
        NSString *hobbyString = [NSString stringWithFormat:@"爱好      %@",hobbys];
        [self.hobbyBtn setTitle:hobbyString forState:UIControlStateNormal];
        
    } errorHandler:^(NSString *responseErrorInfo) {
        [self showHint:responseErrorInfo];
    } ];
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
