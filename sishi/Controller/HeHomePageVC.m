//
//  HeHomePageVC.m
//  sishi
//
//  Created by HeDongMing on 16/8/13.
//  Copyright © 2016年 Channce. All rights reserved.
//

#import "HeHomePageVC.h"
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import "HeBaseTableViewCell.h"
#import "HeNearByTableCell.h"
#import "HeUserVC.h"
#import "AppDelegate.h"
#import "HeSlideMenuVC.h"
#import "HeSearchVC.h"
#import "REFrostedViewController.h"
#import "Masonry.h"
#import "HeDistributeInviteVC.h"
#import "MJRefresh.h"
#import "ApiUtils.h"

@interface HeHomePageVC ()<SelectIndexPathProtocol>
@property(weak,nonatomic)IBOutlet UITableView *tableview;
@property(strong,nonatomic)NSMutableArray *dataSource;
@property(strong,nonatomic)UIButton *menuButton;
/**
 *  发布新内容按钮
 */
@property(nonatomic,weak)IBOutlet UIButton *postButton;

/**
 *  数据源数组
 */
@property(nonatomic,strong)NSMutableArray *nearbyUserList;

@end

@implementation HeHomePageVC


- (NSMutableArray *)nearbyUserList {
    if (!_nearbyUserList) {
        _nearbyUserList = [NSMutableArray array];
    }
    return _nearbyUserList;
}
@synthesize tableview;
@synthesize dataSource;
@synthesize menuButton;

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
        label.text = @"首页";
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
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    [[NSNotificationCenter defaultCenter]addObserverForName:kNotificationUserChangeState object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        [self.tableview reloadData];
    }];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [_locService startUserLocationService];
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
    
//    UIViewController *rootVC = ((AppDelegate *)[UIApplication sharedApplication].delegate).window.rootViewController;
//    UIImage *image = [Tool snapshot:rootVC.view];
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
//    imageView.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGH);
//    imageView.userInteractionEnabled = YES;
//    HeTabBarVC *tabBarVC = (HeTabBarVC *)((AppDelegate *)([UIApplication sharedApplication].delegate).window.rootViewController);
//    tabBarVC.currentSnapShot = imageView;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
     [self.navigationController setNavigationBarHidden:YES animated:YES];
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _locService.delegate = self;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [BMKMapView enableCustomMapStyle:NO];//关闭个性化地图
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;
    
}
- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (void)dealloc {
    if (_mapView) {
        _mapView = nil;
    }
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


- (void)initializaiton
{
    [super initializaiton];
    _locService = [[BMKLocationService alloc]init];
    dataSource = [[NSMutableArray alloc] initWithCapacity:0];
}

- (void)initView
{
    [super initView];
//    self.navigationController.navigationBarHidden = YES;
    [Tool setExtraCellLineHidden:tableview];
    tableview.backgroundColor = [UIColor whiteColor];
    
//    menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    menuButton.frame = CGRectMake(10, 30, 20, 20);
    [menuButton setBackgroundImage:[UIImage imageNamed:@"menuIcon"] forState:UIControlStateNormal];
    [menuButton setBackgroundImage:[UIImage imageNamed:@"menuIcon"] forState:UIControlStateHighlighted];
    [menuButton addTarget:self action:@selector(showLeft:) forControlEvents:UIControlEventTouchUpInside];
    self.tableview.mj_header = ({
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(onHeaderRefresh:)];
        
        header;
    });
    [self.tableview.mj_header beginRefreshing];
}


