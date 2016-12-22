//
//  TripEditController.m
//  sishi
//
//  Created by likeSo on 2016/12/15.
//  Copyright © 2016年 Channce. All rights reserved.
//

#import "TripEditController.h"
#import "LabelSelectView.h"

@interface TripEditController ()
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UIButton *startDateBtn;
@property (weak, nonatomic) IBOutlet UITextField *destinationInputField;
@property (weak, nonatomic) IBOutlet UITextField *carTypeLabel;
@property (weak, nonatomic) IBOutlet LabelSelectView *labelSelectView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UITextField *noteInputField;

@end

@implementation TripEditController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    
}

- (void)setupView {
    NSArray *labels = ({
        NSMutableArray *labelList = [NSMutableArray arrayWithCapacity:10];
        for (NSInteger index = 0; index < 10; index ++) {
            NSString *labelString = [NSString stringWithFormat:@"标签%ld",index];
            [labelList addObject:labelString];
        }
        [NSArray arrayWithArray:labelList];
    });
    self.labelSelectView.labelFont = [UIFont systemFontOfSize:15];
    self.labelSelectView.labelList = labels;
    CGFloat viewHeight = [self.labelSelectView labelViewHeightForLabels:labels targetRectWidth:SCREENWIDTH - 10];
    self.labelViewHeightConstraint.constant = viewHeight;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.rdv_tabBarController setTabBarHidden:NO animated:YES];
}


/**
 点击 "完成"按钮
 */
- (IBAction)onComplete:(UIButton *)sender {
    
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
