//
//  ReleaseMoodViewController.m
//  sishi
//
//  Created by likeSo on 2016/12/26.
//  Copyright © 2016年 Channce. All rights reserved.
//

#import "ReleaseMoodViewController.h"
#import "ImageAdder.h"
#import "ApiUtils.h"
#import "UIViewController+UIImagePickerController.h"
#import "UIButton+EMWebCache.h"

@interface ReleaseMoodViewController ()<UITextViewDelegate,ImageAdderAddImageProtocol>
@property (weak, nonatomic) IBOutlet ImageAdder *imageAdder;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *adderHeightConstraint;
@property (weak, nonatomic) IBOutlet UILabel *placeHolderLabel;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIView *nameContainerView;

/**
 *  是否分享行程
 */
@property(nonatomic,assign)BOOL willShareTripInfo;
@property (weak, nonatomic) IBOutlet UILabel *datelabel;
//@property (weak, nonatomic) IBOutlet UIButton *userBtn;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *shareViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

/**
 *  是否关联行程
 */
@property(nonatomic,assign)BOOL inTrip;

@end

@implementation ReleaseMoodViewController


- (void)setWillShareTripInfo:(BOOL)willShareTripInfo {
    _willShareTripInfo = willShareTripInfo;
    CGFloat heightConstant = willShareTripInfo ? 150 : 50;
    self.shareViewHeightConstraint.constant = heightConstant;
    [UIView animateWithDuration:0.2 animations:^{
        [self.nameContainerView layoutIfNeeded];
    }];
}

- (void)setTripModel:(TripDetailModel *)tripModel {
    _tripModel = tripModel;
    if (tripModel) {
        self.inTrip = tripModel;
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"发表您的心情";
    self.textView.delegate = self;
    self.imageAdder.imageLimitCanAdd = 9;
    self.imageAdder.imageAdderDelegate = self;
//    kWeakSelf;
//    [[NSNotificationCenter defaultCenter]addObserverForName:UITextViewTextDidChangeNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) { 
//        weakSelf.placeHolderLabel.hidden = weakSelf.textView.text.length;
//    }];
    
    
    self.nameContainerView.layer.borderColor = [UIColor colorWithWhite:0.8 alpha:1].CGColor;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onTextViewTextChange:) name:UITextViewTextDidChangeNotification object:nil];
    kWeakSelf;
    self.imageAdder.onChangeHeight = ^(CGFloat height) {
        weakSelf.adderHeightConstraint.constant = height;
        [weakSelf.containerView layoutIfNeeded];
    };
    
    if (self.inTrip) {//可以分享行程信息
        self.willShareTripInfo = YES;
    } else {
        self.shareViewHeightConstraint.constant = 0.0;
    }
    if (self.tripModel) {
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:self.tripModel.carUserGotime / 1000];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        dateFormatter.dateFormat = @"MM月dd号";//获取几月几号
        NSString *month = [dateFormatter stringFromDate:date];
        NSDateFormatter *hourFormatter = [[NSDateFormatter alloc]init];
        hourFormatter.dateFormat = @"HH:mm";//获取小时
        NSString *hour = [hourFormatter stringFromDate:date];
        NSString *weekDay = [Tool weekdayStringFromDate:date];
        NSString *labelString = [NSString stringWithFormat:@"%@ %@ %@",month,weekDay,hour];
        self.datelabel.text = labelString;
        BOOL isSetter = [self.tripModel.setUserId isEqualToString:[Tool uid]];
        NSString *uNick = self.tripModel.setUserNick;
        NSString *uImage = self.tripModel.setHeader;
        if (isSetter) {
            uNick = self.tripModel.getUserNick;
            uImage = self.tripModel.getHeader;
        }
//        [self.userBtn setTitle:uNick forState:UIControlStateNormal];
        self.nameLabel.text = uNick;
        NSString *imageLink = [NSString stringWithFormat:@"%@%@",[ApiUtils baseUrl],uImage];
//        [self.userBtn sd_setImageWithURL:[NSURL URLWithString:imageLink] forState:UIControlStateNormal];
        [self.userImageView sd_setImageWithURL:[NSURL URLWithString:imageLink] placeholderImage:[UIImage imageNamed:@"ic_sexton.png"]];
        self.addressLabel.text = [NSString stringWithFormat:@"地点 : %@",self.tripModel.carOwnerStopplace];
    }
}



- (IBAction)onShareTrip:(UIButton *)sender {// 分享行程 按钮
    if (!self.willShareTripInfo) {
            self.willShareTripInfo = YES;
    }
}
- (IBAction)onDoNotShare:(UIButton *)sender {//设置暂不分享
    if (self.willShareTripInfo) {
            self.willShareTripInfo = NO;
    }
}

- (void)onTextViewTextChange:(NSNotification *)note {
    self.placeHolderLabel.hidden = self.textView.text.length;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.rdv_tabBarController setTabBarHidden:NO animated:YES];
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    self.placeHolderLabel.hidden = textView.text.length;
    return YES;
}

- (IBAction)onRelease:(UIButton *)sender {
    if (!self.textView.text.length) {
        [self showHint:@"请填写您的心情"];
        return;
    } else if (!self.imageAdder.imageList.count) {
        [self showHint:@"请至少添加一张您的照片"];
        return;
    }
    [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
    NSMutableArray *imageNameList = [NSMutableArray arrayWithCapacity:self.imageAdder.imageList.count];
    for (UIImage *image in self.imageAdder.imageList) {
        NSString *base64 = [Tool Base64StringFromUIImage:image];
        [imageNameList addObject:base64];
    }
    NSString *imageNames = [imageNameList componentsJoinedByString:@","];
    CGFloat longitude = [[NSUserDefaults standardUserDefaults]doubleForKey:kDefaultsUserLocationlongitude];
    CGFloat latitude = [[NSUserDefaults standardUserDefaults]doubleForKey:kDefaultsUserLocationLatitude];
    NSString *tripId = self.tripId ? self.tripId : @"";
    [ApiUtils publishNewDynamicWithContent:self.textView.text position_x:longitude position_y:latitude tripid:tripId wallurl:imageNames onCompleteHandler:^{
        [MBProgressHUD hideHUDForView:self.view.window animated:YES];
        [self showHint:@"发布成功"];
        [self.navigationController popViewControllerAnimated:YES];
    } errorHandler:^(NSString *responseErrorInfo) {
        [MBProgressHUD hideHUDForView:self.view.window animated:YES];
        [self showHint:responseErrorInfo];
    }];
}


#pragma mark :- 图片选择器

- (void)imageAdder:(ImageAdder *)imageAdder addImageWithImageList:(NSArray<UIImage *> *)imageList {
    [self pickImage:@"moodPageImageAdder"];
}

- (void)finishPickWithImage:(UIImage *)image identifier:(NSString *)identifier {
    [self.imageAdder appendImage:image];
    
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
