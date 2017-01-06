//
//  TripOnGoingController.m
//  sishi
//
//  Created by likeSo on 2016/12/28.
//  Copyright © 2016年 Channce. All rights reserved.
//

#import "TripOnGoingController.h"
#import <BaiduMapAPI_Map/BMKMapView.h>
#import "ReleaseMoodViewController.h"
#import "ApiUtils.h"
#import "EvaluationViewController.h"
#import "UIButton+EMWebCache.h"
#import "MapUserAnnotationModel.h"
#import "MapUserAnnotationView.h"

///刷新位置的间隔时间
static NSTimeInterval updateLocationInterval = 5.0;

@interface TripOnGoingController ()<BMKMapViewDelegate,BMKLocationServiceDelegate>
@property (weak, nonatomic) IBOutlet BMKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;

/**
 *  计时器
 */
@property(nonatomic,strong)NSTimer *timer;


/**
 *  百度定位服务
 */
@property(nonatomic,strong)BMKLocationService *locationService;


/**
 *  行程详情Model
 */
@property(nonatomic,strong)TripDetailModel *detailModel;

/**
 *  另一位用户的地理位置
 */
@property(nonatomic,strong)MapUserAnnotationModel *userAnnotationModel;

/**
 *  我的 地理位置信息
 */
@property(nonatomic,strong)MapUserAnnotationModel *myAnnotationModel;
@property (weak, nonatomic) IBOutlet UIButton *exitBtn;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;

@end

@implementation TripOnGoingController

