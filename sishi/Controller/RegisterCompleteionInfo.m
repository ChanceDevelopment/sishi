//
//  RegisterCompleteionInfo.m
//  sishi
//
//  Created by likeSo on 2016/12/19.
//  Copyright © 2016年 Channce. All rights reserved.
//

#import "RegisterCompleteionInfo.h"
#import "Tool.h"
#import "ApiUtils.h"
#import "UIViewController+HUD.h"

@interface RegisterCompleteionInfo ()
@property (weak, nonatomic) IBOutlet UIView *inputFieldContainerView;
@property (weak, nonatomic) IBOutlet UITextField *passwordInputField;
@property (weak, nonatomic) IBOutlet UITextField *nickNameInputField;

@end

@implementation RegisterCompleteionInfo

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"手机注册";
    
    self.inputFieldContainerView.layer.cornerRadius = 7;
    self.inputFieldContainerView.clipsToBounds = YES;
    self.inputFieldContainerView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.inputFieldContainerView.layer.borderWidth = 1.0;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (IBAction)onFinishRegister:(UIButton *)sender {
    NSString *response = [Tool checkRegisterPassword:self.passwordInputField.text];
    if (response) {
        [self showHint:response];
        return;
    }
    if (!self.nickNameInputField.text.length) {
        [self showHint:@"请输入您的昵称"];
        return;
    }
    kWeakSelf;
//    [ApiUtils userRegisterWithNickName:self.nickNameInputField.text
//                                 uName:self.phoneNumber
//                                   psw:self.passwordInputField.text
//                            onResponse:^{
////                                [self showHint:@"注册成功"];
//    } onRequestError:^(NSString *responseErrorInfo) {
//        [weakSelf showHint:responseErrorInfo];
//    }];
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    [[EMClient sharedClient] asyncRegisterWithUsername:self.phoneNumber
//                                             password:self.passwordInputField.text
//                                              success:^{
                                                      [ApiUtils userRegisterWithNickName:self.nickNameInputField.text
                                                                                   uName:self.phoneNumber
                                                                                     psw:self.passwordInputField.text
                                                                              onResponse:^{
                                                                                  [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];//注册成功
                                                      } onRequestError:^(NSString *responseErrorInfo) {//注册失败
                                                          [weakSelf showHint:responseErrorInfo];
                                                          [MBProgressHUD hideHUDForView:self.view animated:YES];
                                                      }];
//    } failure:^(EMError *aError) {
//        NSLog(@"%@",aError.description);
//        NSLog(@"error code %u ",aError.code);
//        [weakSelf showHint:aError.errorDescription];
//        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
//    }];
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
