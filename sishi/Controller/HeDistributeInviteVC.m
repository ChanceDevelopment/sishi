//
//  HeContestDetailVC.m
//  beautyContest
//
//  Created by HeDongMing on 16/7/31.
//  Copyright © 2016年 iMac. All rights reserved.
//

#import "HeDistributeInviteVC.h"
#import "MLLabel+Size.h"
#import "HeBaseTableViewCell.h"
#import "MLLinkLabel.h"
#import "LabelSelectView.h"
#import "ImageAdder.h"
#import "SelectViewContainer.h"
#import "ApiUtils.h"
#import "NearbyTravelUserListController.h"
#import <BaiduMapAPI_Location/BMKLocationService.h>
#import <BaiduMapAPI_Search/BMKGeocodeSearch.h>

#define TextLineHeight 1.2f

@interface HeDistributeInviteVC ()<ImageAdderAddImageProtocol,UINavigationControllerDelegate,UIImagePickerControllerDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UITextField *destinationInputField;
@property (weak, nonatomic) IBOutlet UITextField *getInCarInputField;
@property (weak, nonatomic) IBOutlet UIButton *startTimeLabel;
@property (weak, nonatomic) IBOutlet LabelSelectView *labelSelectView;
@property (weak, nonatomic) IBOutlet UITextField *noteInputField;
@property (weak, nonatomic) IBOutlet ImageAdder *imageAdder;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelSelectViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageAdderHeightConstraint;

/**
 *  定位管理器
 */
@property(nonatomic,strong)BMKLocationService *locationManager;

/**
 *  逆地理编码管理器
 */
@property(nonatomic,strong)BMKGeoCodeSearch *regeoCodeManager;



/**
 *  兴趣爱好数组
 */
@property(nonatomic,strong)NSArray <HobbyListModel *>*hobbyList;

/**
 *  时间选择器
 */
@property(nonatomic,strong)UIDatePicker *datePicker;

@end

@implementation HeDistributeInviteVC
- (BMKLocationService *)locationManager {
    if (!_locationManager) {
        _locationManager = [[BMKLocationService alloc]init];
        _locationManager.delegate = self;
    }
    return _locationManager;
}

- (BMKGeoCodeSearch *)regeoCodeManager {
    if (!_regeoCodeManager) {
        _regeoCodeManager = [[BMKGeoCodeSearch alloc]init];
        _regeoCodeManager.delegate = self;
    }
    return _regeoCodeManager;
}

- (UIDatePicker *)datePicker {
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc]initWithFrame:CGRectZero];
        
        _datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    }
    return _datePicker;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"发布新行程";
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
//     self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:nil action:nil];
    [self setupView];
}

- (void)setupView {
    self.imageAdder.imageAdderDelegate = self;
    self.labelSelectView.labelFont = [UIFont systemFontOfSize:15];
//    self.labelSelectView.labelList = @[@"标签1",@"标签2",@"标签3",@"标签4",@"标签5",@"标签6",@"标签6 + 1"];
    [self queryLabels];
    
    kWeakSelf;
    self.imageAdder.onChangeHeight = ^(CGFloat viewHeight) {
        weakSelf.imageAdderHeightConstraint.constant = viewHeight;
        [weakSelf.containerView layoutIfNeeded];
    };
}


- (void)queryLabels {
    [ApiUtils queryAllHobbyListWithCompleteHandler:^(NSArray<HobbyListModel *> *hobbyList) {
        self.hobbyList = hobbyList;
        NSMutableArray <NSString *>* hobbyStringList = [NSMutableArray arrayWithCapacity:hobbyList.count];
        for (HobbyListModel *hobbyModel in hobbyList) {
            [hobbyStringList addObject:hobbyModel.loveContent];
        }
        self.labelSelectView.labelList = [NSArray arrayWithArray:hobbyStringList];
        CGFloat labelViewHeight = [self.labelSelectView labelViewHeightForLabels:self.labelSelectView.labelList targetRectWidth:SCREENWIDTH - 20];
        self.labelSelectViewHeightConstraint.constant = labelViewHeight;
    } errorHandler:^(NSString *responseErrorInfo) {
        [self showHint:[NSString stringWithFormat:@"%@标签获取失败",responseErrorInfo]];
    }];
}

#pragma mark :- ImageAdder Delegate
- (void)imageAdder:(ImageAdder *)imageAdder addImageWithImageList:(NSArray<UIImage *> *)imageList {
    if ([Tool isSystemAvailableOnVersion:8]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"选择图片打开方式" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍照上传" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
            imagePicker.delegate = self;
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self.navigationController presentViewController:imagePicker animated:YES completion:nil];
        }];
        [alertController addAction:cameraAction];
        
        UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"选择照片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
            imagePicker.delegate = self;
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            imagePicker.allowsEditing = YES;
            [self.navigationController presentViewController:imagePicker animated:YES completion:nil];
        }];
        [alertController addAction:albumAction];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    } else {//UIAlertView
//        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"选择照片打开方式" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拍照上传",@"选择照片", nil];
//        [alertView show];
        UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"选择照片打开方式" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照上传",@"选择照片", nil];
        [actionSheet showInView:self.view];
    }
}

