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


#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializaiton];
    [self initView];
    [self loadDataFromLocal];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.view addSubview:footerView];
}
- (void)initializaiton
{
    [super initializaiton];
    titledataSource = @[@"搜索",@"我的行程",@"设置",@"关于我们",@"向我们反馈"];
    dataSource = @[@"icon_search",@"icon_trip",@"icon_set_black",@"icon_aboutus",@"icon_feedback"];
    
    
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
    
    NSString *username = @"Tony";
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
    markLabel.text = @"VIP5";
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
    phoneLabel.text = @"13650707294";
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
    tipLabel.textAlignment = NSTextAlignmentLeft;
    tipLabel.font = [UIFont systemFontOfSize:18.0];
    tipLabel.text = @"切换到用户模式";
    tipLabel.textColor = [UIColor blackColor];
    [footerView addSubview:tipLabel];

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
    
    // set the root controller
    NSLog(@"%@",self.navigationController);
    [_hostVC showRootController:YES];
    
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (row) {
        case 0:
        {
            if (self.selectIndexDelegate != nil) {
                [self.selectIndexDelegate selectAtIndex:indexPath animation:YES];
                return;
            }
            if (self.customnav != nil) {
                HeSearchVC *searchVC = [[HeSearchVC alloc] init];
                searchVC.hidesBottomBarWhenPushed = YES;
                [self.customnav pushViewController:searchVC animated:YES];
                return;
            }
            HeSearchVC *searchVC = [[HeSearchVC alloc] init];
            searchVC.hidesBottomBarWhenPushed = YES;
            [_hostVC.rootVC pushViewController:searchVC animated:YES];
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

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"updateChannel" object:nil];
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
