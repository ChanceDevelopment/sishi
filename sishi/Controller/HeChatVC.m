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

@interface HeChatVC ()<UITableViewDelegate,UITableViewDataSource,EMChatManagerDelegate>
@property(strong,nonatomic)IBOutlet UITableView *tableview;
/**
 *  聊天数据源数组
 */
@property(nonatomic,strong)NSMutableArray <EMConversation *>*chatArray;

@end

@implementation HeChatVC
@synthesize tableview;


- (NSMutableArray *)chatArray {
    if (!_chatArray) {
        _chatArray = [NSMutableArray array];
    }
    return _chatArray;
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
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
    [self initializaiton];
    [self initView];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self reloadEaseMobConversations];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)initializaiton
{
    [super initializaiton];
}

- (void)initView
{
    [super initView];
    
    
    tableview.backgroundView = nil;
    tableview.backgroundColor = [UIColor whiteColor];
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [Tool setExtraCellLineHidden:tableview];

    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
}


#pragma mark :- 环信代理回调 
- (void)didUpdateConversationList:(NSArray *)aConversationList {
    [self.chatArray removeAllObjects];
    [self.chatArray addObjectsFromArray:aConversationList];
}

- (void)didReceiveMessages:(NSArray *)aMessages {
//    [self.tableview reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationNone];
    [self reloadEaseMobConversations];
}


///刷新环信消息
- (void)reloadEaseMobConversations {
    kWeakSelf;
    dispatch_queue_t loadMessageQueue = dispatch_queue_create("com.sishi.easemob.loadmessage", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(loadMessageQueue, ^{
        NSArray *conversations = [[EMClient sharedClient].chatManager getAllConversations];
        [weakSelf.chatArray removeAllObjects];
        [weakSelf.chatArray addObjectsFromArray:conversations];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.tableview reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
        });
    });
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.chatArray.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    
    static NSString *cellIndentifier = @"HeContestantTableCellIndentifier";
    CGSize cellSize = [tableView rectForRowAtIndexPath:indexPath].size;
    
    
    HeChatTableCell *cell  = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[HeChatTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier cellSize:cellSize];
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    EMConversation *conversation = self.chatArray[indexPath.row];
    ChatViewController *chatView = [[ChatViewController alloc] initWithConversationChatter:conversation.conversationId conversationType:EMConversationTypeChat];
    NSString *chatterName = @"";
    if (conversation.latestMessage.direction == EMMessageDirectionSend) {
        chatterName = conversation.latestMessage.to;
    } else {
        chatterName = conversation.latestMessage.from;
    }
    chatView.title = chatterName;
    chatView.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:chatView animated:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(HeChatTableCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
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
