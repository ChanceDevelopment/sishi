//
//  HeRealTimeDetailController.m
//  sishi
//
//  Created by likeSo on 2016/12/15.
//  Copyright © 2016年 Channce. All rights reserved.
//

#import "HeRealTimeDetailController.h"
#import "TripEditController.h"
#import "ApiUtils.h"
#import "SDCycleScrollView.h"

@interface HeRealTimeDetailController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *destinationLabel;
@property (weak, nonatomic) IBOutlet UILabel *carTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *wantTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *noteLabel;
@property (weak, nonatomic) IBOutlet SDCycleScrollView *imageBanner;
/**
 *  行程详情Model
 */
@property(nonatomic,strong)TripDetailModel *detailModel;

@end

@implementation HeRealTimeDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupView];
}

- (void)setupView {
    self.navigationItem.title = @"";
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.imageBanner.autoScroll = NO;
    self.imageBanner.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    [self queryTripInfo];
}

- (void)queryTripInfo {
    UIWindow *mainWindow = [UIApplication sharedApplication].keyWindow;
    [MBProgressHUD showHUDAddedTo:mainWindow animated:YES];
    [ApiUtils viewTripInfoWithTripId:self.tripId
                     completeHandler:^(TripDetailModel *detailModel) {
                         self.detailModel = detailModel;
                         [MBProgressHUD hideHUDForView:mainWindow animated:YES];
                         NSString *startDate = detailModel.startDate;
                         self.startTimeLabel.text = [NSString stringWithFormat:@"出发时间 : %@",startDate];
                         
                         self.destinationLabel.text = [NSString stringWithFormat:@"目的地 : %@",detailModel.carOwnerStopplace];
                         
                         self.wantTypeLabel.text = [NSString stringWithFormat:@"邀约对象 : %@",detailModel.carUserLike];
                         
                         self.noteLabel.text = [NSString stringWithFormat:@"备注 : %@",detailModel.carOwnerNote];
                         NSString *imageName = [[detailModel.carOwnerImg componentsSeparatedByString:@","] firstObject];
                         self.imageBanner.imageURLStringsGroup = @[[NSString stringWithFormat:@"%@%@",[ApiUtils baseUrl],imageName]];
    } errorHandler:^(NSString *responseErrorInfo) {
        [MBProgressHUD hideHUDForView:mainWindow animated:YES];
        [self showHint:responseErrorInfo];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onEdit:(UIButton *)sender {
    TripEditController *tripController = [[TripEditController alloc]initWithNibName:@"TripEditController" bundle:[NSBundle mainBundle]];
    kWeakSelf;
    tripController.onUpdateTripInfo = ^ {//行程编辑页面更新了页面信息,本页面刷新结果
        [weakSelf queryTripInfo];
    };
    tripController.hidesBottomBarWhenPushed = YES;
    tripController.detailModel = self.detailModel;
    [self.navigationController pushViewController:tripController animated:YES];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.rdv_tabBarController setTabBarHidden:NO animated:YES];
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
