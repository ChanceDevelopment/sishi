//
//  LoginViewController.m
//  sishi
//
//  Created by likeSo on 2016/12/19.
//  Copyright © 2016年 Channce. All rights reserved.
//

#import "LoginViewController.h"
#import "Tool.h"
#import "ApiUtils.h"
#import "AppDelegate.h"
#import <SMS_SDK/SMSSDK.h>
#import "WXApi.h"
#import "JPUSHService.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIButton *passengerBtn;
@property (weak, nonatomic) IBOutlet UIButton *driverBtn;
@property (weak, nonatomic) IBOutlet UITextField *phoneInputField;
@property (weak, nonatomic) IBOutlet UITextField *passwordInputField;
@property (weak, nonatomic) IBOutlet UIView *inputFieldContainer;

/**
 *  是否是司机模式
 */
@property(nonatomic,assign)BOOL isDriver;

@end

@implementation LoginViewController

- (void)setUname:(NSString *)uname {
    _uname = uname;
    self.phoneInputField.text = uname;
}

- (void)setPassword:(NSString *)password {
    _password = password;
    self.passwordInputField.text = password;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"登录";
    self.isDriver = YES;
    self.inputFieldContainer.layer.cornerRadius = 7;
    self.inputFieldContainer.clipsToBounds = YES;
    self.inputFieldContainer.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.inputFieldContainer.layer.borderWidth = 1.0;
    
    self.phoneInputField.text = self.uname;
    self.passwordInputField.text = self.password;
    
    [self.driverBtn setBackgroundImage:[Tool buttonImageFromColor:[UIColor colorWithWhite:0.5 alpha:1] withImageSize:CGSizeMake(1, 1)] forState:UIControlStateHighlighted];
    [self.passengerBtn  setBackgroundImage:[Tool buttonImageFromColor:[UIColor colorWithWhite:0.5 alpha:1] withImageSize:CGSizeMake(1, 1)] forState:UIControlStateHighlighted];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onLogin:(UIButton *)sender {
    if (![Tool isMobileNumber:self.phoneInputField.text]) {
        [self showHint:@"请输入正确的手机号码"];
        return;
    } else if ([Tool checkRegisterPassword:self.passwordInputField.text]) {
        [self showHint:@"请填写6-15位密码数字或字母"];
        return;
    }
    kWeakSelf;
    [self.view endEditing:YES];
    [self showHudInView:self.view hint:@"正在登录..."];
    [ApiUtils  loginWithUserName:self.phoneInputField.text
                             psw:self.passwordInputField.text
                       loginType:self.isDriver ? @"0" : @"1"
                  onResponseInfo:^(LoginUserInfoModel *userInfo) {
                      
                      dispatch_async(dispatch_get_global_queue(0, 0), ^{
                      BOOL isAuthlogin = [EMClient sharedClient].options.isAutoLogin;
                      EMError *loginError = nil;
                      if (!isAuthlogin) {//自动登录未开启则进行登录
                          loginError =  [[EMClient sharedClient]loginWithUsername:userInfo.userId password:weakSelf.passwordInputField.text];
                          if (!loginError) {
                              [[EMClient sharedClient].options setIsAutoLogin:YES];   
                          }
                      }
                          if (!loginError) {
                              dispatch_async(dispatch_get_main_queue(), ^{
                                  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                                  if (!weakSelf.isDriver) {//用户模式
                                      [defaults setObject:@"1" forKey:kDefaultsUserJudge];
                                  } else {//车主模式
                                      [defaults setObject:@"0" forKey:kDefaultsUserJudge];
                                  }
                                  [JPUSHService setTags:nil alias:userInfo.userId fetchCompletionHandle:nil];
                                  //保存登录信息
                                  
                                  [defaults setObject:userInfo.userId forKey:USERIDKEY];
                        [defaults setObject:userInfo.userSex forKey:kDefaultsUserGender];
                        [defaults setDouble:userInfo.userPositionX forKey:kDefaultsUserLocationlongitude];
                        [defaults setDouble:userInfo.userPositionY forKey:kDefaultsUserLocationLatitude];
                        [defaults setObject:userInfo.userPhone forKey:kDefaultsUserPhone];
                        [defaults setObject:userInfo.userHeader forKey:kDefaultsUserHeaderImage];
                        [defaults setObject:userInfo.userNick forKey:kDefaultsUserNick];
                        
                      [defaults setObject:userInfo.userAge forKey:kDefaultsUserAge];
                      [defaults setObject:userInfo.userAddress forKey:kDefaultsUserAddress];
                      [defaults setObject:userInfo.userSign forKey:kDefaultsUserSign];
                      [defaults setObject:userInfo.userDaty forKey:kDefaultsUserBirthday];
                      [defaults setObject:userInfo.userMouth forKey:kDefaultsUserBirthMonth];
                      [defaults setBool:[userInfo.userPass isEqualToString:@"1"] forKey:kDefaultsUserHaveCerificationed];
                                  [defaults synchronize];
                                  [weakSelf hideHud];
                      [[NSNotificationCenter defaultCenter]postNotificationName:KNOTIFICATION_LOGINCHANGE object:nil];
                              });
                          } else {
                              dispatch_async(dispatch_get_main_queue(), ^{
                                  [weakSelf hideHud];
                                  [weakSelf showHint:@"聊天服务登录异常"];
                                  NSLog(@"login easemob with error %@",loginError.errorDescription);
                              });
                          }
                      });
     
    } onResponseError:^(NSString *responseErrorInfo) {
        [weakSelf showHint:responseErrorInfo];
        [weakSelf hideHud];
    }];
}

- (IBAction)onPassenger:(UIButton *)sender {
    self.isDriver = NO;
    //被选中时的图片
    [sender setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self.driverBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
}
- (IBAction)onDriver:(UIButton *)sender {
    self.isDriver = YES;
    //被选中时的图片
    [sender setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self.passengerBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
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
