//
//  HeSlideMenuVC.m
//  carTune
//
//  Created by Tony on 16/6/28.
//  Copyright © 2016年 Jitsun. All rights reserved.
//

#import "HeSlideMenuVC.h"
#import "DDMenuController.h"
#import "HeBaseIconTitleTableCell.h"
#import "HeSearchVC.h"
#import "MyTripListController.h"
#import "SettingsController.h"
#import "FocusListViewController.h"
#import <UMMobClick/MobClick.h>
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <ShareSDKUI/ShareSDKUI.h>
#import "PersonalController.h"
#import "ApiUtils.h"
#import "FeedbackController.h"


#define kMenuDisplayedWidth 280.0f
#define TextLineHeight 1.2f

@interface HeSlideMenuVC ()<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)NSArray *dataSource;
@property(strong,nonatomic)NSArray *titledataSource;
@property(strong,nonatomic)UILabel *nameLabel;
@property(strong,nonatomic)UILabel *phoneLabel;
@property(strong,nonatomic)UILabel *markLabel;
@property(strong,nonatomic)UIImageView *userImage;
@property(strong,nonatomic)IBOutlet UIView *footerView;

@end

@implementation HeSlideMenuVC
@synthesize dataSource;
@synthesize titledataSource;
@synthesize nameLabel;
@synthesize phoneLabel;
@synthesize markLabel;
@synthesize userImage;
@synthesize footerView;
@synthesize selectIndexDelegate;

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializaiton];
    [self initView];
    [self loadDataFromLocal];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.rdv_tabBarController setTabBarHidden:NO animated:YES];
    [self.view addSubview:footerView];
}
- (void)initializaiton
{
    [super initializaiton];
    titledataSource = @[@"搜索",@"我的行程",@"设置",@"关于我们",@"向我们反馈",@"我关注的人",@"邀请我的好友"];
    dataSource = @[@"icon_search",@"icon_trip",@"icon_set_black",@"icon_aboutus",@"icon_feedback",@"icon_collection.png",@"icon_invite.png"];
}

- (void)loadDataFromLocal
{
    
}

- (void)updateChannel:(NSNotification *)notificaiton
{
    
}

- (void)initView
{
    [super initView];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onChangeUserInfo:) name:kNotificationUserInfoChange object:nil];
    
    [Tool setExtraCellLineHidden:_tableView];
    _tableView.separatorStyle = UITableViewCellAccessoryNone;
    _tableView.backgroundView = nil;
    _tableView.backgroundColor = [UIColor whiteColor];
    
    CGFloat statusHeight = [UIApplication sharedApplication].statusBarFrame.size.height;
    CGFloat userInfoHeight = 100;
    UIView *userInfoView = [[UIView alloc] initWithFrame:CGRectMake(0, statusHeight, SCREENWIDTH, 150)];
    
    UIView *tableHeader = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, statusHeight + userInfoHeight)];
    tableHeader.userInteractionEnabled = YES;
    [tableHeader addSubview:userInfoView];
    userInfoView.userInteractionEnabled = YES;
    tableHeader.backgroundColor = _tableView.backgroundColor;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onInfoViewTap:)];
    [tableHeader addGestureRecognizer:tap];
    _tableView.tableHeaderView = tableHeader;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    CGFloat headX = 10;
    CGFloat headY = 20;
    CGFloat headH = userInfoHeight - 2 * headY;
    CGFloat headW = headH;
    
    userImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"demo_nearBgImage.jpg"]];
    userImage.layer.masksToBounds = YES;
    userImage.layer.cornerRadius = headW / 2.0;
    userImage.contentMode = UIViewContentModeScaleAspectFill;
    userImage.frame = CGRectMake(headX, headY, headW, headH);
    [userInfoView addSubview:userImage];
    NSString *imageString = [Tool defaultsForKey:kDefaultsUserHeaderImage];
    if ([imageString hasPrefix:@"http"] || [imageString hasPrefix:@"HTTP"]) {
        [userImage sd_setImageWithURL:[NSURL URLWithString:imageString]];
    } else {
        [userImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[ApiUtils baseUrl],imageString]]];
    }
    
    NSString *username = [Tool defaultsForKey:kDefaultsUserNick];
    UIFont *textFont = [UIFont systemFontOfSize:20.0];
    CGFloat nameLabelX = CGRectGetMaxX(userImage.frame) + 10;
    CGFloat nameLabelY = headY;
    CGFloat nameLabelH = headH / 2.0;
    CGFloat nameLabelW = SCREENWIDTH - nameLabelX - 10 - 80;
    nameLabel = [[UILabel alloc] init];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.text = username;
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.font = textFont;
    nameLabel.frame = CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    [userInfoView addSubview:nameLabel];
    
    
    CGFloat maxWidth = nameLabelW;
    CGSize textSize = [MLLinkLabel getViewSizeByString:username maxWidth:maxWidth font:textFont lineHeight:TextLineHeight lines:0];
    CGRect frame = nameLabel.frame;
    frame.size.width = textSize.width;
    nameLabel.frame = frame;
    
    CGFloat signLabelX = CGRectGetMaxX(nameLabel.frame) + 10;
    CGFloat signLabelY = headY;
    CGFloat signLabelH = headH / 2.0;
    CGFloat signLabelW = 70;
    markLabel = [[UILabel alloc] init];
    markLabel.textAlignment = NSTextAlignmentLeft;
    markLabel.backgroundColor = [UIColor clearColor];
    markLabel.text = @"未认证";
    markLabel.textAlignment = NSTextAlignmentLeft;
    markLabel.textColor = [UIColor redColor];
    markLabel.font = textFont;
    markLabel.frame = CGRectMake(signLabelX, signLabelY, signLabelW, signLabelH);
    [userInfoView addSubview:markLabel];
    
    
    CGFloat phoneLabelX = CGRectGetMaxX(userImage.frame) + 10;
    CGFloat phoneLabelY = CGRectGetMaxY(nameLabel.frame);
    CGFloat phoneLabelH = headH / 2.0;
    CGFloat phoneLabelW = SCREENWIDTH - nameLabelX - 10;
    phoneLabel = [[UILabel alloc] init];
    phoneLabel.textAlignment = NSTextAlignmentLeft;
    phoneLabel.backgroundColor = [UIColor clearColor];
    phoneLabel.text = [Tool defaultsForKey:kDefaultsUserPhone];
    phoneLabel.textAlignment = NSTextAlignmentLeft;
    phoneLabel.textColor = [UIColor grayColor];
    phoneLabel.font = textFont;
    phoneLabel.frame = CGRectMake(phoneLabelX, phoneLabelY, phoneLabelW, phoneLabelH);
    [userInfoView addSubview:phoneLabel];
    
    UIView *sepLine = [[UIView alloc] initWithFrame:CGRectMake(0, userInfoHeight - 2, SCREENWIDTH, 2)];
    sepLine.backgroundColor = [UIColor colorWithWhite:237.0 / 255.0 alpha:1.0];
    [userInfoView addSubview:sepLine];
    
    CGFloat height = 44;
