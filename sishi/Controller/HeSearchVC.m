//
//  HeContestDetailVC.m
//  beautyContest
//
//  Created by HeDongMing on 16/7/31.
//  Copyright © 2016年 iMac. All rights reserved.
//

#import "HeSearchVC.h"
#import "MLLabel+Size.h"
#import "HeBaseTableViewCell.h"
#import "MLLinkLabel.h"
#import "SearchResultController.h"
#import "LabelSelectView.h"
#import "ApiUtils.h"

#define TextLineHeight 1.2f

@interface HeSearchVC ()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL requestReply; //是否已经完成
}
//@property(strong,nonatomic)IBOutlet UITableView *tableview;
//@property(strong,nonatomic)UIView *sectionHeaderView;
//@property(strong,nonatomic)NSArray *dataSource;
//@property(strong,nonatomic)NSArray *iconDataSource;
//@property(strong,nonatomic)UILabel *nameLabel;
//@property(strong,nonatomic)UILabel *addressLabel;
//@property(strong,nonatomic)UIImageView *userBGImage;
//
//@property(strong,nonatomic)UIView *userInfoView;
//@property(strong,nonatomic)UIView *userFavView;
//@property(strong,nonatomic)UIView *commentView;
//@property(strong,nonatomic)UIView *trustView;
//@property(strong,nonatomic)NSMutableArray *likeArray;
//@property(strong,nonatomic)NSMutableArray *commentArray;
@property (weak, nonatomic) IBOutlet UITextField *incarInputField;
@property (weak, nonatomic) IBOutlet UILabel *nearbyLabel;
@property (weak, nonatomic) IBOutlet LabelSelectView *labelSelectView;
@property (weak, nonatomic) IBOutlet UILabel *recentLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelSelectViewConstraint;

@end