- (void)dealloc {
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.exitBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    self.backBtn.imageEdgeInsets = UIEdgeInsetsMake(10,10, 10, 10);
    
    self.leftBtn.layer.cornerRadius = 30.0;
    self.leftBtn.layer.borderWidth = 1.0;
    self.leftBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.leftBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    self.locationService = [[BMKLocationService alloc]init];
    self.locationService.delegate = self;
    self.locationService.distanceFilter = kCLLocationAccuracyNearestTenMeters;//每10米更新一次
    [self.locationService startUserLocationService];
    
    self.rightBtn.layer.cornerRadius = 30.0;
    self.rightBtn.layer.borderWidth = 1.0;
    self.rightBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.rightBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    
//    self.mapView.userTrackingMode = BMKUserTrackingModeFollow;
//    self.mapView.showsUserLocation = YES;
    
    self.mapView.showsUserLocation = NO;//先关闭显示的定位图层
    self.mapView.userTrackingMode = BMKUserTrackingModeFollow;//设置定位的状态
    self.mapView.showsUserLocation = YES;//显示定位图层
    self.mapView.delegate = self;
    self.mapView.gesturesEnabled = YES;
    [self configPageInfo];
//    self.mapView.visibleMapRect = (BMKMapRect){{30,30},{SCREENWIDTH - 60,SCREENHEIGH - 60}};
    self.mapView.logoPosition = BMKLogoPositionRightBottom;
    
    self.userAnnotationModel = [MapUserAnnotationModel new];
    self.userAnnotationModel.coordinate = CLLocationCoordinate2DMake(30.2800590000, 120.1616930000);
    self.myAnnotationModel = [MapUserAnnotationModel new];
    
    [self.mapView addAnnotation:self.userAnnotationModel];
    [self.mapView addAnnotation:self.myAnnotationModel];
//    [self.mapView showAnnotations:self.mapView.annotations animated:YES];
    [self onGetMyLocation:nil];
    self.timer = [NSTimer timerWithTimeInterval:updateLocationInterval target:self selector:@selector(onTimer:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
//    [self onTimer:self.timer];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
   
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    if (![self.navigationController.viewControllers containsObject:self]) {//如果当前页面不在当前导航栏的控制器堆栈中,则视为页面退出
        self.locationService.delegate = nil;
        self.timer.fireDate = [NSDate distantFuture];
        [self.timer invalidate];
        self.timer = nil;
    }
}

//30.2800590000,120.1616930000 测试经纬度
- (void)configPageInfo {
    //查询行程详情
    [ApiUtils viewTripInfoWithTripId:self.tripId
                     completeHandler:^(TripDetailModel *detailModel) {
                         self.detailModel  = detailModel;
                         NSString *getHeaderImage = [NSString stringWithFormat:@"%@%@",[ApiUtils baseUrl],detailModel.getHeader];
                         [self.leftBtn sd_setImageWithURL:[NSURL URLWithString:getHeaderImage] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:DEFAULTERRORIMAGE]];
                         
                         NSString *setHeaderImage = [NSString stringWithFormat:@"%@%@",[ApiUtils baseUrl],detailModel.setHeader];
                         [self.rightBtn sd_setImageWithURL:[NSURL URLWithString:setHeaderImage] forState:UIControlStateNormal];
                         
                         self.tripId = detailModel.carOwnerId;
                         NSString * setUserId = detailModel.setUserId;
                         BOOL imTheSetter = [setUserId isEqualToString:[Tool uid]];//我是否是行程发布者
                         if (!imTheSetter) {//如果不是发布者
                             self.associateId = setUserId;
                         } else {
                             self.associateId = detailModel.getUserId;
                         }
    } errorHandler:^(NSString *responseErrorInfo) {
        [self showHint:@"查询行程内容时遇到错误"];
    }];
}

///添加大头针
- (void)addMapViewAnnotationsWithMyImageName:(NSString *)myImageName otherPeopleImageName:(NSString *)otherPeopleImageName {
//    BMKPointAnnotation
    MapUserAnnotationModel *userModel = [[MapUserAnnotationModel alloc]init];
    userModel.userImage = myImageName;
}

#pragma mark :- BMKMapViewDelegate
- (void)mapViewDidFinishLoading:(BMKMapView *)mapView {
    NSLog(@"mapview : %@ didfinish loading ",mapView);
    
}

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
//    [self.locationService stopUserLocationService];
//    [self.mapView updateLocationData:userLocation];
    self.myAnnotationModel.coordinate = userLocation.location.coordinate;
//    [self.mapView showAnnotations:self.mapView.annotations animated:YES];
    [self onGetMyLocation:nil];
    
//    BMKCoordinateRegion region = {userLocation.location.coordinate,{30,30}};
//    [self.mapView setRegion:region animated:YES];
//    self.mapView.zoomLevel = 20.0;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.mapView.delegate = self;
    [self.mapView viewWillAppear];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.rdv_tabBarController setTabBarHidden:NO animated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.mapView viewWillDisappear];
}
#pragma mark :- MapViewDataSource
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation {
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        BMKPinAnnotationView *pinView = (BMKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"BMKPinAnnotationView"];
        if (!pinView) {
            pinView = [[BMKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"BMKPinAnnotationView"];
        }
        pinView.pinColor = BMKPinAnnotationColorPurple;
        pinView.animatesDrop = YES;
        return pinView;
    } else if ([annotation isKindOfClass:[MapUserAnnotationModel class]]){//自定义位置
        MapUserAnnotationView *userAnnotationView = (MapUserAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"MapUserAnnotationView"];
        if (!userAnnotationView) {
            userAnnotationView = [[MapUserAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"MapUserAnnotationView"];
        }
        
        return userAnnotationView;
    }
    return nil;
}



#pragma mark :- MapViewDelegate


- (IBAction)onExit:(UIButton *)sender {
    BOOL isDriver = [[Tool judge] isEqualToString:@"0"];
    if (!isDriver) {
        [self showHint:@"行程只由司机结束"];
        return;
    }
    [ApiUtils endTripWithTripId:self.tripId isEnd:@"1" onComplete:^{
        EvaluationViewController *evaluationController = [[EvaluationViewController alloc]initWithNibName:@"EvaluationViewController" bundle:[NSBundle mainBundle]];
        evaluationController.tripId = self.tripId;
        evaluationController.evaluateUserId = self.associateId;
        [self.navigationController pushViewController:evaluationController animated:YES];
    } onError:^(NSString *responseErrorInfo) {
        [self showHint:responseErrorInfo];
    }];
}


- (IBAction)onBack:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
///发布心情
- (IBAction)onPostMood:(UIButton *)sender {
    ReleaseMoodViewController *moodController = [[ReleaseMoodViewController alloc]initWithNibName:@"ReleaseMoodViewController" bundle:[NSBundle mainBundle]];
    moodController.tripId = self.tripId;
    moodController.tripModel = self.detailModel;
    [self.navigationController pushViewController:moodController animated:YES];
}
- (IBAction)onGetMyLocation:(UIButton *)sender {//显示所有大头针
    [self.mapView showAnnotations:self.mapView.annotations animated:YES];
}


- (void)onTimer:(NSTimer *)timer {
    //提交我当前的位置信息,并获取对方位置
//
    CLLocationCoordinate2D coord = self.locationService.userLocation.location.coordinate;
    [ApiUtils updateUserPositionWithLongitude:coord.longitude latitude:coord.latitude onUpdateComplete:^{
        NSLog(@"submit current location complete");
    } errorHandler:^(NSString *responseErrorInfo) {
        NSLog(@"submit current location failed with error info %@",responseErrorInfo);
    }];
    
    [ApiUtils queryUserInfoBy:self.associateId
            onCompleteHandler:^(UserFollowListModel *userModel) {
                CGFloat longitude = [userModel.userPositionX doubleValue];
                CGFloat latitude = [userModel.userPositionY doubleValue];
                CLLocationCoordinate2D annotherUserLocation = CLLocationCoordinate2DMake(latitude, longitude);
                self.userAnnotationModel.coordinate = annotherUserLocation;
                
//                [self.mapView begin]
    } errorHandler:^(NSString *responseErrorInfo) {
        NSLog(@"query annother user location failed with error info %@",responseErrorInfo);
    }];
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
