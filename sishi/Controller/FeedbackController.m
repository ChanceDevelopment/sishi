//
//  FeedbackController.m
//  sishi
//
//  Created by likeSo on 2016/12/25.
//  Copyright © 2016年 Channce. All rights reserved.
//

#import "FeedbackController.h"

@interface FeedbackController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *emailInputField;
@property (weak, nonatomic) IBOutlet UILabel *placeHolderLabel;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation FeedbackController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"反馈";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)textViewDidChange:(UITextView *)textView {
    self.placeHolderLabel.hidden = textView.text.length;
}
- (IBAction)onSend:(UIButton *)sender {
    if (!self.emailInputField.text.length) {
        [self showHint:@"请先填写您的邮箱"];
        return;
    } else if (!self.textView.text.length) {
        [self showHint:@"请填写反馈内容"];
        return;
    }
    //反馈
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
