//
//  HeContestDetailVC.m
//  beautyContest
//
//  Created by HeDongMing on 16/7/31.
//  Copyright © 2016年 iMac. All rights reserved.
//

#import "HeUserVC.h"
#import "MLLabel+Size.h"
#import "HeBaseTableViewCell.h"
#import "AppDelegate.h"
#import "ApiUtils.h"
#import "SDCycleScrollView.h"
#import "LabelSelectView.h"

#define TextLineHeight 1.2f

@interface HeUserVC ()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL requestReply; //是否已经完成
}
@property(strong,nonatomic)IBOutlet UITableView *tableview;
@property(strong,nonatomic)UIView *sectionHeaderView;


/**
 *  详情Model
 */
@property(nonatomic,strong)UserFollowListModel *userModel;


/**
 *  图片轮播图
 */
@property(nonatomic,strong)SDCycleScrollView *imageBannerView;

@property(strong,nonatomic)NSArray *dataSource;
@property(strong,nonatomic)NSArray *iconDataSource;
@property(strong,nonatomic)UILabel *nameLabel;

@property(nonatomic,strong)NSDictionary *titleAttributes;

/**
 *  标签View的高度
 */
@property(nonatomic,assign)CGFloat labelViewCellHeight;

/**
 *  性别Label
 */
@property(nonatomic,strong)UILabel *genderLabel;

/**
 *  标签展示View
 */
@property(nonatomic,strong)LabelSelectView *labelView;


@property(strong,nonatomic)UILabel *addressLabel;
@property(strong,nonatomic)UIImageView *userBGImage;

@property(strong,nonatomic)UIView *userInfoView;

/**
 *  信任值View
 */
@property(nonatomic,strong)UILabel *trustValueLabel;


/**
 *  是否已关注当前用户
 */
@property(nonatomic,assign)BOOL isFocused;

/**
 *  是否已认证通过
 */
@property(nonatomic,assign)BOOL isCerificationed;
/**
 *  认证通过View
 */
@property(nonatomic,strong)UIView *authView;

@property(strong,nonatomic)UIView *userFavView;
@property(strong,nonatomic)UIView *commentView;
@property(strong,nonatomic)UIView *trustView;
@property(strong,nonatomic)NSMutableArray *likeArray;
@property(strong,nonatomic)NSMutableArray *commentArray;

/**
 *  签名Label
 */
@property(nonatomic,strong)UILabel *signLabel;
@property (weak, nonatomic) IBOutlet UIButton *focusBtn;
@property (weak, nonatomic) IBOutlet UIButton *contactBtn;

@end

@implementation HeUserVC
@synthesize tableview;
@synthesize sectionHeaderView;
@synthesize dataSource;
@synthesize iconDataSource;
@synthesize userBGImage;
@synthesize nameLabel;
@synthesize addressLabel;


@synthesize userInfoView;
@synthesize userFavView;
@synthesize commentView;
@synthesize trustView;
@synthesize authView;
@synthesize likeArray;
@synthesize commentArray;

- (UIColor *)normalBorderColor {
    return [UIColor colorWithWhite:237.0 / 255.0 alpha:1.0];
}

- (UIColor *)markedLabelBorderColor {
    return [UIColor colorWithRed:249 / 255.0 green:255 / 255.0 blue:175 / 255.0 alpha:1];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.backgroundColor = [UIColor clearColor];
        label.font = APPDEFAULTTITLETEXTFONT;
        label.textColor = APPDEFAULTTITLECOLOR;
        label.textAlignment = NSTextAlignmentCenter;
        self.navigationItem.titleView = label;
        label.text = @"我的";
        [label sizeToFit];
        
        self.title = @"";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self initializaiton];
    self.labelViewCellHeight = 95;
    [self initView];
    if (self.hasFocused) {
        [self.focusBtn setTitle:@"    取消关注" forState:UIControlStateNormal];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.titleAttributes = self.navigationController.navigationBar.titleTextAttributes;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.onExit) {
        self.onExit(self.hasFocused);
    }
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationController.navigationBar.titleTextAttributes = self.titleAttributes;
    [self.rdv_tabBarController setTabBarHidden:NO animated:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.shadowImage = nil;
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
}

- (void)initializaiton
{
//    [super initializaiton];
    dataSource = @[@[@"我的相册",@"我的发布",@"我的参与"],@[@"设置"]];
    iconDataSource = @[@[@"icon_album",@"icon_put",@"icon_participation"],@[@"icon_setting"]];
}

