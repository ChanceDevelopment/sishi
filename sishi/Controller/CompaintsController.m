//
//  CompaintsController.m
//  sishi
//
//  Created by likeSo on 2016/12/29.
//  Copyright © 2016年 Channce. All rights reserved.
//

#import "CompaintsController.h"
#import "HCSStarRatingView.h"
#import "ApiUtils.h"

/**
 投诉页面
 */
@interface CompaintsController ()
@property (weak, nonatomic) IBOutlet HCSStarRatingView *starView;
@property (weak, nonatomic) IBOutlet UITextView *contentInputView;
@property (weak, nonatomic) IBOutlet UILabel *placeholderLabel;

@end

@implementation CompaintsController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onTextViewTextChanged:) name:UITextViewTextDidChangeNotification object:nil];
    self.navigationItem.title = @"投诉";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.rdv_tabBarController setTabBarHidden:NO animated:YES];
}

- (void)onTextViewTextChanged:(NSNotification *)note {
    self.placeholderLabel.hidden = self.contentInputView.text.length;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onComplete:(UIButton *)sender {
    if (self.starView.value <= 0 ) {
        [self showHint:@"请为Ta的请为打个分吧"];
        return;
    }
    [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
    [ApiUtils complaintsFor:self.complaintId content:self.contentInputView.text complain:(int)self.starView.value completeHandler:^{
        [MBProgressHUD hideHUDForView:self.view.window animated:YES];
        [self showHint:@"投诉信息已提交"];
    } errorHandler:^(NSString *responseErrorInfo) {
        [MBProgressHUD hideHUDForView:self.view.window animated:YES];
        [self showHint:responseErrorInfo];
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
