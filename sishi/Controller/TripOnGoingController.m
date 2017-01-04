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

@interface TripOnGoingController ()<BMKMapViewDelegate,BMKLocationServiceDelegate>
@property (weak, nonatomic) IBOutlet BMKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;

/**
 *  百度定位服务
 */
@property(nonatomic,strong)BMKLocationService *locationService;


/**
 *  行程详情Model
 */
@property(nonatomic,strong)TripDetailModel *detailModel;


@end

@implementation TripOnGoingController

- (void)dealloc {
    self.locationService.delegate = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.leftBtn.layer.cornerRadius = 30.0;
    self.leftBtn.layer.borderWidth = 1.0;
    self.leftBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    self.leftBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    self.locationService = [[BMKLocationService alloc]init];
    self.locationService.delegate = self;
    self.locationService.distanceFilter = kCLLocationAccuracyBest;
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
    
    self.mapView.gesturesEnabled = YES;
    [self configPageInfo];
}

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

#pragma mark :- BMKMapViewDelegate
- (void)mapViewDidFinishLoading:(BMKMapView *)mapView {
    NSLog(@"mapview : %@ didfinish loading ",mapView);
    
}

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    [self.locationService stopUserLocationService];
    [self.mapView updateLocationData:userLocation];
    
    BMKCoordinateRegion region = {userLocation.location.coordinate,{30,30}};
    [self.mapView setRegion:region animated:YES];
    self.mapView.zoomLevel = 20.0;
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

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.mapView.delegate = nil;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
