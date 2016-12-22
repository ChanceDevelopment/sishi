//
//  UserCertificationController.m
//  sishi
//
//  Created by likeSo on 2016/12/21.
//  Copyright © 2016年 Channce. All rights reserved.
//

#import "UserCertificationController.h"
#import "Masonry.h"

static NSInteger kImageUpLoadMaxCount = 4;

@interface UserCertificationController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
/**
 *  图片数组
 */
@property(nonatomic,strong)NSMutableArray *imageArray;

/**
 *  图片高度数组
 */
@property(nonatomic,strong)NSMutableArray *imageHeightArray;


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIButton *nextStepBtn;
@property (weak, nonatomic) IBOutlet UIView *inputViewContainer;



/**
 *  位于tableView底部的"添加"按钮
 */
@property(nonatomic,strong)UIView *tableFooterView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeightConstraint;

@end

@implementation UserCertificationController

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
    
    self.inputViewContainer.layer.cornerRadius = 7;
    self.inputViewContainer.clipsToBounds = YES;
    self.inputViewContainer.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.inputViewContainer.layer.borderWidth = 1.0;
    
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
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"确定要删除选中的照片吗" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    kWeakSelf;
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
       //删除图片
        [weakSelf removeImageAtIndex:indexPath.row];
        [weakSelf.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    }];
    
    [alertController addAction:confirmAction];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark :- 添加图片按钮
- (void)onAddImage:(UIButton *)btn {
    if (self.imageArray.count >= kImageUpLoadMaxCount) {
        [self showHint:@"您最多只能上传四张照片哦"];
        return;
    }
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
    
}

#pragma mark :- UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *editedImage = (UIImage *)info[UIImagePickerControllerEditedImage];
    [self addImage:editedImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
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
