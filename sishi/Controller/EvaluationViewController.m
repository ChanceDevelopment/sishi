//
//  EvaluationViewController.m
//  sishi
//
//  Created by likeSo on 2016/12/29.
//  Copyright © 2016年 Channce. All rights reserved.
//

#import "EvaluationViewController.h"
#import "LabelSelectView.h"
#import "ApiUtils.h"
#import "UIButton+EMWebCache.h"
#import "CompaintsController.h"

@interface EvaluationViewController ()<LabelSelectViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *hobbyBtn;
@property (weak, nonatomic) IBOutlet UILabel *genderLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *headerBtn;
/**
 *  是否是评价司机模式,根据本地judge判断
 */
@property(nonatomic,assign)BOOL isEvaluationForDriver;
@property (weak, nonatomic) IBOutlet LabelSelectView *labelSelectView;
@property (weak, nonatomic) IBOutlet LabelSelectView *labelShowView;
@property (weak, nonatomic) IBOutlet UILabel *counterLabel;

/**
 *  最多可添加的标签数量
 */
@property(nonatomic,assign)NSUInteger maximumLabelCount;

/**
 *  评价标签列表
 */
@property(nonatomic,strong)NSArray <CommentLabelModel *>*commentLabelModelList;

/**
 *  存储已选择的标签列表
 */
@property(nonatomic,copy)NSMutableArray <NSString *>*selectedLabelList;


@end

@implementation EvaluationViewController


- (BOOL)isEvaluationForDriver {
    return [[Tool uid] isEqualToString:@"1"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.isEvaluationForDriver) {
        self.navigationItem.title = @"评价司机";
    } else {
        self.navigationItem.title = @"评价乘客";
    }
    [self setupView];
}


- (NSString *)labelIdWithName:(NSString *)labelName {
    if (!self.commentLabelModelList) {
        return @"0";
    }
    for (CommentLabelModel *labelModel in self.commentLabelModelList) {
        if (labelName == labelModel.labelContent) {
            return labelModel.labelId;
        }
    }
    return @"0";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.rdv_tabBarController setTabBarHidden:NO animated:YES];
}

- (void)setupView {
    self.maximumLabelCount = 2;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
//    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.labelSelectView.labelViewDelegate = self;
    self.labelSelectView.labelFont = [UIFont systemFontOfSize:13];
    self.labelShowView.labelFont = [UIFont systemFontOfSize:13];
    self.labelShowView.layer.cornerRadius = 2;
    self.labelShowView.layer.borderWidth = 1.0;
    
    self.labelShowView.layer.borderColor = kColorDefaultRed.CGColor;
    UIButton *complaintsBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    complaintsBtn.frame = CGRectMake(0, 0, 44, 44);
    [complaintsBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    complaintsBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [complaintsBtn setTitle:@"投诉" forState:UIControlStateNormal];
    [complaintsBtn addTarget:self action:@selector(onComplaint:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:complaintsBtn];
    [self configPageInfo];
}


- (void)configPageInfo {
    //查询被评价人的昵称,性别,爱好等信息
    [ApiUtils queryUserInfoBy:self.evaluateUserId onCompleteHandler:^(UserFollowListModel *userModel) {
        self.nameLabel.text = userModel.userNick;
        NSString *gender = [userModel.userSex isEqualToString:@"1"] ? @"男" : @"女";
        self.genderLabel.text = self.genderLabel.text = gender;
        [self.hobbyBtn setTitle:[NSString stringWithFormat:@"爱好 %@",userModel.userCredit] forState:UIControlStateNormal];
        NSURL *userImageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[ApiUtils baseUrl],userModel.userHeader]];
        [self.headerBtn sd_setImageWithURL:userImageUrl forState:UIControlStateNormal];
    } errorHandler:^(NSString *responseErrorInfo) {
        [self showHint:@"获取个人信息出现错误"];
    }];
    
    [ApiUtils queryAllLabelInfoWithCompleteHandler:^(NSArray<CommentLabelModel *> *commentLabelList) {
        self.commentLabelModelList = commentLabelList;
        NSMutableArray <NSString *>*labelNameList = [NSMutableArray arrayWithCapacity:commentLabelList.count];
        for (CommentLabelModel *labelModel in commentLabelList) {
            [labelNameList addObject:labelModel.labelContent];
        }
        self.labelSelectView.labelList = [NSArray arrayWithArray:labelNameList];
    } errorHandler:^(NSString *responseErrorInfo) {
        [self showHint:@"获取评论标签列表失败"];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
///"换一批" 按钮
- (IBAction)onChangeResource:(UIButton *)sender {
    
}


- (void)onComplaint:(UIButton *)btn {
    //投诉,进入投诉页面
    CompaintsController *complaintController = [[CompaintsController alloc]initWithNibName:@"CompaintsController" bundle:[NSBundle mainBundle]];
    complaintController.complaintId = self.evaluateUserId;
    [self.navigationController pushViewController:complaintController animated:YES];
}



#pragma mark :- LabelSelectViewDelegate & DataSource
- (void)labelView:(LabelSelectView *)labelView didAddLabelName:(NSString *)labelName {//选择某一标签,把已选中的标签View的标签添加
    if (labelView == self.labelSelectView) {
        NSMutableArray <NSString *>*labelNameList = [NSMutableArray arrayWithArray:self.labelShowView.labelList];
        [labelNameList addObject:labelName];
        self.labelShowView.labelList = [NSArray arrayWithArray:labelNameList];
        [self.selectedLabelList addObject:[self labelIdWithName:labelName]];
        self.counterLabel.text = [NSString stringWithFormat:@"还可以添加%lu个标签",self.maximumLabelCount - self.labelSelectView.selectedLabelList.count];
    }
}

- (void)labelView:(LabelSelectView *)labelView didRemoveLabelName:(NSString *)labelName {//删除某一标签,把已选中的标签View的对应标签删除
    if (labelView == self.labelSelectView) {
        [self.labelShowView removeLabelWithName:labelName];
        [self.selectedLabelList removeObject:[self labelIdWithName:labelName]];
        self.counterLabel.text = [NSString stringWithFormat:@"还可以添加%lu个标签",self.maximumLabelCount - self.labelSelectView.selectedLabelList.count];
    }
}

- (IBAction)onSubmit:(UIButton *)sender {//提交评价
    [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
    NSString *labels = [self.labelSelectView.selectedLabelList componentsJoinedByString:@","];
    [ApiUtils submitEvaluateUser:self.evaluateUserId tripId:self.tripId labels:labels onComplete:^{
        [MBProgressHUD hideHUDForView:self.view.window animated:YES];
        [self showHint:@"评价提交成功"];
        [self.navigationController popToRootViewControllerAnimated:YES];
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
