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

@interface ReleaseMoodViewController ()<UITextViewDelegate,ImageAdderAddImageProtocol>
@property (weak, nonatomic) IBOutlet ImageAdder *imageAdder;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *adderHeightConstraint;
@property (weak, nonatomic) IBOutlet UILabel *placeHolderLabel;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@end

@implementation ReleaseMoodViewController


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
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onTextViewTextChange:) name:UITextViewTextDidChangeNotification object:nil];
    kWeakSelf;
    self.imageAdder.onChangeHeight = ^(CGFloat height) {
        weakSelf.adderHeightConstraint.constant = height;
        [weakSelf.containerView layoutIfNeeded];
    };
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [ApiUtils publishNewDynamicWithContent:self.textView.text position_x:longitude position_y:latitude tripid:@"" wallurl:imageNames onCompleteHandler:^{
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
