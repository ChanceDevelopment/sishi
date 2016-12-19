//
//  LoginViewController.m
//  sishi
//
//  Created by likeSo on 2016/12/19.
//  Copyright © 2016年 Channce. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIButton *passengerBtn;
@property (weak, nonatomic) IBOutlet UIButton *driverBtn;
@property (weak, nonatomic) IBOutlet UITextField *phoneInputField;
@property (weak, nonatomic) IBOutlet UITextField *passwordInputField;
@property (weak, nonatomic) IBOutlet UIView *inputFieldContainer;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.inputFieldContainer.layer.cornerRadius = 7;
    self.inputFieldContainer.clipsToBounds = YES;
    self.inputFieldContainer.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.inputFieldContainer.layer.borderWidth = 1.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onLogin:(UIButton *)sender {
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