- (void)onHeaderRefresh:(MJRefreshNormalHeader *)header {
    NSString *gender = [[NSUserDefaults standardUserDefaults]stringForKey:kDefaultsUserGender];
    CGFloat longitude = [[NSUserDefaults standardUserDefaults]doubleForKey:kDefaultsUserLocationlongitude];
    CGFloat latitude = [[NSUserDefaults standardUserDefaults]doubleForKey:kDefaultsUserLocationLatitude];
    [ApiUtils queryNearbyUserWithUserGender:[gender isEqualToString:@"1"] ? @"2" : @"1" longitude:longitude latitude:latitude startIndex:0 onResponse:^(NSArray<NearbyUserListModel *> *nearby) {
        [header endRefreshing];
        [self.nearbyUserList removeAllObjects];
        [self.nearbyUserList addObjectsFromArray:nearby];
        [self.tableview reloadData];
    } errorHandler:^(NSString *responseErrorInfo) {
        [header endRefreshing];
        [self showHint:responseErrorInfo ];
    }];
}
- (void)showLeft:(id)sender
{
    [self routerEventWithName:@"showLeft" userInfo:nil];
}
/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
    [_mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
    BMKCoordinateSpan span = BMKCoordinateSpanMake(0.013142, 0.011678);
    BMKCoordinateRegion region = BMKCoordinateRegionMake(userLocation.location.coordinate, span);
    [_mapView setRegion:region animated:YES];
    
    NSLog(@"heading is %@",userLocation.heading);
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    //    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [_mapView updateLocationData:userLocation];
    CGFloat longitude = userLocation.location.coordinate.longitude;
    CGFloat latitude = userLocation.location.coordinate.latitude;
    [[NSUserDefaults standardUserDefaults]setDouble:longitude forKey:kDefaultsUserLocationlongitude];
    [[NSUserDefaults standardUserDefaults]setDouble:latitude forKey:kDefaultsUserLocationLatitude];
}

/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)didStopLocatingUser
{
    NSLog(@"stop locate");
}

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"location error");
}

#pragma mark - BMKMapViewDelegate

- (void)mapViewDidFinishLoading:(BMKMapView *)mapView {
    //    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"BMKMapView控件初始化完成" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles: nil];
    //    [alert show];
    //    alert = nil;
}

- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate {
    NSLog(@"map view: click blank");
}

- (void)mapview:(BMKMapView *)mapView onDoubleClick:(CLLocationCoordinate2D)coordinate {
    NSLog(@"map view: double click");
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.nearbyUserList.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    
    static NSString *cellIndentifier = @"HeNearByIndentifier";
    CGSize cellSize = [tableView rectForRowAtIndexPath:indexPath].size;
    
    
    HeNearByTableCell *cell  = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[HeNearByTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier cellSize:cellSize];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(HeNearByTableCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    kWeakSelf;
    NearbyUserListModel *nearbyModel = self.nearbyUserList[indexPath.row];
    cell.model = nearbyModel;
    cell.onContactAction = ^(HeNearByTableCell *targetCell) {
        [MBProgressHUD showHUDAddedTo:weakSelf.view.window animated:YES];
        [ApiUtils sendAskingFor:nearbyModel.userId tripId:@" " withCompleteHandler:^{
            [weakSelf showHint:@"已发出邀约"];
            [MBProgressHUD hideHUDForView:weakSelf.view.window animated:YES];
        } errorHandler:^(NSString *responseErrorInfo) {
            [MBProgressHUD hideHUDForView:self.view.window animated:YES];
            [weakSelf showHint:responseErrorInfo];
        }];
    };
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    return 220;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 30)];
    header.backgroundColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:header.bounds];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:24.0];
    NSString *uNick = [Tool defaultsForKey:kDefaultsUserNick];
    titleLabel.text  = [NSString stringWithFormat:@"   %@  您好 !",uNick];
    [header addSubview:titleLabel];
    
    return header;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    NearbyUserListModel *nearbyModel = self.nearbyUserList[indexPath.row];
    HeUserVC *userVC = [[HeUserVC alloc] init];
    userVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:userVC animated:YES];
    userVC.uid = nearbyModel.userId;
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

#pragma mark :- 添加新发布
- (IBAction)onPost:(UIButton *)sender {
    HeDistributeInviteVC *distributeVC = [[HeDistributeInviteVC alloc] init];
    distributeVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:distributeVC animated:YES];
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