- (void)initView
{
//    [super initView];
    tableview.backgroundView = nil;
    tableview.backgroundColor = [UIColor colorWithWhite:237.0 /255.0 alpha:1.0];
    [Tool setExtraCellLineHidden:tableview];
    
    dataSource = @[@[@"我的相册",@"我的发布",@"我的参与"],@[@"设置"]];
    
    CGFloat headerH = 200;
//    self.navigationController.navigationBar.translucent = NO;
//    self.navigationController.navigationBarHidden = YES;
    
    sectionHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, headerH)];
    sectionHeaderView.backgroundColor = [UIColor colorWithWhite:237.0 / 255.0 alpha:1.0];
    sectionHeaderView.userInteractionEnabled = YES;
    
    tableview.tableHeaderView = sectionHeaderView;
    
//    userBGImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"demo_nearBgImage.jpg"]];
//    userBGImage.layer.masksToBounds = YES;
//    userBGImage.contentMode = UIViewContentModeScaleAspectFill;
//    userBGImage.frame = CGRectMake(0, 0, SCREENWIDTH, headerH);
//    [sectionHeaderView addSubview:userBGImage];
//    userBGImage.userInteractionEnabled = YES;
//    sectionHeaderView.userInteractionEnabled = YES;
    self.imageBannerView = [[SDCycleScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, headerH)];
    self.imageBannerView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    self.imageBannerView.autoScroll = NO;
    [sectionHeaderView addSubview:self.imageBannerView];
    
//    CGFloat buttonX = 20;
//    CGFloat buttonY = 50;
//    CGFloat buttonW = 25;
//    CGFloat buttonH = 25;
//    UIButton *backButton = [[UIButton alloc] init];
//    backButton.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
//    [backButton setImage:[UIImage imageNamed:@"navigationBar_back_icon"] forState:UIControlStateNormal];
//    [backButton addTarget:self action:@selector(backItemClick:) forControlEvents:UIControlEventTouchUpInside];
//    [userBGImage addSubview:backButton];
    
    [self initUserInfoView];
    [self initAuthView];
    [self initUserFavView];
    [self initCommentView];
    [self initTrustView];
    
}

- (void)initAuthView {
    authView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 150)];
    authView.userInteractionEnabled = YES;
    CGFloat titleLabelX = 10;
    CGFloat titleLabelY = 10;
    CGFloat titleLabelH = 40;
    CGFloat titleLabelW = SCREENWIDTH - 2 * titleLabelX;
    UILabel *authLabel = [[UILabel alloc]initWithFrame:CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH)];
    authLabel.font = [UIFont systemFontOfSize:20];
    authLabel.textColor = [UIColor grayColor];
    authLabel.backgroundColor = [UIColor clearColor];
    authLabel.textAlignment = NSTextAlignmentLeft;
    authLabel.text = @"认证";
    [authView addSubview:authLabel];
    
    UIButton *authButton = [UIButton buttonWithType:UIButtonTypeCustom];
    authButton.titleLabel.font = [UIFont systemFontOfSize:14];
    authButton.frame = CGRectMake(CGRectGetMinX(authLabel.frame), CGRectGetMaxY(authLabel.frame) + 10, 220, 20);
    [authButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    authButton.userInteractionEnabled = NO;
    //TODO:设置本按钮的图片
    [authButton setTitle:@"真实信息已通过微信支付认证" forState:UIControlStateNormal];
    [authView addSubview:authButton];
    
}

