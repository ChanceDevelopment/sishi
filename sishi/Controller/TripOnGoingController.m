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

@interface TripOnGoingController ()<BMKMapViewDelegate>
@property (weak, nonatomic) IBOutlet BMKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;

@end

@implementation TripOnGoingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.leftBtn.layer.cornerRadius = 30.0;
    self.leftBtn.layer.borderWidth = 1.0;
    self.leftBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    
    self.rightBtn.layer.cornerRadius = 30.0;
    self.rightBtn.layer.borderWidth = 1.0;
    self.rightBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    
    
    self.mapView.showsUserLocation = YES;
    self.mapView.gesturesEnabled = YES;
    [self configPageInfo];
}

- (void)configPageInfo {
    //查询行程详情
    [ApiUtils viewTripInfoWithTripId:self.tripId
                     completeHandler:^(TripDetailModel *detailModel) {
//                         NSLog(@"query trip detail info with response info %@",detailModel);
                         NSString *getHeaderImage = [NSString stringWithFormat:@"%@%@",[ApiUtils baseUrl],detailModel.getHeader];
                         [self.leftBtn sd_setImageWithURL:[NSURL URLWithString:getHeaderImage] forState:UIControlStateNormal];
                         
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
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
