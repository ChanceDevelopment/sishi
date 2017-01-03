//
//  OwnerCertificationController.m
//  sishi
//
//  Created by likeSo on 2016/12/27.
//  Copyright © 2016年 Channce. All rights reserved.
//

#import "OwnerCertificationController.h"
#import "Masonry.h"
#import "ApiUtils.h"
#import "UIViewController+UIImagePickerController.h"

@interface OwnerCertificationController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UIView *inputFieldContainer;
@property (weak, nonatomic) IBOutlet UITextField *nameInputField;
@property (weak, nonatomic) IBOutlet UITextField *phoneInputField;
@property (weak, nonatomic) IBOutlet UITextField *carTypeInputField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *nextStepBtn;

/**
 *  图片对象数组
 */
@property(nonatomic,strong)NSMutableArray *imageArray;
@property (weak, nonatomic) IBOutlet UIView *containerView;


/**
 *  图片高度数组
 */
@property(nonatomic,strong)NSMutableArray *imageHeightArray;

/**
 *  位于tableView底部的"添加"按钮
 */
@property(nonatomic,strong)UIView *tableFooterView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeightConstraint;

@end

@implementation OwnerCertificationController

- (void)dealloc
{
    [self.tableView removeObserver:self forKeyPath:@"contentSize"];
}

- (NSMutableArray *)imageArray {
    if (!_imageArray) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

- (UIView *)tableFooterView {
    if (!_tableFooterView) {
        _tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH - 30, 160)];
        _tableFooterView.clipsToBounds = YES;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = _tableFooterView.bounds;
        [btn setBackgroundImage:[UIImage imageNamed:@"icon_add_pics.png"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(onAddImage:) forControlEvents:UIControlEventTouchUpInside];
        [_tableFooterView addSubview:btn];
    }
    
    return _tableFooterView;
}

- (NSMutableArray *)imageHeightArray {
    if (!_imageHeightArray) {
        _imageHeightArray = [NSMutableArray array];
    }
    return _imageHeightArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)setupView {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView addObserver:self
                     forKeyPath:@"contentSize"
                        options:NSKeyValueObservingOptionNew
                        context:nil];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    self.tableView.tableFooterView = self.tableFooterView;
    self.tableView.scrollEnabled = NO;
    self.nextStepBtn.layer.cornerRadius = 5;
    self.nextStepBtn.clipsToBounds = YES;
    self.tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
    self.title = @"车主认证";
    self.inputFieldContainer.layer.cornerRadius = 7;
    self.inputFieldContainer.clipsToBounds = YES;
    self.inputFieldContainer.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.inputFieldContainer.layer.borderWidth = 1.0;
    
}

- (void)addImage:(UIImage *)image {
    CGSize imageSize = [image size];
    CGFloat scale = (SCREENWIDTH - 30) / imageSize.width ;
    CGFloat imageHeight = imageSize.height * scale;
    [self.imageArray addObject:image];
    [self.imageHeightArray addObject:[NSNumber numberWithFloat:imageHeight]];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)removeImageAtIndex:(NSUInteger)index {
    [self.imageArray removeObjectAtIndex:index];
    [self.imageHeightArray removeObjectAtIndex:index];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    CGFloat contentSizeHeight = self.tableView.contentSize.height;
    self.tableViewHeightConstraint.constant = contentSizeHeight;
    [self.containerView layoutIfNeeded];
}

#pragma mark :- UITableView Delegate & DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.imageArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat imageHeight = [self.imageHeightArray[indexPath.row] doubleValue];
    return imageHeight + 10;;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSUInteger imageViewTag = 10000086;
    UIImageView *imageContainer = [cell.contentView viewWithTag:imageViewTag];
    if (!imageContainer) {
        imageContainer = [[UIImageView alloc]initWithFrame:CGRectZero];
        imageContainer.backgroundColor = [UIColor whiteColor];
        imageContainer.clipsToBounds = YES;
        imageContainer.contentMode = UIViewContentModeScaleAspectFit;
        imageContainer.tag = imageViewTag;
        [cell.contentView addSubview:imageContainer];
        [imageContainer mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView).insets(UIEdgeInsetsMake(5, 0, 5, 0));
        }];
    }
    imageContainer.image = self.imageArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([Tool isSystemAvailableOnVersion:11]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确定要删除选中的照片吗 ?" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        kWeakSelf;
        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            //删除图片
            [weakSelf removeImageAtIndex:indexPath.row];
            [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
        }];
        
        [alertController addAction:confirmAction];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    } else {
        UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"确定要删除选中的照片吗 ?" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"确定", nil];
        actionSheet.tag = 10000 + indexPath.row;
        [actionSheet showInView:self.view];
    }
}