//    footerView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREENHEIGH - height, SCREENWIDTH, height)];
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 0, SCREENWIDTH, height)];
    [tipLabel setBackgroundColor:[UIColor clearColor]];
    tipLabel.userInteractionEnabled = YES;
    tipLabel.textAlignment = NSTextAlignmentLeft;
    tipLabel.font = [UIFont systemFontOfSize:18.0];
    NSString *userJudge = [[Tool judge] isEqualToString:@"0"] ? @"用户" : @"车主";
    tipLabel.text = [NSString stringWithFormat:@"切换到%@模式",userJudge];
    tipLabel.textColor = [UIColor blackColor];
    UITapGestureRecognizer *tipLabelTapGest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onChangeLoginType:)];
    [tipLabel addGestureRecognizer:tipLabelTapGest];
    [footerView addSubview:tipLabel];
    
    [[NSNotificationCenter defaultCenter]addObserverForName:kNotificationUserChangeState object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        NSString *userJudge = [[Tool judge] isEqualToString:@"0"] ? @"用户" : @"车主";
        tipLabel.text = [NSString stringWithFormat:@"切换到%@模式",userJudge];
    }];

    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(10, (height - 25) / 2.0, 25, 25)];
    icon.image = [UIImage imageNamed:@"icon_change"];
    [footerView addSubview:icon];
    [self.view addSubview:footerView];
//    CGRect rectNav = self.hostVC.rootVC.navigationBar.frame;
//    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
//    rectNav.size.height = rectNav.size.height + rectStatus.size.height;
//    
//    UIImage *navBackgroundImage = [UIImage imageNamed:@"NavBarIOS7"];
//    NSDictionary *attributeDict = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:20.0]};
//    
//    UINavigationBar *narvigationBar = [[UINavigationBar alloc] initWithFrame:rectNav];
//    [narvigationBar setTintColor:NAVTINTCOLOR];
//    [narvigationBar setBackgroundImage:navBackgroundImage forBarMetrics:UIBarMetricsDefault];
//    [narvigationBar setTitleTextAttributes:attributeDict];
//    [self.view addSubview:narvigationBar];
    
    UINavigationItem *navitem = [[UINavigationItem alloc] initWithTitle:@""];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:20.0];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"我关注的";
    [label sizeToFit];
    navitem.titleView = label;
//    [narvigationBar pushNavigationItem:navitem animated:NO];

    
    
}

- (void)onChangeUserInfo:(NSNotification *)note {
    NSString *imageLink = [Tool defaultsForKey:kDefaultsUserHeaderImage];
    [self.userImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[ApiUtils baseUrl],imageLink]]];
    NSString *uNick = [Tool defaultsForKey:kDefaultsUserPhone];
    self.phoneLabel.text = uNick;
    NSString *authLabelString = @"未认证";
    if ([Tool isCertificationed]) {
        authLabelString = @"已认证";
    }
    markLabel.text = authLabelString;
}