- (void)initUserInfoView
{
    userInfoView = [[UIView alloc] init];
    userInfoView.userInteractionEnabled = YES;//新增
    CGFloat nameLabelX = 10;
    CGFloat nameLabelY = 10;
    CGFloat nameLabelH = 40;
    CGFloat nameLabelW = SCREENWIDTH - 2 * nameLabelX;
    nameLabel = [[UILabel alloc] init];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.text = @"您好,我是Air";
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.font = [UIFont systemFontOfSize:20.0];
    nameLabel.frame = CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    [userInfoView addSubview:nameLabel];
    
    
    CGFloat sexLabelX = 10;
    CGFloat sexLabelY = CGRectGetMaxY(nameLabel.frame);
    CGFloat sexLabelH = 30;
    CGFloat sexLabelW = SCREENWIDTH - 2 * sexLabelX;
    self.genderLabel = [[UILabel alloc] init];
    self.genderLabel.textAlignment = NSTextAlignmentLeft;
    self.genderLabel.backgroundColor = [UIColor clearColor];
    self.genderLabel.text = @"女   22岁    VIPS";
    self.genderLabel.textAlignment = NSTextAlignmentLeft;
    self.genderLabel.textColor = [UIColor grayColor];
    self.genderLabel.font = [UIFont systemFontOfSize:15.0];
    self.genderLabel.frame = CGRectMake(sexLabelX, sexLabelY, sexLabelW, sexLabelH);
    [userInfoView addSubview:self.genderLabel];
    
    CGFloat addressLabelX = 10;
    CGFloat addressLabelY = CGRectGetMaxY(self.genderLabel.frame);
    CGFloat addressLabelH = 30;
    CGFloat addressLabelW = SCREENWIDTH - 2 * sexLabelX;
    addressLabel = [[UILabel alloc] init];
    addressLabel.textAlignment = NSTextAlignmentLeft;
    addressLabel.backgroundColor = [UIColor clearColor];
    addressLabel.text = @"杭州         浙江省";
    addressLabel.textAlignment = NSTextAlignmentLeft;
    addressLabel.textColor = [UIColor grayColor];
    addressLabel.font = [UIFont systemFontOfSize:15.0];
    addressLabel.frame = CGRectMake(addressLabelX, addressLabelY, addressLabelW, addressLabelH);
    [userInfoView addSubview:addressLabel];
    
    CGFloat signLabelX = 10;
    CGFloat signLabelY = CGRectGetMaxY(addressLabel.frame);
    CGFloat signLabelH = 30;
    CGFloat signLabelW = SCREENWIDTH - 2 * sexLabelX;
    self.signLabel = [[UILabel alloc] init];
    self.signLabel.textAlignment = NSTextAlignmentLeft;
    self.signLabel.backgroundColor = [UIColor clearColor];
    self.signLabel.text = @"我想和你一起虚度时光";
    self.signLabel.textAlignment = NSTextAlignmentLeft;
    self.signLabel.textColor = [UIColor grayColor];
    self.signLabel.font = [UIFont systemFontOfSize:15.0];
    self.signLabel.frame = CGRectMake(signLabelX, signLabelY, signLabelW, signLabelH);
    [userInfoView addSubview:self.signLabel];
    
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
    
    userInfoView.frame = CGRectMake(0, 0, SCREENWIDTH, 150);
}

