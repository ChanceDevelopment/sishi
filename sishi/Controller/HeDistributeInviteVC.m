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

#define TextLineHeight 1.2f

@interface HeDistributeInviteVC ()<ImageAdderAddImageProtocol,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UITextField *destinationInputField;
@property (weak, nonatomic) IBOutlet UITextField *getInCarInputField;
@property (weak, nonatomic) IBOutlet UIButton *startTimeLabel;
@property (weak, nonatomic) IBOutlet LabelSelectView *labelSelectView;
@property (weak, nonatomic) IBOutlet UITextField *noteInputField;
@property (weak, nonatomic) IBOutlet ImageAdder *imageAdder;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelSelectViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageAdderHeightConstraint;

@end

@implementation HeDistributeInviteVC
- (void)viewDidLoad {
    [self setupView];
}

- (void)setupView {
    self.imageAdder.imageAdderDelegate = self;
    self.labelSelectView.labelFont = [UIFont systemFontOfSize:15];
    self.labelSelectView.labelList = @[@"标签1",@"标签2",@"标签3",@"标签4",@"标签5",@"标签6",@"标签6 + 1"];
    CGFloat labelViewHeight = [self.labelSelectView labelViewHeightForLabels:self.labelSelectView.labelList targetRectWidth:SCREENWIDTH - 20];
    self.labelSelectViewHeightConstraint.constant = labelViewHeight;
    kWeakSelf;
    self.imageAdder.onChangeHeight = ^(CGFloat viewHeight) {
        weakSelf.imageAdderHeightConstraint.constant = viewHeight;
        [weakSelf.containerView layoutIfNeeded];
    };
    
}

#pragma mark :- ImageAdder Delegate
- (void)imageAdder:(ImageAdder *)imageAdder addImageWithImageList:(NSArray<UIImage *> *)imageList {
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
}

#pragma mark :- UIImagePickerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = (UIImage *)info[UIImagePickerControllerOriginalImage];
    [self.imageAdder appendImage:image];
    
}
@end
