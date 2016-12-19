//
//  RegisterController.m
//  sishi
//
//  Created by likeSo on 2016/12/19.
//  Copyright © 2016年 Channce. All rights reserved.
//

#import "RegisterController.h"
#import "RegisterCompleteionInfo.h"

@interface RegisterController ()
@property (weak, nonatomic) IBOutlet UIView *inputFieldContainerView;
@property (weak, nonatomic) IBOutlet UITextField *phoneInputField;
@property (weak, nonatomic) IBOutlet UITextField *authCodeInputField;
@end

@implementation RegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"手机注册";
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.inputFieldContainerView.layer.cornerRadius = 7;
    self.inputFieldContainerView.clipsToBounds = YES;
    self.inputFieldContainerView.layer.borderWidth = 1;
    self.inputFieldContainerView.layer.borderColor = [UIColor colorWithRed:225 / 255.0 green:225 / 255.0 blue:225 / 255.0 alpha:1].CGColor;
}

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
//}
//
//- (void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onCommit:(UIButton *)sender {
    if (self.phoneInputField.text.length != 11) {
        return;
    }
    if (!self.authCodeInputField.text.length) {
        return;
    }
    RegisterCompleteionInfo *completionInfoController = [[RegisterCompleteionInfo alloc] initWithNibName:@"RegisterCompleteionInfo" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:completionInfoController animated:YES];
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
