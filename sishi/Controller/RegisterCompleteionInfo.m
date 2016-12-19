//
//  RegisterCompleteionInfo.m
//  sishi
//
//  Created by likeSo on 2016/12/19.
//  Copyright © 2016年 Channce. All rights reserved.
//

#import "RegisterCompleteionInfo.h"

@interface RegisterCompleteionInfo ()
@property (weak, nonatomic) IBOutlet UIView *inputFieldContainerView;
@property (weak, nonatomic) IBOutlet UITextField *passwordInputField;
@property (weak, nonatomic) IBOutlet UITextField *nickNameInputField;

@end

@implementation RegisterCompleteionInfo

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"手机注册";
    
    self.inputFieldContainerView.layer.cornerRadius = 7;
    self.inputFieldContainerView.clipsToBounds = YES;
    self.inputFieldContainerView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.inputFieldContainerView.layer.borderWidth = 1.0;
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

- (void)awakeFromNib {
    [super awakeFromNib];
   
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onFinishRegister:(UIButton *)sender {
    
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