#pragma mark :- UIAlertViewDelegate 
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.allowsEditing = YES;
        [self.navigationController presentViewController:imagePicker animated:YES completion:nil];
    } else if (buttonIndex == 1){
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
        imagePicker.delegate = self;
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.allowsEditing = YES;
        [self.navigationController presentViewController:imagePicker animated:YES completion:nil];
    }
}

#pragma mark :- UIImagePickerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = (UIImage *)info[UIImagePickerControllerOriginalImage];
    [self.imageAdder appendImage:image];
    
}
- (IBAction)onPickerTime:(UIButton *)sender {
    [self.view resignFirstResponder];
    SelectViewContainer *container = [SelectViewContainer defaultContainerView];
    kWeakSelf;
    container.onConfirm = ^(){
        NSDate *date = weakSelf.datePicker.date;
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        formatter.dateFormat = @"yyyy/MM/dd HH:mm";
        NSString *dateString = [formatter stringFromDate:date];
        [weakSelf.startTimeLabel setTitle:dateString forState:UIControlStateNormal];
    };
    self.datePicker.minimumDate = [[NSDate date] dateByAddingMinutes:5];//设置可选择的最小时间为5分钟后
    [container showWithContentView:self.datePicker withTitle:@"请选择出发时间"];
}
- (IBAction)onSubmit:(UIButton *)sender {
    if (!self.destinationInputField.text.length) {
        [self showHint:@"请先输入目的地"];
        return;
    }
//    else if (!self.getInCarInputField.text.length) {
//        [self showHint:@"请输入上车地点"];
//        return;
//    }
//    else if (!self.datePicker.date) {
//        [self showHint:@"请先选择出发时间"];
//        return;
//    }
//    else if (!self.labelSelectView.selectedLabelList.count ) {
//        [self showHint:@"请选择标签"];
//        return;
//    }
//    else if (!self.noteInputField.text.length) {
//        [self showHint:@"请先填写完整信息"];
//        return;
//    }
//    else if (!self.imageAdder.imageList.count) {
//        [self showHint:@"请先添加照片"];
//        return;
//    }
    //发布完成之后先查询是否存在附近的等待出行的
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    CGFloat longitude = [[NSUserDefaults standardUserDefaults]doubleForKey:kDefaultsUserLocationlongitude];
    CGFloat latitude = [[NSUserDefaults standardUserDefaults]doubleForKey:kDefaultsUserLocationLatitude];
    NSString *userGoTime = [NSString stringWithFormat:@"%.0f",self.datePicker.date.timeIntervalSince1970 * 1000];
    NSString *wishTarget = [self.labelSelectView.selectedLabelList componentsJoinedByString:@","];
    NSMutableArray *userImageNameList = [NSMutableArray arrayWithCapacity:self.imageAdder.imageList.count];
    for (UIImage *image in self.imageAdder.imageList) {
        NSString *base64 = [Tool Base64StringFromUIImage:image];
        [userImageNameList addObject:base64];
    }
    NSString *imageNameListString = [userImageNameList componentsJoinedByString:@","];
    NSDictionary *tripInfo = [ApiUtils tripInfoWithUserGoTime:userGoTime wishTarget:wishTarget  ownerImage:imageNameListString startPlace:self.getInCarInputField.text stopPlace:self.destinationInputField.text tripNote:self.noteInputField.text tripType:@"1" tripState:@"1" receiverId:@"" longitude:longitude latitude:latitude carOwnerState:@"1"];
    [ApiUtils publishNewTripWithTripInfo:tripInfo completeHandler:^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NearbyTravelUserListController *nearbyUserList = [[NearbyTravelUserListController alloc]initWithNibName:@"NearbyTravelUserListController" bundle:[NSBundle mainBundle]];
        nearbyUserList.hobbys = [self.labelSelectView.selectedLabelList componentsJoinedByString:@","];
        [self.navigationController pushViewController:nearbyUserList animated:YES];
    } errorHandler:^(NSString *responseErrorInfo) {
        [self showHint:responseErrorInfo];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}
- (IBAction)onLocate:(UIButton *)sender {//获取当前位置
    [self.locationManager startUserLocationService];
}


#pragma mark :- BaiduMap Location Manager Delegate 
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    [self.locationManager stopUserLocationService];
    //进行逆地理编码
    CLLocation *location = userLocation.location;
    BMKReverseGeoCodeOption *reverseOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseOption.reverseGeoPoint = location.coordinate;
    
    self.regeoCodeManager.delegate = self;
    [self.regeoCodeManager reverseGeoCode:reverseOption];
}

#pragma mark :- BMKReverseGeoCodeDelegate 
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error {
    self.getInCarInputField.text = result.address;
}

- (void)queryNearbyUserList {
   
}

@end
