//
//  HeChatVC.m
//  sishi
//
//  Created by HeDongMing on 16/8/13.
//  Copyright © 2016年 Channce. All rights reserved.
//

#import "HeChatVC.h"
#import "HeChatTableCell.h"
#import "ChatViewController.h"
#import "AppDelegate.h"
#import "EMSDK.h"
#import "Masonry.h"
#import "MJRefresh.h"
#import "InvitationSentCell.h"
#import "InvitationReceivedCell.h"

@interface HeChatVC ()<UITableViewDelegate,UITableViewDataSource,EMChatManagerDelegate,EaseMessageViewControllerDelegate,EaseMessageViewControllerDataSource>
@property(strong,nonatomic) UITableView *tableview;
/**
 *  系统消息列表界面
 */
@property(nonatomic,strong) UITableView *systemMessageTableView;

/**
 *  系统消息列表和聊天列表的ContainerView
 */
@property(nonatomic,strong) UIScrollView *containerView;
@property (weak, nonatomic) NSLayoutConstraint *tableContainerViewWidthConstraint;

@property (strong, nonatomic) UIView *tableContainerView;


/**
 *  聊天数据源数组
 */
@property(nonatomic,strong)NSMutableArray <EMConversation *>*chatArray;

/**
 *  占位Label
 */
@property(nonatomic,strong)UILabel *placeholderLabel;


@end

@implementation HeChatVC
@synthesize tableview;


- (NSMutableArray *)chatArray {
    if (!_chatArray) {
        _chatArray = [NSMutableArray array];
    }
    return _chatArray;
}

- (UILabel *)placeholderLabel {
    if (!_placeholderLabel) {
        _placeholderLabel = [[UILabel alloc]init];
        _placeholderLabel.text = @"暂无聊天消息";
        _placeholderLabel.font = [UIFont systemFontOfSize:28];
        _placeholderLabel.textColor = [UIColor colorWithWhite:0.5 alpha:1];
        _placeholderLabel.textAlignment = NSTextAlignmentCenter;
        _placeholderLabel.hidden  = YES;
    }
    return _placeholderLabel;
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
        label.text = @"消息";
        [label sizeToFit];
        self.title = @"";
    }
    return self;
}

- (void)dealloc
{
    [[EMClient sharedClient].chatManager removeDelegate:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:dispatch_get_main_queue()];
    [self initializaiton];
    
    
//    self.navigationItem.title = @"会话";
    [self setupView];
    [self initView];
}


- (void)setupView {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableContainerViewWidthConstraint.constant = SCREENWIDTH * 2.0;
    
    UISegmentedControl *segmentControl = [[UISegmentedControl alloc]initWithItems:@[@"聊天",@"消息"]];
    [segmentControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    segmentControl.tintColor = [UIColor whiteColor];
    segmentControl.frame = CGRectMake(0, 0, kScaleOfScreenWidth(130), 30);
    [segmentControl addTarget:self action:@selector(onSegment:) forControlEvents:UIControlEventValueChanged];
    segmentControl.selectedSegmentIndex = 0;
    self.navigationItem.titleView = segmentControl;
    
    
//    self.containerView = [[UIScrollView alloc]initWithFrame:CGRectZero];
    
    CGFloat viewHeight = CGRectGetHeight(self.view.bounds) - 49 - 64;
    
    self.containerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, SCREENWIDTH, viewHeight)];
    self.containerView.contentSize = CGSizeMake(SCREENWIDTH * 2.0, viewHeight);
    self.containerView.backgroundColor = [UIColor whiteColor];
    self.containerView.pagingEnabled = YES;
    self.containerView.scrollEnabled = NO;
    self.containerView.showsHorizontalScrollIndicator = NO;
    self.containerView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.containerView];
//     [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
//         make.top.equalTo(self.mas_topLayoutGuideBottom);
//         make.left.right.equalTo(self.view);
//         make.bottom.equalTo(self.mas_bottomLayoutGuideTop);
//     }];
    
    self.tableContainerView  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH * 2, CGRectGetHeight(self.view.bounds) - 49 - 64)];
    self.tableContainerView.backgroundColor = [UIColor whiteColor];
    [self.containerView addSubview:self.tableContainerView];
    
    
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, viewHeight)];
    
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.tableFooterView = [UIView new];
    self.tableview.backgroundColor = [UIColor whiteColor];
    [self.tableContainerView addSubview:self.tableview];
//    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.bottom.top.equalTo(self.tableContainerView);
//        make.width.equalTo(@(SCREENWIDTH));
//    }];
    
    self.tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(onHeaderRefresh:)];
    
    [self.tableview addSubview:self.placeholderLabel];
    [self.placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.tableview);
    }];

    self.systemMessageTableView = [[UITableView alloc]initWithFrame:CGRectMake(SCREENWIDTH, 0, SCREENWIDTH, viewHeight)];
    self.systemMessageTableView.delegate = self;
    self.systemMessageTableView.dataSource = self;
    self.systemMessageTableView.tableFooterView = [UIView new];
    self.systemMessageTableView.backgroundColor = [UIColor whiteColor];
    [self.tableContainerView addSubview:self.systemMessageTableView];
//    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.right.bottom.top.equalTo(self.tableContainerView);
//        make.left.equalTo(self.tableview.mas_right);
////        make.top.equalTo(self.tableview);
//        make.width.mas_equalTo(SCREENWIDTH);
//        make.top.equalTo(self.tableContainerView);
//        make.bottom.equalTo(self.tableContainerView);
//        
//    }];
}