#pragma mark :- UIActionSheetDelegate 
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (actionSheet.tag < 10000) {//选择照片
        
        if (buttonIndex == 0) {//拍摄
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.delegate = self;
            picker.allowsEditing = YES;
            [self presentViewController:picker animated:YES completion:nil];
        } else if(buttonIndex == 1) {//选择
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            picker.delegate = self;
            picker.allowsEditing = YES;
            [self presentViewController:picker animated:YES completion:nil];
        }
        
        return;
    }
    NSUInteger imageIndex = actionSheet.tag - 10000;
    if (buttonIndex == 0) {
        [self removeImageAtIndex:imageIndex];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

#pragma mark :- 添加图片按钮
- (void)onAddImage:(UIButton *)btn {
    if (self.imageArray.count >= 2) {
        [self showHint:@"您最多只能上传两张照片哦"];
        return;
    }
    if ([Tool isSystemAvailableOnVersion:11]) {
        kWeakSelf;
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请选择照片打开方式" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"现在拍摄"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * _Nonnull action) {
                                                                 UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                                                                 picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                                                                 picker.delegate = self;
                                                                 picker.allowsEditing = YES;
                                                                 [weakSelf presentViewController:picker animated:YES completion:nil];
                                                             }];
        UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"选择照片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            picker.delegate = self;
            picker.allowsEditing = YES;
            [weakSelf presentViewController:picker animated:YES completion:nil];
        }];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        
        [alertController addAction:cameraAction];
        [alertController addAction:albumAction];
        [self presentViewController:alertController animated:YES completion:nil];
    } else {
        UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:@"请选择照片打开方式" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"现在拍摄",@"选择照片", nil];
        [actionSheet showInView:self.view];
    }
    
//    [self pickImage:@"owner"];
}

- (void)finishPickWithImage:(UIImage *)image identifier:(NSString *)identifier {
    if ([identifier isEqualToString:identifier]) {
        [self addImage:image];
    }
}

#pragma mark :- UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *editedImage = (UIImage *)info[UIImagePickerControllerEditedImage];
    [self addImage:editedImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onNext:(UIButton *)sender {
    if (!self.nameInputField.text.length) {
        [self showHint:@"请输入您的真实姓名"];
        return;
    } else if (![Tool isMobileNumber:self.phoneInputField.text]) {
        [self showHint:@"请输入您当前的手机号"];
        return;
    } else if (self.imageArray.count != 2) {
        [self showHint:@"请添加足够的照片"];
        return;
    }
    NSMutableArray *imageNameArray = [NSMutableArray arrayWithCapacity:self.imageArray.count];
    for (UIImage *image in self.imageArray) {
        [imageNameArray addObject:[Tool Base64StringFromUIImage:image]];
    }
    [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
//    [ApiUtils userProveWithTrueName:self.nameInputField.text idCard:self.idCardInputField.text privatePhoto:[imageNameArray componentsJoinedByString:@","] onCompleteHandler:^{
//        [MBProgressHUD hideHUDForView:self.view.window animated:YES];
//        [self showHint:@"认证提交成功"];
//        [self.navigationController popViewControllerAnimated:YES];
//    } errorHandler:^(NSString *responseErrorInfo) {
//        [MBProgressHUD hideHUDForView:self.view.window animated:YES];
//        [self showHint:responseErrorInfo];
//    }];
    NSString *imageNames = [imageNameArray componentsJoinedByString:@","];
    [ApiUtils userCarProveWithUserTrueName:self.nameInputField.text
                                     phone:self.phoneInputField.text
                                  carPhoto:imageNames
                                   carType:self.carTypeInputField.text
                                onComplete:^{
                                    [MBProgressHUD hideHUDForView:self.view.window animated:YES];
                                    [self showHint:@"认证资料提交成功"];
                                    [self.navigationController popViewControllerAnimated:YES];
    } onResponseError:^(NSString *responseErrorInfo) {
        [self showHint:responseErrorInfo];
        [MBProgressHUD hideHUDForView:self.view.window animated:YES];
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