@implementation HeSearchVC
//@synthesize tableview;
//@synthesize sectionHeaderView;
//@synthesize dataSource;
//@synthesize iconDataSource;
//@synthesize userBGImage;
//@synthesize nameLabel;
//@synthesize addressLabel;
//
//
//@synthesize userInfoView;
//@synthesize userFavView;
//@synthesize commentView;
//@synthesize trustView;
//@synthesize likeArray;
//@synthesize commentArray;
//
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
//        label.text = @"搜索";
//        [label sizeToFit];
//        
//        self.title = @"搜索";
//    }
//    return self;
//}
//
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    [self initializaiton];
//    [self initView];
//}
//
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
//
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
//
//- (void)initializaiton
//{
//    [super initializaiton];
//    dataSource = @[@[@"我的相册",@"我的发布",@"我的参与"],@[@"设置"]];
//    iconDataSource = @[@[@"icon_album",@"icon_put",@"icon_participation"],@[@"icon_setting"]];
//}
//
//- (void)initView
//{
//    [super initView];
//    tableview.backgroundView = nil;
//    tableview.backgroundColor = [UIColor colorWithWhite:237.0 /255.0 alpha:1.0];
//    [Tool setExtraCellLineHidden:tableview];
//    
//    dataSource = @[@[@"我的相册",@"我的发布",@"我的参与"],@[@"设置"]];
//    
//    CGFloat headerH = 200;
//    
//    sectionHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, headerH)];
//    sectionHeaderView.backgroundColor = [UIColor colorWithWhite:237.0 / 255.0 alpha:1.0];
//    sectionHeaderView.userInteractionEnabled = YES;
//    
////    tableview.tableHeaderView = sectionHeaderView;
//    
//    userBGImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"demo_nearBgImage.jpg"]];
//    userBGImage.layer.masksToBounds = YES;
//    userBGImage.contentMode = UIViewContentModeScaleAspectFill;
//    userBGImage.frame = CGRectMake(0, 0, SCREENWIDTH, headerH);
//    [sectionHeaderView addSubview:userBGImage];
//    
//    [self initUserInfoView];
//    [self initUserFavView];
//    [self initCommentView];
//    [self initTrustView];
//    
//}
//
//- (void)initUserInfoView
//{
//    userInfoView = [[UIView alloc] init];
//    CGFloat nameLabelX = 10;
//    CGFloat nameLabelY = 0;
//    CGFloat nameLabelH = 150;
//    CGFloat nameLabelW = SCREENWIDTH - 2 * nameLabelX;
//    nameLabel = [[UILabel alloc] init];
//    nameLabel.textAlignment = NSTextAlignmentLeft;
//    nameLabel.backgroundColor = [UIColor clearColor];
//    nameLabel.text = @"想去哪里？";
//    nameLabel.textAlignment = NSTextAlignmentLeft;
//    nameLabel.textColor = [UIColor blackColor];
//    nameLabel.font = [UIFont systemFontOfSize:30.0];
//    nameLabel.frame = CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
//    [userInfoView addSubview:nameLabel];
//    
//    return;
//    CGFloat sexLabelX = 10;
//    CGFloat sexLabelY = CGRectGetMaxY(nameLabel.frame);
//    CGFloat sexLabelH = 30;
//    CGFloat sexLabelW = SCREENWIDTH - 2 * sexLabelX;
//    UILabel *sexLabel = [[UILabel alloc] init];
//    sexLabel.textAlignment = NSTextAlignmentLeft;
//    sexLabel.backgroundColor = [UIColor clearColor];
//    sexLabel.text = @"女   22岁    VIPS";
//    sexLabel.textAlignment = NSTextAlignmentLeft;
//    sexLabel.textColor = [UIColor grayColor];
//    sexLabel.font = [UIFont systemFontOfSize:15.0];
//    sexLabel.frame = CGRectMake(sexLabelX, sexLabelY, sexLabelW, sexLabelH);
//    [userInfoView addSubview:sexLabel];
//    
//    CGFloat addressLabelX = 10;
//    CGFloat addressLabelY = CGRectGetMaxY(sexLabel.frame);
//    CGFloat addressLabelH = 30;
//    CGFloat addressLabelW = SCREENWIDTH - 2 * sexLabelX;
//    addressLabel = [[UILabel alloc] init];
//    addressLabel.textAlignment = NSTextAlignmentLeft;
//    addressLabel.backgroundColor = [UIColor clearColor];
//    addressLabel.text = @"杭州         浙江省";
//    addressLabel.textAlignment = NSTextAlignmentLeft;
//    addressLabel.textColor = [UIColor grayColor];
//    addressLabel.font = [UIFont systemFontOfSize:15.0];
//    addressLabel.frame = CGRectMake(addressLabelX, addressLabelY, addressLabelW, addressLabelH);
//    [userInfoView addSubview:addressLabel];
//    
//    CGFloat signLabelX = 10;
//    CGFloat signLabelY = CGRectGetMaxY(addressLabel.frame);
//    CGFloat signLabelH = 30;
//    CGFloat signLabelW = SCREENWIDTH - 2 * sexLabelX;
//    UILabel *signLabel = [[UILabel alloc] init];
//    signLabel.textAlignment = NSTextAlignmentLeft;
//    signLabel.backgroundColor = [UIColor clearColor];
//    signLabel.text = @"我想和你一起虚度时光";
//    signLabel.textAlignment = NSTextAlignmentLeft;
//    signLabel.textColor = [UIColor grayColor];
//    signLabel.font = [UIFont systemFontOfSize:15.0];
//    signLabel.frame = CGRectMake(signLabelX, signLabelY, signLabelW, signLabelH);
//    [userInfoView addSubview:signLabel];
//    
//    UIButton *appointmentButton = [[UIButton alloc] init];
//    appointmentButton.frame = CGRectMake(SCREENWIDTH - 70, nameLabelY, 60, 30);
//    [appointmentButton setTitle:@"约她(他)" forState:UIControlStateNormal];
//    appointmentButton.layer.cornerRadius = 3.0;
//    appointmentButton.layer.borderWidth = 1.0;
//    appointmentButton.layer.borderColor = [UIColor redColor].CGColor;
//    appointmentButton.layer.masksToBounds = YES;
//    [appointmentButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    [appointmentButton.titleLabel setFont:[UIFont systemFontOfSize:12.0]];
//    [userInfoView addSubview:appointmentButton];
//    [appointmentButton addTarget:self action:@selector(appointMentButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//}
//
//- (void)appointMentButtonClick:(UIButton *)button
//{
//    NSLog(@"button = %@",button);
//}
////个人资料
//- (void)initUserFavView
//{
//    UIFont *font = [UIFont systemFontOfSize:18.0];
//    
//    userFavView = [[UIView alloc] init];
//    CGFloat titleLabelX = 10;
//    CGFloat titleLabelY = 10;
//    CGFloat titleLabelH = 40;
//    CGFloat titleLabelW = SCREENWIDTH - 2 * titleLabelX;
//    UILabel *titleLabel = [[UILabel alloc] init];
//    titleLabel.textAlignment = NSTextAlignmentLeft;
//    titleLabel.backgroundColor = [UIColor clearColor];
//    titleLabel.text = @"附近";
//    titleLabel.textAlignment = NSTextAlignmentLeft;
//    titleLabel.textColor = [UIColor grayColor];
//    titleLabel.font = [UIFont systemFontOfSize:30.0];
//    titleLabel.frame = CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
//    [userFavView addSubview:titleLabel];
//    
////    CGFloat iconX = 10;
////    CGFloat iconY = CGRectGetMaxY(titleLabel.frame) + 10;
////    CGFloat iconW = 20;
////    CGFloat iconH = 20;
////    UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_tips"]];
////    icon.frame = CGRectMake(iconX, iconY, iconW, iconH);
////    [userFavView addSubview:icon];
//    
//    CGFloat likeLabelX = titleLabelX;
//    CGFloat likeLabelY = CGRectGetMaxY(titleLabel.frame) + 10;
//    CGFloat likeLabelH = 30;
//    CGFloat likeLabelW = SCREENWIDTH - 2 * titleLabelX;;
//    UILabel *likeLabel = [[UILabel alloc] init];
//    likeLabel.textAlignment = NSTextAlignmentLeft;
//    likeLabel.backgroundColor = [UIColor clearColor];
//    likeLabel.text = @"西溪湿地";
//    likeLabel.textAlignment = NSTextAlignmentLeft;
//    likeLabel.textColor = [UIColor grayColor];
//    likeLabel.font = [UIFont systemFontOfSize:24.0];
//    likeLabel.frame = CGRectMake(likeLabelX, likeLabelY, likeLabelW, likeLabelH);
//    [userFavView addSubview:likeLabel];
//    
//    return;
//    CGFloat likeContentLabelX = CGRectGetMaxX(likeLabel.frame) + 5;
//    CGFloat likeContentLabelY = CGRectGetMaxY(titleLabel.frame) + 10;
//    CGFloat likeContentLabelH = 30;
//    CGFloat likeContentLabelW = SCREENWIDTH - likeContentLabelX - 10;
//    
//    UIFont *contentfont = [UIFont systemFontOfSize:24.0];
//    NSString *likeString = @"喜欢民谣、小清新  爱旅游  爱健身";
//    CGSize textSize = [MLLinkLabel getViewSizeByString:likeString maxWidth:likeContentLabelW font:font lineHeight:TextLineHeight lines:0];
//    if (textSize.height < 30) {
//        textSize.height = 30;
//    }
//    UILabel *likeContentLabel = [[UILabel alloc] init];
//    likeContentLabel.numberOfLines = 0;
//    likeContentLabel.textAlignment = NSTextAlignmentLeft;
//    likeContentLabel.backgroundColor = [UIColor clearColor];
//    likeContentLabel.text = likeString;
//    likeContentLabel.textAlignment = NSTextAlignmentLeft;
//    likeContentLabel.textColor = [UIColor grayColor];
//    likeContentLabel.font = contentfont;
//    likeContentLabel.frame = CGRectMake(likeContentLabelX, likeContentLabelY, likeContentLabelW, textSize.height);
//    [userFavView addSubview:likeContentLabel];
//}
////相约怎样的人
//- (void)initCommentView
//{
//    commentView = [[UIView alloc] init];
//    CGFloat titleLabelX = 10;
//    CGFloat titleLabelY = 10;
//    CGFloat titleLabelH = 40;
//    CGFloat titleLabelW = SCREENWIDTH - 2 * titleLabelX;
//    UILabel *titleLabel = [[UILabel alloc] init];
//    titleLabel.textAlignment = NSTextAlignmentLeft;
//    titleLabel.backgroundColor = [UIColor clearColor];
//    titleLabel.text = @"想约怎样的人？";
//    titleLabel.textAlignment = NSTextAlignmentLeft;
//    titleLabel.textColor = [UIColor grayColor];
//    titleLabel.font = [UIFont systemFontOfSize:24.0];
//    titleLabel.frame = CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
//    [commentView addSubview:titleLabel];
//    
//    NSArray *array = @[@"听民谣",@"爱旅行",@"听民谣",@"听民谣",@"听民谣",@"听民谣",@"听民谣",@"听民谣"];
//    CGFloat labelX = 10;
//    CGFloat labelY = CGRectGetMaxY(titleLabel.frame) + 10;
//    CGFloat labelW = SCREENWIDTH - 2 * labelX;
//    CGFloat labelH = 30;
//    CGFloat labelDistanceX = 10;
//    CGFloat labelDistanceY = 5;
//    commentArray = [[NSMutableArray alloc] initWithArray:array];
//    for (NSInteger index = 0; index < [commentArray count]; index++) {
//        
//        NSString *title = commentArray[index];
//        CGRect frame = CGRectMake(labelX, labelY, labelW, labelH);
//        UILabel *marklabel = [self labelWithTitle:title frame:frame];
//        CGFloat width = SCREENWIDTH - labelX - 10;
//        if (marklabel.frame.size.width > width) {
//            labelX = 10;
//            labelY = labelY + labelH + labelDistanceY;
//        }
//        frame = marklabel.frame;
//        
//        frame.origin.x = labelX;
//        frame.origin.y = labelY;
//        
//        marklabel.frame = frame;
//        labelX = CGRectGetMaxX(marklabel.frame) + labelDistanceX;
//        [commentView addSubview:marklabel];
//    }
//}
//
//
//- (void)initTrustView
//{
//    UIFont *font = [UIFont systemFontOfSize:20.0];
//    trustView = [[UIView alloc] init];
//    CGFloat titleLabelX = 10;
//    CGFloat titleLabelY = 10;
//    CGFloat titleLabelH = 40;
//    CGFloat titleLabelW = SCREENWIDTH - 2 * titleLabelX;
//    UILabel *titleLabel = [[UILabel alloc] init];
//    titleLabel.textAlignment = NSTextAlignmentLeft;
//    titleLabel.backgroundColor = [UIColor clearColor];
//    titleLabel.text = @"最近搜索";
//    titleLabel.textAlignment = NSTextAlignmentLeft;
//    titleLabel.textColor = [UIColor grayColor];
//    titleLabel.font = [UIFont systemFontOfSize:20.0];
//    titleLabel.frame = CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
//    [trustView addSubview:titleLabel];
//    
//    CGFloat likeContentLabelX = 10;
//    CGFloat likeContentLabelY = CGRectGetMaxY(titleLabel.frame) + 5;
//    CGFloat likeContentLabelH = 30;
//    CGFloat likeContentLabelW = SCREENWIDTH - 2 * likeContentLabelX;
//    
//    UIFont *contentfont = [UIFont systemFontOfSize:16.0];
//    NSString *likeString = @"湖州、浙江省、西湖、珠海、爱旅游、爱健身";
//    CGSize textSize = [MLLinkLabel getViewSizeByString:likeString maxWidth:likeContentLabelW font:font lineHeight:TextLineHeight lines:0];
//    if (textSize.height < 30) {
//        textSize.height = 30;
//    }
//    UILabel *likeContentLabel = [[UILabel alloc] init];
//    likeContentLabel.numberOfLines = 0;
//    likeContentLabel.textAlignment = NSTextAlignmentLeft;
//    likeContentLabel.backgroundColor = [UIColor clearColor];
//    likeContentLabel.text = likeString;
//    likeContentLabel.textAlignment = NSTextAlignmentLeft;
//    likeContentLabel.textColor = [UIColor grayColor];
//    likeContentLabel.font = contentfont;
//    likeContentLabel.frame = CGRectMake(likeContentLabelX, likeContentLabelY, likeContentLabelW, textSize.height);
//    [trustView addSubview:likeContentLabel];
//    
//}
//
//- (UILabel *)labelWithTitle:(NSString *)title frame:(CGRect)labelFrame
//{
//    UIFont *font = [UIFont systemFontOfSize:16.0];
//    
//    UILabel *label = [[UILabel alloc] init];
//    label.backgroundColor = [UIColor clearColor];
//    label.layer.cornerRadius = 2.0;
//    label.numberOfLines = 0;
//    label.font = font;
//    label.text = title;
//    label.textColor = [UIColor grayColor];
//    label.layer.borderWidth = 0.0;
//    label.layer.borderColor = [UIColor clearColor].CGColor;
//    label.layer.masksToBounds = YES;
//    label.textAlignment = NSTextAlignmentCenter;
//    CGFloat maxWidth = labelFrame.size.width;
//    CGSize textSize = [MLLinkLabel getViewSizeByString:title maxWidth:maxWidth font:font lineHeight:TextLineHeight lines:0];
//    labelFrame.size.width = textSize.width + 10;
//    label.frame = labelFrame;
//    
//    
//    return label;
//}
//
//- (UIButton *)buttonWithTitle:(NSString *)buttonTitle frame:(CGRect)buttonFrame
//{
//    UIButton *button = [[UIButton alloc] initWithFrame:buttonFrame];
//    [button addTarget:self action:@selector(filterButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    //    [button setBackgroundImage:[Tool buttonImageFromColor:[UIColor whiteColor] withImageSize:button.frame.size] forState:UIControlStateSelected];
//    //    [button setBackgroundImage:[Tool buttonImageFromColor:sectionHeaderView.backgroundColor withImageSize:button.frame.size] forState:UIControlStateNormal];
//    
//    UILabel *buttonNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, buttonFrame.size.width, buttonFrame.size.height / 2.0)];
//    buttonNameLabel.textColor = [UIColor whiteColor];
//    buttonNameLabel.text = buttonTitle;
//    buttonNameLabel.backgroundColor = [UIColor clearColor];
//    buttonNameLabel.font = [UIFont systemFontOfSize:12.0];
//    buttonNameLabel.textAlignment = NSTextAlignmentCenter;
//    [button addSubview:buttonNameLabel];
//    
//    UILabel *buttonNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, buttonFrame.size.height / 2.0, buttonFrame.size.width, buttonFrame.size.height / 2.0)];
//    buttonNumberLabel.text = @"125";
//    buttonNumberLabel.backgroundColor = [UIColor clearColor];
//    buttonNumberLabel.textColor = [UIColor whiteColor];
//    buttonNumberLabel.font = [UIFont systemFontOfSize:12.0];
//    buttonNumberLabel.textAlignment = NSTextAlignmentCenter;
//    [button addSubview:buttonNumberLabel];
//    
//    return button;
//}
//
//- (void)filterButtonClick:(UIButton *)button
//{
//    NSLog(@"button = %@",button);
//}
//
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return 4;
//}
//
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}
//
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSInteger row = indexPath.row;
//    NSInteger section = indexPath.section;
//    
//    static NSString *cellIndentifier = @"HeUserCellIndentifier";
//    CGSize cellSize = [tableView rectForRowAtIndexPath:indexPath].size;
//    
//    
//    HeBaseTableViewCell *cell  = [tableView cellForRowAtIndexPath:indexPath];
//    if (!cell) {
//        cell = [[HeBaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
//        //        cell.selectionStyle = UITableViewCellSelectionStyleGray;
//        //        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    }
//    switch (row) {
//        case 0:
//        {
//            [cell addSubview:userInfoView];
//            break;
//        }
//        case 1:
//        {
//            [cell addSubview:userFavView];
//            break;
//        }
//        case 2:
//        {
//            [cell addSubview:commentView];
//            break;
//        }
//        case 3:
//        {
//            [cell addSubview:trustView];
//            break;
//        }
//        default:
//            break;
//    }
//    
//    
//    
//    
//    return cell;
//}
//
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 150.0;
//}
//
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    NSInteger row = indexPath.row;
//    NSInteger section = indexPath.section;
//    
//    
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
    self.title = @"搜索";
}