- (void)onHeaderRefresh:(MJRefreshNormalHeader *)header {
    [self reloadDataList];
    [header endRefreshing];
}


- (void)reloadDataList {
    [self.tableview reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    self.placeholderLabel.hidden = self.chatArray.count;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    [self.navigationController.navigationBar setBackgroundImage:[Tool buttonImageFromColor:[UIColor colorWithRed:44 / 255.0 green:213 / 255.0 blue:184 / 255.0 alpha:1] withImageSize:CGSizeMake(1, 1)] forBarMetrics:UIBarMetricsDefault];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    self.navigationController.navigationBar.shadowImage = nil;
//    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
}

- (void)initializaiton
{
    [super initializaiton];
}

- (void)initView
{
    [super initView];
    
    tableview.backgroundView = nil;
//    tableview.backgroundColor = [UIColor whiteColor];
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [Tool setExtraCellLineHidden:tableview];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self reloadEaseMobConversations];
}

#pragma mark :- 环信代理回调 
- (void)didUpdateConversationList:(NSArray *)aConversationList {
//    [self.chatArray removeAllObjects];
//    [self.chatArray addObjectsFromArray:aConversationList];
    [self reloadEaseMobConversations];
}

- (void)didReceiveMessages:(NSArray *)aMessages {
//    [self.tableview reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
    [self reloadEaseMobConversations];
}


- (void)onSegment:(UISegmentedControl *)segment {
    [self.containerView setContentOffset:CGPointMake(segment.selectedSegmentIndex * SCREENWIDTH, 0) animated:YES];
}

//////EaseUI回调
- (void)messageViewController:(EaseMessageViewController *)viewController didSendMessageModel:(id<IMessageModel>)messageModel {
    [self reloadEaseMobConversations];
}


///刷新环信消息
- (void)reloadEaseMobConversations {
    kWeakSelf;
    dispatch_queue_t loadMessageQueue = dispatch_queue_create("com.sishi.easemob.loadmessage", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(loadMessageQueue, ^{
        NSArray *conversations = [[EMClient sharedClient].chatManager getAllConversations];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.chatArray removeAllObjects];
            [weakSelf.chatArray addObjectsFromArray:conversations];
//            [weakSelf.tableview reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
            [weakSelf reloadDataList];
        });
    });
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tableview) {
        return self.chatArray.count;
    }
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    NSInteger row = indexPath.row;
    if (tableView == self.tableview) {
        static NSString *cellIndentifier = @"HeContestantTableCellIndentifier";
        CGSize cellSize = [tableView rectForRowAtIndexPath:indexPath].size;
        
        HeChatTableCell *cell  = [tableView cellForRowAtIndexPath:indexPath];
        if (!cell) {
            cell = [[HeChatTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier cellSize:cellSize];
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
        }
        
        return cell;
    } else {
        return [tableView dequeueReusableCellWithIdentifier:@"reuseId"];
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.tableview) {
        return 80;
    }
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    NSInteger row = indexPath.row;
//    NSInteger section = indexPath.section;
    if (tableView == self.tableview) {
        EMConversation *conversation = self.chatArray[indexPath.row];
        
        ChatViewController *chatView = [[ChatViewController alloc] initWithConversationChatter:conversation.conversationId conversationType:EMConversationTypeChat];
        chatView.delegate = self;
        chatView.dataSource = self;
        NSString *chatterName = @"";
        chatView.delegate = self;
        if (conversation.latestMessage.direction == EMMessageDirectionSend) {
            chatterName = conversation.latestMessage.to;
        } else {
            chatterName = conversation.latestMessage.from;
        }
        chatView.title = chatterName;
        chatView.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:chatView animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(HeChatTableCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.tableview ) {
        EMConversation *conversation = [self.chatArray objectAtIndex:indexPath.row];
        EMMessage *lastestMessage = conversation.latestMessage;
        EMMessageBody *messageBody = lastestMessage.body;
        EMMessageDirection direction = lastestMessage.direction;
        NSString *otherPeopleName = nil;
        if (direction == EMMessageDirectionSend) {
            otherPeopleName = lastestMessage.to;
        } else {
            otherPeopleName = lastestMessage.from;
        }
        if ([messageBody isKindOfClass:[EMImageMessageBody class]]) {
            cell.contentLabel.text = @"[图片]";
        } else if ([messageBody isKindOfClass:[EMTextMessageBody class]]) {
            EMTextMessageBody *textMessage = (EMTextMessageBody *)messageBody;
            cell.contentLabel.text = textMessage.text;
        } else if ([messageBody isKindOfClass:[EMVoiceMessageBody class]]) {
            cell.contentLabel.text = @"[语音]";
        }
        cell.titleLabel.text = otherPeopleName;
    }
}

#pragma mark :- 环信自定义消息

- (CGFloat)messageViewController:(EaseMessageViewController *)viewController heightForMessageModel:(id<IMessageModel>)messageModel withCellWidth:(CGFloat)cellWidth {
    return 180;
}

//- (id<IMessageModel>)messageViewController:(EaseMessageViewController *)viewController modelForMessage:(EMMessage *)message {
//    return nil;
//}

- (UITableViewCell *)messageViewController:(UITableView *)tableView cellForMessageModel:(id<IMessageModel>)messageModel {
    return [[InvitationSentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseId"];
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