- (void)appointMentButtonClick:(UIButton *)button
{
    NSLog(@"button = %@",button);
}
//个人资料
- (void)initUserFavView
{
    UIFont *font = [UIFont systemFontOfSize:18.0];
    
    userFavView = [[UIView alloc] init];
    CGFloat titleLabelX = 10;
    CGFloat titleLabelY = 10;
    CGFloat titleLabelH = 40;
    CGFloat titleLabelW = SCREENWIDTH - 2 * titleLabelX;
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"个人资料";
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.textColor = [UIColor grayColor];
    titleLabel.font = [UIFont systemFontOfSize:20.0];
    titleLabel.frame = CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
    [userFavView addSubview:titleLabel];
    
    CGFloat iconX = 10;
    CGFloat iconY = CGRectGetMaxY(titleLabel.frame) + 10;
    CGFloat iconW = 20;
    CGFloat iconH = 20;
    UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_tips"]];
    icon.frame = CGRectMake(iconX, iconY, iconW, iconH);
    [userFavView addSubview:icon];
    
    CGFloat likeLabelX = CGRectGetMaxX(icon.frame) + 5;
    CGFloat likeLabelY = CGRectGetMaxY(titleLabel.frame) + 5;
    CGFloat likeLabelH = 30;
    CGFloat likeLabelW = 50;
    UILabel *likeLabel = [[UILabel alloc] init];
    likeLabel.textAlignment = NSTextAlignmentLeft;
    likeLabel.backgroundColor = [UIColor clearColor];
    likeLabel.text = @"爱好";
    likeLabel.textAlignment = NSTextAlignmentLeft;
    likeLabel.textColor = [UIColor grayColor];
    likeLabel.font = [UIFont systemFontOfSize:18.0];
    likeLabel.frame = CGRectMake(likeLabelX, likeLabelY, likeLabelW, likeLabelH);
    [userFavView addSubview:likeLabel];
    
    CGFloat likeContentLabelX = CGRectGetMaxX(likeLabel.frame) + 5;
    CGFloat likeContentLabelY = CGRectGetMaxY(titleLabel.frame) + 5;
    CGFloat likeContentLabelH = 30;
    CGFloat likeContentLabelW = SCREENWIDTH - likeContentLabelX - 10;
    
    UIFont *contentfont = [UIFont systemFontOfSize:16.0];
    NSString *likeString = @"喜欢民谣、小清新  爱旅游  爱健身";
    CGSize textSize = [MLLinkLabel getViewSizeByString:likeString maxWidth:likeContentLabelW font:font lineHeight:TextLineHeight lines:0];
    if (textSize.height < 30) {
        textSize.height = 30;
    }
    UILabel *likeContentLabel = [[UILabel alloc] init];
    likeContentLabel.numberOfLines = 0;
    likeContentLabel.textAlignment = NSTextAlignmentLeft;
    likeContentLabel.backgroundColor = [UIColor clearColor];
    likeContentLabel.text = likeString;
    likeContentLabel.textAlignment = NSTextAlignmentLeft;
    likeContentLabel.textColor = [UIColor grayColor];
    likeContentLabel.font = contentfont;
    likeContentLabel.frame = CGRectMake(likeContentLabelX, likeContentLabelY, likeContentLabelW, textSize.height);
    [userFavView addSubview:likeContentLabel];
    
    userFavView.frame = CGRectMake(0, 0, SCREENWIDTH, 150);
}
//评价
- (void)initCommentView
{
    commentView = [[UIView alloc] init];
    commentView.userInteractionEnabled = YES;
    CGFloat titleLabelX = 10;
    CGFloat titleLabelY = 10;
    CGFloat titleLabelH = 40;
    CGFloat titleLabelW = SCREENWIDTH - 2 * titleLabelX;
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"评价";
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.textColor = [UIColor grayColor];
    titleLabel.font = [UIFont systemFontOfSize:20.0];
    titleLabel.frame = CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
    [commentView addSubview:titleLabel];
    
//    NSArray *array = @[@"非常有礼貌1",@"美女1",@"小清新1",@"斯文10086",@"美女1000",@"美女23"];
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
    CGFloat minx = CGRectGetMinX(titleLabel.frame);
    self.labelView = [[LabelSelectView alloc]initWithFrame:CGRectMake(CGRectGetMinX(titleLabel.frame), CGRectGetMaxY(titleLabel.frame) + 10, SCREENWIDTH - (minx * 2), 35)];
    self.labelView.userInteractionEnabled = NO;
    self.labelView.labelFont = [UIFont systemFontOfSize:14];
    self.labelView.backgroundColor = [UIColor whiteColor];
    kWeakSelf;
    self.labelView.onChangeHeight = ^(CGFloat viewHeight) {
        [weakSelf.tableview beginUpdates];
        weakSelf.labelViewCellHeight = viewHeight + 100;
        CGRect originFrame = weakSelf.labelView.frame;
        originFrame.size.height = viewHeight;
        weakSelf.labelView.frame = originFrame;
//        CGRect originCommentView = weakSelf.commentView.frame;
//        originCommentView.size.height = weakSelf.labelViewCellHeight;
//        weakSelf.commentView.frame = originFrame;
        NSLog(@"will change view height to %f",weakSelf.labelViewCellHeight);
        [weakSelf.tableview endUpdates];
    };
    [commentView addSubview:self.labelView];
    
    commentView.frame = CGRectMake(0, 0, SCREENWIDTH, 150);
}