- (void)setupView {
    self.labelSelectView.labelFont = [UIFont systemFontOfSize:15];
//    self.labelSelectView.labelList  = @[@"标签内容balabala",@"标签内容balabala"];
//    CGFloat viewHeight = [self.labelSelectView labelViewHeightForLabels:self.labelSelectView.labelList targetRectWidth:SCREENWIDTH - 20];
//    self.labelSelectViewConstraint.constant = viewHeight;
    
        [ApiUtils queryAllHobbyListWithCompleteHandler:^(NSArray<HobbyListModel *> *hobbyList) {
            NSMutableArray *hobbyStringList  =[NSMutableArray arrayWithCapacity:hobbyList.count];
            for (HobbyListModel *hobbyModel in hobbyList) {
                [hobbyStringList addObject:hobbyModel.loveContent];
            }
            self.labelSelectView.labelList = [NSArray arrayWithArray:hobbyStringList];
            CGFloat viewHeight = [self.labelSelectView labelViewHeightForLabels:self.labelSelectView.labelList targetRectWidth:SCREENWIDTH - 20];
            self.labelSelectViewConstraint.constant = viewHeight;
        } errorHandler:^(NSString *responseErrorInfo) {
            [self showHint:responseErrorInfo];
        }];
self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
//     self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"返回"] style:UIBarButtonItemStylePlain target:nil action:nil];
}

- (IBAction)onSearch:(UIButton *)sender {
    
    if (!self.incarInputField.text.length) {
        [self showHint:@"请先填写上车地点"];
        return;
    } else if (!self.labelSelectView.selectedLabelList.count) {
//        [self showHint:@"请选"]
//        return;
    }
    SearchResultController *resultController = [[SearchResultController alloc]init];
    resultController.hobbyList = [self.labelSelectView.selectedLabelList componentsJoinedByString:@","];
    resultController.getinCarAddress = self.incarInputField.text;
    [self.navigationController pushViewController:resultController animated:YES];

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
