//
//  RegisterController.m
//  sishi
//
//  Created by likeSo on 2016/12/19.
//  Copyright © 2016年 Channce. All rights reserved.
//

#import "RegisterController.h"
#import "RegisterCompleteionInfo.h"
#import "Tool.h"
#import <SMS_SDK/SMSSDK.h>
#import "Tool.h"

@interface RegisterController ()
@property (weak, nonatomic) IBOutlet UIView *inputFieldContainerView;
@property (weak, nonatomic) IBOutlet UITextField *phoneInputField;
@property (weak, nonatomic) IBOutlet UITextField *authCodeInputField;
@property (weak, nonatomic) IBOutlet UIButton *verificationBtn;
/**
 *  计时时长
 */
@property(nonatomic,assign)NSInteger wait_timeout;

@end

@implementation RegisterController

- (void)setWait_timeout:(NSInteger)wait_timeout {
    _wait_timeout = wait_timeout;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"手机注册";
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.wait_timeout = 60.0;
    self.inputFieldContainerView.layer.cornerRadius = 7;
    self.inputFieldContainerView.clipsToBounds = YES;
    self.inputFieldContainerView.layer.borderWidth = 1;
    self.inputFieldContainerView.layer.borderColor = [UIColor colorWithRed:225 / 255.0 green:225 / 255.0 blue:225 / 255.0 alpha:1].CGColor;
    NSMutableAttributedString *attributedUnderLineText = [[NSMutableAttributedString alloc]initWithString:[self.verificationBtn titleForState:UIControlStateNormal]];
    [attributedUnderLineText addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(0, attributedUnderLineText.string.length)];
    [attributedUnderLineText addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, attributedUnderLineText.string.length)];
    [attributedUnderLineText addAttribute:NSForegroundColorAttributeName value:kColorDefaultRed range:NSMakeRange(0, attributedUnderLineText.string.length)];
    [_verificationBtn setAttributedTitle:attributedUnderLineText forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onCommit:(UIButton *)sender {
    if (self.phoneInputField.text.length != 11 || ![Tool isMobileNumber:self.phoneInputField.text]) {
        [self showHint:@"请输入正确的手机号码"];
        return;
    }
    if (!self.authCodeInputField.text.length) {
        [self showHint:@"请填写验证码"];
        return;
    }
    kWeakSelf;
//    [SMSSDK commitVerificationCode:self.authCodeInputField.text phoneNumber:self.phoneInputField.text zone:@"86" result:^(SMSSDKUserInfo *userInfo, NSError *error) {
//        NSLog(@"commit verification code complete with user info %@,error %@",userInfo,error);
//        if (!error) {
            RegisterCompleteionInfo *completionInfoController = [[RegisterCompleteionInfo alloc] initWithNibName:@"RegisterCompleteionInfo" bundle:[NSBundle mainBundle]];
            completionInfoController.phoneNumber = self.phoneInputField.text;
             [weakSelf.navigationController pushViewController:completionInfoController animated:YES];
//        } else {
//            [weakSelf showHint:error.localizedDescription];
//        }
//    }];
}
- (IBAction)onGetAuthCode:(UIButton *)sender {
    NSString *phone = self.phoneInputField.text;
    if (![Tool isMobileNumber:phone]) {
        [self showHint:@"请输入正确的手机号码"];
        return;
    }
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    kWeakSelf;
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:phone zone:@"86" customIdentifier:@"" result:^(NSError *error) {
        if (!error) {
            NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:weakSelf selector:@selector(onTimer:) userInfo:nil repeats:YES];
            [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
            sender.enabled = NO;
        } else{
            [weakSelf showHint:error.localizedDescription];
        }
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        NSLog(@"get verification code complete with error %@",error);
    }];
}

- (void)onTimer:(NSTimer *)timer {
    if (self.wait_timeout > 0) {
        self.wait_timeout -= 1;
        [self.verificationBtn setTitle:[NSString stringWithFormat:@"%ldS后可重发",(long)self.wait_timeout] forState:UIControlStateNormal];
    } else {
        [self.verificationBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
        timer.fireDate = [NSDate distantFuture];
        [timer invalidate];
        timer = nil;
        self.wait_timeout = 60.0;
        self.verificationBtn.enabled = YES;
    }
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