//信任值
- (void)initTrustView
{
    trustView = [[UIView alloc] init];
    CGFloat titleLabelX = 10;
    CGFloat titleLabelY = 10;
    CGFloat titleLabelH = 40;
    CGFloat titleLabelW = SCREENWIDTH - 2 * titleLabelX;
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = @"信任值";
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.textColor = [UIColor grayColor];
    titleLabel.font = [UIFont systemFontOfSize:20.0];
    titleLabel.frame = CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
    [trustView addSubview:titleLabel];
    
    CGFloat iconX = 10;
    CGFloat iconY = CGRectGetMaxY(titleLabel.frame) + 10;
    CGFloat iconW = 20;
    CGFloat iconH = 20;
    UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_cooperate"]];
    icon.frame = CGRectMake(iconX, iconY, iconW, iconH);
    [trustView addSubview:icon];
    
    CGFloat subTitleLabelX = CGRectGetMaxX(icon.frame) + 10;
    CGFloat subTitleLabelY = CGRectGetMaxY(titleLabel.frame);
    CGFloat subTitleLabelH = 30;
    CGFloat subTitleLabelW = SCREENWIDTH - subTitleLabelX - 10;
    self.trustValueLabel = [[UILabel alloc] init];
    self.trustValueLabel.textAlignment = NSTextAlignmentLeft;
    self.trustValueLabel.backgroundColor = [UIColor clearColor];
    self.trustValueLabel.text = @"信任值12分";
    self.trustValueLabel.textAlignment = NSTextAlignmentLeft;
    self.trustValueLabel.textColor = [UIColor blackColor];
    self.trustValueLabel.font = [UIFont systemFontOfSize:18.0];
    self.trustValueLabel.frame = CGRectMake(subTitleLabelX, subTitleLabelY, subTitleLabelW, subTitleLabelH);
    [trustView addSubview:self.trustValueLabel];
    
    CGFloat contentLabelX = CGRectGetMaxX(icon.frame) + 10;
    CGFloat contentLabelY = CGRectGetMaxY(self.trustValueLabel.frame);
    CGFloat contentLabelH = 30;
    CGFloat contentLabelW = SCREENWIDTH - subTitleLabelX - 10;
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.textAlignment = NSTextAlignmentLeft;
    contentLabel.backgroundColor = [UIColor clearColor];
    contentLabel.text = @"满分12分";
    contentLabel.textAlignment = NSTextAlignmentLeft;
    contentLabel.textColor = [UIColor grayColor];
    contentLabel.font = [UIFont systemFontOfSize:16.0];
    contentLabel.frame = CGRectMake(contentLabelX, contentLabelY, contentLabelW, contentLabelH);
    [trustView addSubview:contentLabel];
    
    trustView.frame = CGRectMake(0, 0, SCREENWIDTH, 150);
    
}

- (UILabel *)labelWithTitle:(NSString *)title frame:(CGRect)labelFrame
{
    UIFont *font = [UIFont systemFontOfSize:16.0];
    
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor clearColor];
    label.layer.cornerRadius = 2.0;
    label.numberOfLines = 0;
    label.font = font;
    label.text = title;
    label.textColor = [UIColor grayColor];
    label.layer.borderWidth = 1.0;
    label.layer.borderColor = [UIColor colorWithWhite:237.0 / 255.0 alpha:1.0].CGColor;
    label.layer.masksToBounds = YES;
    label.textAlignment = NSTextAlignmentCenter;
    CGFloat maxWidth = labelFrame.size.width;
    CGSize textSize = [MLLinkLabel getViewSizeByString:title maxWidth:maxWidth font:font lineHeight:TextLineHeight lines:0];
    labelFrame.size.width = textSize.width + 10;
    label.frame = labelFrame;
    
    
    return label;
}

- (UIButton *)buttonWithTitle:(NSString *)buttonTitle frame:(CGRect)buttonFrame
{
    UIButton *button = [[UIButton alloc] initWithFrame:buttonFrame];
    [button addTarget:self action:@selector(filterButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//    [button setBackgroundImage:[Tool buttonImageFromColor:[UIColor whiteColor] withImageSize:button.frame.size] forState:UIControlStateSelected];
//    [button setBackgroundImage:[Tool buttonImageFromColor:sectionHeaderView.backgroundColor withImageSize:button.frame.size] forState:UIControlStateNormal];
    
    UILabel *buttonNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, buttonFrame.size.width, buttonFrame.size.height / 2.0)];
    buttonNameLabel.textColor = [UIColor whiteColor];
    buttonNameLabel.text = buttonTitle;
    buttonNameLabel.backgroundColor = [UIColor clearColor];
    buttonNameLabel.font = [UIFont systemFontOfSize:12.0];
    buttonNameLabel.textAlignment = NSTextAlignmentCenter;
    [button addSubview:buttonNameLabel];
    
    UILabel *buttonNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, buttonFrame.size.height / 2.0, buttonFrame.size.width, buttonFrame.size.height / 2.0)];
    buttonNumberLabel.text = @"125";
    buttonNumberLabel.backgroundColor = [UIColor clearColor];
    buttonNumberLabel.textColor = [UIColor whiteColor];
    buttonNumberLabel.font = [UIFont systemFontOfSize:12.0];
    buttonNumberLabel.textAlignment = NSTextAlignmentCenter;
    [button addSubview:buttonNumberLabel];
    
    return button;
}

