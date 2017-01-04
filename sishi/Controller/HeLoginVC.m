//
//  HeLoginVC.m
//  beautyContest
//
//  Created by HeDongMing on 16/7/30.
//  Copyright © 2016年 iMac. All rights reserved.
//

#import "HeLoginVC.h"
#import "TTTAttributedLabel.h"
#import "RegisterController.h"
#import "LoginViewController.h"
#import "ReactiveCocoa.h"
#import "WXApi.h"

@interface HeLoginVC ()<WXApiDelegate>
@property (weak, nonatomic) IBOutlet TTTAttributedLabel *attributeLabel;
@property (weak, nonatomic) IBOutlet UIButton *accountLabel;

@end

@implementation HeLoginVC

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
//        label.backgroundColor = [UIColor clearColor];
//        label.font = APPDEFAULTTITLETEXTFONT;
//        label.textColor = APPDEFAULTTITLECOLOR;
//        label.textAlignment = NSTextAlignmentCenter;
//        self.navigationItem.titleView = label;
//        label.text = @"登录";
//        
//        [label sizeToFit];
//        self.title = @"登录";
//    }
//    return self;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initializaiton];
    [self initView];
}

- (void)initializaiton
{
    [super initializaiton];
    
    self.accountLabel.layer.borderColor = [UIColor whiteColor].CGColor;
    kWeakSelf;
    [[NSNotificationCenter defaultCenter]addObserverForName:USERREGISTERSUCCESSKEY object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        NSString *uname = note.userInfo[@"uname"];
        NSString *password = note.userInfo[@"password"];
        [weakSelf.navigationController popToRootViewControllerAnimated:YES];
        LoginViewController *login = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:[NSBundle mainBundle]];
        login.uname = uname;
        login.password = password;
        [weakSelf.navigationController pushViewController:login animated:YES];
    }];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:@"注册账号即表示我同意 司事 的服务条款、支付服务条款、隐私政策、退款政策和司机保障计划条款"];
    [attributedString addAttribute:NSUnderlineStyleAttributeName value:@1 range:NSMakeRange(15, 4)];
    [attributedString addAttribute:NSUnderlineStyleAttributeName value:@1 range:NSMakeRange(20, 6)];
    [attributedString addAttribute:NSUnderlineStyleAttributeName value:@1 range:NSMakeRange(27, 4)];
    [attributedString addAttribute:NSUnderlineStyleAttributeName value:@1 range:NSMakeRange(32, 4)];
    [attributedString addAttribute:NSUnderlineStyleAttributeName value:@1 range:NSMakeRange(37, 8)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, attributedString.string.length)];
    self.attributeLabel.attributedText = attributedString;
    self.attributeLabel.linkAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    TTTAttributedLabelLinkBlock linkOnTapCallBackBlock =  ^(TTTAttributedLabel *label,TTTAttributedLabelLink *link) {
        NSLog(@"%@",link.result.URL);
    };
//    self.view.
    
  TTTAttributedLabelLink *servicelink =  [self.attributeLabel addLinkToURL:[NSURL URLWithString:@"服务条款URL"] withRange:NSMakeRange(15, 4)];
    servicelink.linkTapBlock = linkOnTapCallBackBlock;
    
    TTTAttributedLabelLink *payServiceLink = [self.attributeLabel addLinkToURL:[NSURL URLWithString:@"支付服务条款URL"] withRange:NSMakeRange(20,6)];
    payServiceLink.linkTapBlock = linkOnTapCallBackBlock;
    
    TTTAttributedLabelLink *privacyLink = [self.attributeLabel addLinkToURL:[NSURL URLWithString:@"隐私政策条款URL"] withRange:NSMakeRange(27,4)];
    privacyLink.linkTapBlock = linkOnTapCallBackBlock;
    
    TTTAttributedLabelLink *refundLink = [self.attributeLabel addLinkToURL:[NSURL URLWithString:@"退款URL"] withRange:NSMakeRange(32,4)];
    refundLink.linkTapBlock = linkOnTapCallBackBlock;
    
    TTTAttributedLabelLink *securityLink = [self.attributeLabel addLinkToURL:[NSURL URLWithString:@"司机保障计划URL"] withRange:NSMakeRange(37,8)];
    securityLink.linkTapBlock = linkOnTapCallBackBlock;
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)initView
{
    [super initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onWeChatLogin:(UIButton *)sender {
    
    SendAuthReq* req =[[SendAuthReq alloc ] init];
    req.scope = @"snsapi_userinfo,snsapi_base";
    req.state = @"0744" ;
    [WXApi sendAuthReq:req viewController:self delegate:self];
}
- (IBAction)onCreatAccount:(UIButton *)sender {
//    sender.
    RegisterController *registerController = [[RegisterController alloc] initWithNibName:@"RegisterController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:registerController animated:YES];
}
- (IBAction)onLogin:(UIButton *)sender {
    LoginViewController *login = [[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:[NSBundle mainBundle]];
    
    [self.navigationController pushViewController:login animated:YES];
    
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
