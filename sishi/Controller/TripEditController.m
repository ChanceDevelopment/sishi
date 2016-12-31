//
//  TripEditController.m
//  sishi
//
//  Created by likeSo on 2016/12/15.
//  Copyright © 2016年 Channce. All rights reserved.
//

#import "TripEditController.h"
#import "LabelSelectView.h"
#import "ApiUtils.h"
#import "SelectViewContainer.h"

@interface TripEditController ()
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UIButton *startDateBtn;
@property (weak, nonatomic) IBOutlet UITextField *destinationInputField;
@property (weak, nonatomic) IBOutlet UITextField *carTypeLabel;
@property (weak, nonatomic) IBOutlet LabelSelectView *labelSelectView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UITextField *noteInputField;

/**
 *  时间选择器
 */
@property(nonatomic,strong)UIDatePicker *datePicker;

/**
 *  出发时间时间戳
 */
@property(nonatomic,assign)NSTimeInterval dateInterval;


@end

@implementation TripEditController

- (UIDatePicker *)datePicker {
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc]initWithFrame:CGRectZero];
        _datePicker.datePickerMode = UIDatePickerModeDateAndTime;
        
    }
    return _datePicker;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    
}

- (void)setupView {
    self.navigationItem.title = @"编辑行程";
    
    [self.startDateBtn addTarget:self action:@selector(onChoseDate:) forControlEvents:UIControlEventTouchUpInside];
    self.dateInterval = self.detailModel.carUserGotime / 1000;
    [self.startDateBtn setTitle:self.detailModel.startDate forState:UIControlStateNormal];
    self.destinationInputField.text = self.detailModel.carOwnerStopplace;
    NSString *note  = self.detailModel.carOwnerNote;
        self.noteInputField.text = note;
    NSURL *imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[ApiUtils baseUrl],self.detailModel.carOwnerImg]];
    [self.coverImageView sd_setImageWithURL:imageUrl];
    [ApiUtils queryAllHobbyListWithCompleteHandler:^(NSArray<HobbyListModel *> *hobbyList) {
        self.labelSelectView.labelFont = [UIFont systemFontOfSize:15];
        NSArray <NSString *>*hobbyStringList = ({//获取所有标签列表
            NSMutableArray <NSString *>*labelNames = [NSMutableArray arrayWithCapacity:hobbyList.count];
            for (HobbyListModel *hobbyModel in hobbyList) {
                [labelNames addObject:hobbyModel.loveContent];
            }
            [NSArray arrayWithArray:labelNames];
        });
        self.labelSelectView.labelList = hobbyStringList;
        CGFloat viewHeight = [self.labelSelectView labelViewHeightForLabels:hobbyStringList targetRectWidth:SCREENWIDTH - 10];//更新标签View高度
        self.labelViewHeightConstraint.constant = viewHeight;
    } errorHandler:^(NSString *responseErrorInfo) {
        [self showHint:@"查询兴趣标签失败"];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.rdv_tabBarController setTabBarHidden:NO animated:YES];
}


#pragma mark :- 时间选择
- (void)onChoseDate:(UIButton *)btn {
    self.datePicker.minimumDate = [[NSDate date] dateByAddingMinutes:5];//设置可选择的最小时间为五分钟后,避免提交时出现出发时间小于当前时间的问题
    SelectViewContainer *container = [SelectViewContainer defaultContainerView];
    kWeakSelf;
    container.onConfirm = ^ {
        NSDate *selectDate = weakSelf.datePicker.date;
        weakSelf.dateInterval = [selectDate timeIntervalSince1970];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        dateFormatter.dateFormat = @"yyyy/MM/dd HH:mm";
        [weakSelf.startDateBtn setTitle:[dateFormatter stringFromDate:selectDate] forState:UIControlStateNormal];
    };
    [container showWithContentView:self.datePicker withTitle:@"重新选择出发时间"];
}


/**
 点击 "完成"按钮
 */
- (IBAction)onComplete:(UIButton *)sender {
    NSString *tripId = self.detailModel.carOwnerId;
    NSString *labels = [self.labelSelectView.selectedLabelList componentsJoinedByString:@","];
    [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
    [ApiUtils updateTripInfoWithTripId:tripId
                            userGoTime:[NSString stringWithFormat:@"%.0f",self.dateInterval * 1000]
                            startPlace:self.detailModel.carOwnerStartplace
                           carUserLike:labels
                             ownernote:self.noteInputField.text
                       completeHandler:^{
                           [MBProgressHUD hideHUDForView:self.view.window animated:YES];
                           [self showHint:@"行程编辑成功"];
                           if (self.onUpdateTripInfo) {
                               self.onUpdateTripInfo();
                           }
                           [self.navigationController popViewControllerAnimated:YES];
    } errorHandler:^(NSString *responseErrorInfo) {
        [MBProgressHUD hideHUDForView:self.view.window animated:YES];
        [self showHint:responseErrorInfo];
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