- (void)setUid:(NSString *)uid {
    _uid = uid;
    [self configPageInfo];
}

///查询用户信息
- (void)configPageInfo {
    [ApiUtils queryCommentLabelsForUser:self.uid
                    withCompleteHandler:^(NSArray<UserCommentLabelModel *> *labels) {
                        NSMutableArray <NSString *>*labelList = [NSMutableArray arrayWithCapacity:labels.count];
                        for (UserCommentLabelModel *model in labels) {
                            [labelList addObject:model.labelName];
                        }
                        self.labelView.labelList = [NSArray arrayWithArray:labelList];
    } errorHandler:^(NSString *responseErrorInfo) {
        NSLog(@"暂无评价信息");
    }];
        
    [ApiUtils queryUserInfoBy:self.uid onCompleteHandler:^(UserFollowListModel *userModel) {
        self.userModel = userModel;
        self.nameLabel.text = [NSString stringWithFormat:@"您好,我是%@",userModel.userNick];
        NSString *gender = @"男";
        if ([userModel.userSex isEqualToString:@"1"]) {}
        else if ([userModel.userSex isEqualToString:@"2"]) {
            gender = @"女";
        } else {
            gender = @"未知";
        }
        NSString *age = [NSString stringWithFormat:@"%@岁",userModel.userAge];
        self.genderLabel.text = [NSString stringWithFormat:@"%@   %@",gender,age];
        self.addressLabel.text = [NSString stringWithFormat:@"%@     %@",userModel.userCity,userModel.userProvince];
        self.signLabel.text = userModel.userSign;
        
        NSString *imageName = userModel.userHeader ? userModel.userHeader : @"";
        self.imageBannerView.imageURLStringsGroup = @[imageName];
        self.trustValueLabel.text = [NSString stringWithFormat:@"信任值%@分",userModel.userCredit];
    } errorHandler:^(NSString *responseErrorInfo) {
        [self showHint:responseErrorInfo];
    }];
}

- (void)filterButtonClick:(UIButton *)button
{
    NSLog(@"button = %@",button);
}
- (IBAction)onFocus:(UIButton *)sender {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    if (!self.hasFocused) {
        [ApiUtils userFocusWithUserId:self.uid onComplete:^{
            [sender setTitle:@"    取消关注" forState:UIControlStateNormal];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        } onError:^(NSString *responseErrorInfo) {
            [self showHint:responseErrorInfo];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }];
    } else {
        [ApiUtils removeFocusOnUser:self.uid onComplete:^{
            [MBProgressHUD hideHUDForView:self.view.window animated:YES];
            [sender setTitle:@"    关注" forState:UIControlStateNormal];
        } errorHandler:^(NSString *responseErrorInfo) {
            [self showHint:responseErrorInfo];
            [MBProgressHUD hideHUDForView:self.view.window animated:YES];
        }];
    }
}
- (IBAction)onContact:(UIButton *)sender {
    [MBProgressHUD showHUDAddedTo:self.view.window animated:YES];
    [ApiUtils sendAskingFor:self.uid tripId:@" " withCompleteHandler:^{
        [MBProgressHUD hideHUDForView:self.view.window animated:YES];
        [self showHint:@"邀约成功"];
    } errorHandler:^(NSString *responseErrorInfo) {
        [MBProgressHUD hideHUDForView:self.view.window animated:YES];
        [self showHint:responseErrorInfo];
    }];
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    
    static NSString *cellIndentifier = @"HeUserCellIndentifier";
    CGSize cellSize = [tableView rectForRowAtIndexPath:indexPath].size;
    
    
    HeBaseTableViewCell *cell  = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[HeBaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier cellSize:cellSize];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.clipsToBounds = YES;
    }
    switch (row) {
        case 0:
        {
            [cell.contentView addSubview:userInfoView];
            break;
        }
            case 1:
            [cell.contentView addSubview:authView];
            break;
        case 2:
        {
            [cell.contentView addSubview:userFavView];
            break;
        }
        case 3:
        {
            [cell.contentView addSubview:commentView];
            break;
        }
        case 4:
        {
            [cell.contentView addSubview:trustView];
            break;
        }
        default:
            break;
    }
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        if (!_isCerificationed) {
            return CGFLOAT_MIN;
        }
        return 95;
    } else if (indexPath.row == 3){
        return self.labelViewCellHeight;
    }
    return 150.0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    NSInteger row = indexPath.row;
//    NSInteger section = indexPath.section;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