- (void)onChangeLoginType:(UITapGestureRecognizer *)tap {
//    [self showHint:@"will change login state..."];
//    NSString *judge = [Tool judge];
    [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
    [ApiUtils switchUserStateWithCompleteHandler:^(NSInteger state) {
        [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%ld",state] forKey:kDefaultsUserJudge];
        [[NSNotificationCenter defaultCenter]postNotificationName:kNotificationUserChangeState object:nil];
        [NSUserDefaults standardUserDefaults];
        [MBProgressHUD hideHUDForView:self.view.window animated:YES];
        [self showHint:[NSString stringWithFormat:@"%@模式",state == 0 ? @"车主" : @"用户"]];
    } errorHandler:^(NSString *responseErrorInfo) {
        [self showHint:responseErrorInfo];
        [MBProgressHUD hideHUDForView:self.view.window animated:YES];
    }];
}

- (void)onInfoViewTap:(UITapGestureRecognizer *)tap {
    PersonalController *person = [[PersonalController alloc]initWithNibName:@"PersonalController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:person animated:YES];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return [titledataSource count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    CGSize cellsize = [tableView rectForRowAtIndexPath:indexPath].size;
    CGFloat cellH = cellsize.height;
    
    static NSString *cellIndentifier = @"HeSlideMenuCell";
    HeBaseIconTitleTableCell *cell  = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[HeBaseIconTitleTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier cellSize:cellsize];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        
    }
    NSString *title = titledataSource[row];
    NSString *icon = dataSource[row];
    cell.topicLabel.text = title;
    cell.icon.image = [UIImage imageNamed:icon];
    
    return cell;
    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%@",self.navigationController);
    [_hostVC showRootController:YES];
    
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (row) {
        case 0:
        {
            HeSearchVC *searchVC = [[HeSearchVC alloc] init];
            searchVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:searchVC animated:YES];
            break;
        }
        case 1: {
            MyTripListController *myTripList = [[MyTripListController alloc]init];
            myTripList.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:myTripList animated:YES];
            break;
        }
        case 2: {
            SettingsController *settingController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"SettingsController"];
            settingController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:settingController animated:YES];
        }break;
        case 4: {
            FeedbackController *feedBack = [[UIStoryboard storyboardWithName:@"Main"
                                                                      bundle:[NSBundle mainBundle]]
                                            instantiateViewControllerWithIdentifier:@"FeedbackController"];
            [self.navigationController pushViewController:feedBack animated:YES];
            break;
        }
        case 5:{
            FocusListViewController *focusController = [[FocusListViewController alloc]initWithStyle:UITableViewStylePlain];
            focusController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:focusController animated:YES];
        }break;
        case 6:
        {
            NSMutableDictionary *shareParas = [NSMutableDictionary dictionary];
            [shareParas SSDKSetupShareParamsByText:@"司事,约你一路同行" images:nil url:[NSURL URLWithString:@"baidu.com"] title:@"司事" type:SSDKContentTypeAuto];
//         [ShareSDK share:SSDKPlatformTypeSinaWeibo | SSDKPlatformSubTypeWechatSession | SSDKPlatformSubTypeWechatTimeline parameters:shareParas onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
//             NSLog(@"share state %lu",(unsigned long)state);
//         }];
            
           [ShareSDK showShareActionSheet:self.view
                                                                                       items:nil
                                                                                 shareParams:shareParas
                                                                         onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                                                                             switch (state) {
                                                                                 case SSDKResponseStateSuccess:
                                                                                     NSLog(@"分享成功");
                                                                                     break;
                                                                                case SSDKResponseStateFail:
                                                                                     NSLog(@"分享失败");
                                                                                     break;
                                                                                 default:
                                                                                     break;
                                                                             }
          }];
            
//            [shareActionSheet showInView:self.view];
            break;
        }
        default:
            break;
    }
    
    
    
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    CGFloat sectionHeight = [tableView rectForHeaderInSection:section].size.height;
//    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMenuDisplayedWidth, sectionHeight)];
//    headerView.backgroundColor = [UIColor clearColor];
//    
////    CGFloat rX = kMenuDisplayedWidth / 4.0;
////    CGFloat rY = 0;
////    CGFloat rW = kMenuDisplayedWidth / 4.0;
////    CGFloat rH = sectionHeight;
////    CAGradientLayer *gradient = [CAGradientLayer layer];
////    gradient.frame = CGRectMake(rX, rY, rW, rH);
////    gradient.colors = [NSArray arrayWithObjects:
////                       (id)[UIColor blackColor].CGColor,
////                       (id)[UIColor colorWithWhite:100.0 / 255.0 alpha:1.0].CGColor,
////                       nil];
////    [headerView.layer insertSublayer:gradient atIndex:0];
//    
//    UILabel *textLabel = [[UILabel alloc] initWithFrame:headerView.bounds];
//    textLabel.backgroundColor = [UIColor clearColor];
//    textLabel.font = [UIFont boldSystemFontOfSize:24.0];
//    textLabel.textColor = [UIColor redColor];
//    textLabel.textAlignment = NSTextAlignmentCenter;
//    textLabel.text = titledataSource[section];
//    [headerView addSubview:textLabel];
//    
//    return headerView;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 50;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 0.1;
//}

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
