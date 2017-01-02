//
//  HeContestDetailVC.m
//  beautyContest
//
//  Created by HeDongMing on 16/7/31.
//  Copyright © 2016年 iMac. All rights reserved.
//

#import "HeRealTimeTrendVC.h"
#import "MLLabel+Size.h"
#import "HeBaseTableViewCell.h"
#import "HeRealTrendTableCell.h"
#import "HeRealTimeDetailController.h"
#import "Masonry.h"
#import "MJRefresh.h"
#import "ApiUtils.h"
#import "HeDistributeInviteVC.h"
#import "AskingTableViewCell.h"
#import "TripOnGoingController.h"

#define TextLineHeight 1.2f

@interface HeRealTimeTrendVC ()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL requestReply; //是否已经完成
}
@property(strong,nonatomic)IBOutlet UITableView *tableview;
@property(strong,nonatomic)UIView *sectionHeaderView;
@property(strong,nonatomic)NSMutableArray *dataSource;
@property(strong,nonatomic)EGORefreshTableHeaderView *refreshHeaderView;
@property(strong,nonatomic)EGORefreshTableFootView *refreshFooterView;
@property(assign,nonatomic)NSInteger pageNo;
/**
 *  占位Label
 */
@property(nonatomic,strong)UILabel *placeholderLabel;


/**
 *  发布 按钮
 */
@property(nonatomic,strong)IBOutlet UIButton *releaseBtn;

/**
 *  过滤 按钮
 */
@property(nonatomic,strong) IBOutlet UIButton *filterBtn;

@end

@implementation HeRealTimeTrendVC
@synthesize tableview;
@synthesize sectionHeaderView;
@synthesize dataSource;
@synthesize refreshFooterView;
@synthesize refreshHeaderView;
@synthesize pageNo;


- (UILabel *)placeholderLabel {
    if (!_placeholderLabel) {
        _placeholderLabel = [[UILabel alloc]init];
        _placeholderLabel.hidden = YES;
//        NSString *judge = [[Tool judge] isEqualToString:@"0"] ? @"车主" : @"用户";
        _placeholderLabel.text = @"暂无新动态";
        _placeholderLabel.font = [UIFont systemFontOfSize:28];
        _placeholderLabel.textColor = [UIColor colorWithWhite:0.5 alpha:1];
        _placeholderLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _placeholderLabel;
}


- (NSMutableArray *)dataSource {
    if (!dataSource) {
        dataSource = [NSMutableArray array];
    }
    return dataSource;
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
        label.text = @"我的排名";
        [label sizeToFit];
        
        self.title = @"我的排名";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initializaiton];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self initView];
    
    self.filterBtn.layer.cornerRadius = 30;
    self.filterBtn.layer.shadowOffset = CGSizeMake(2, 2);
    
//    self.filterBtn.layer.shadowRadius = 30.0;
    self.filterBtn.layer.shadowOpacity = 1.0;
    self.filterBtn.layer.shadowColor = [UIColor colorWithWhite:0.4 alpha:1].CGColor;
    
    self.releaseBtn.layer.cornerRadius = 30;
    self.releaseBtn.layer.shadowOffset = CGSizeMake(2, 2);
    self.releaseBtn.layer.shadowColor = [UIColor colorWithWhite:0.4 alpha:1].CGColor;
    self.releaseBtn.layer.shadowOpacity = 1.0;
//    self.releaseBtn.clipsToBounds = YES;
//    self.releaseBtn.imageEdgeInsets = UIEdgeInsetsMake(30, 30, 30, 30);
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.tableview addSubview:self.placeholderLabel];
    [self.placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.tableview);
    }];
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
//    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(onHeaderRefresh:)];
    [tableview.mj_header beginRefreshing];
    
    [Tool setExtraCellLineHidden:tableview];
    [self pullUpUpdate];
    
    if ([self.tableview respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableview setSeparatorInset:UIEdgeInsetsZero];
    }
    
//    [self.tableview registerClass:[HeRealTrendTableCell class] forCellReuseIdentifier:@"HeContestantTableCellIndentifier"];
    [self.tableview registerNib:[UINib nibWithNibName:@"AskingTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"AskingTableViewCell"];
    
//    sectionHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 40)];
//    sectionHeaderView.backgroundColor = [UIColor colorWithWhite:237.0 / 255.0 alpha:1.0];
//    sectionHeaderView.userInteractionEnabled = YES;
    
    NSArray *buttonArray = @[@"我的男神",@"我的女神"];
    for (NSInteger index = 0; index < [buttonArray count]; index++) {
        CGFloat buttonW = SCREENWIDTH / [buttonArray count];
        CGFloat buttonH = sectionHeaderView.frame.size.height;
        CGFloat buttonX = index * buttonW;
        CGFloat buttonY = 0;
        CGRect buttonFrame = CGRectMake(buttonX , buttonY, buttonW, buttonH);
        UIButton *button = [self buttonWithTitle:buttonArray[index] frame:buttonFrame];
        button.tag = index + 100;
        if (index == 0) {
            button.selected = YES;
        }
        [sectionHeaderView addSubview:button];
    }
    
}

- (void)reloadDataList {
    [self.tableview reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    self.placeholderLabel.hidden = self.dataSource.count;
}


- (void)onHeaderRefresh:(MJRefreshNormalHeader *)header {
    //72ab4fed1ebb48f8a0b36ec82762fad4
    //72ab4fed1ebb48f8a0b36ec82762fad4
    [ApiUtils queryRealtimeTripInfoWithCompleteHandler:^(NSArray<TripListModel *> *tripList) {
        [self.dataSource removeAllObjects];
        [self.dataSource addObjectsFromArray:tripList];
//        [tableview reloadData];
//        [header endRefreshing];
        [ApiUtils queryAllTripCanTakeWithFilterType:@"0"//当请求完成已经邀约的数据之后再开始请求可邀约的数据
                                           identity:[Tool judge]
                                     onResponseInfo:^(NSArray<TripListModel *> *tripListModel) {
                                         //                                     [self.dataSource removeAllObjects];
                                         [self.dataSource addObjectsFromArray:tripListModel];
                                         [self reloadDataList];
                                         [header endRefreshing];
                                     } errorHandler:^(NSString *responseErrorInfo) {
                                         [self showHint:responseErrorInfo];
                                         [header endRefreshing];
                                     }];
        
    } errorHandler:^(NSString *responseErrorInfo) {
        [self showHint:responseErrorInfo];
        [header endRefreshing];
    }];
    
   
}

- (UIButton *)buttonWithTitle:(NSString *)buttonTitle frame:(CGRect)buttonFrame
{
    UIButton *button = [[UIButton alloc] initWithFrame:buttonFrame];
    [button setTitle:buttonTitle forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithWhite:143.0 / 255.0 alpha:1.0] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(filterButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setBackgroundImage:[Tool buttonImageFromColor:[UIColor whiteColor] withImageSize:button.frame.size] forState:UIControlStateSelected];
    [button setBackgroundImage:[Tool buttonImageFromColor:sectionHeaderView.backgroundColor withImageSize:button.frame.size] forState:UIControlStateNormal];
    
    return button;
}

- (void)filterButtonClick:(UIButton *)button
{
    if ((requestReply == NO && button.tag == 100) || (requestReply == YES && button.tag == 101)) {
        return;
    }
    NSArray *subViewsArray = sectionHeaderView.subviews;
    for (UIView *subview in subViewsArray) {
        if ([subview isKindOfClass:[UIButton class]]) {
            ((UIButton *)subview).selected = !((UIButton *)subview).selected;
        }
    }
    requestReply = YES;
    if (button.tag == 100) {
        requestReply = NO;
    }
    [self loadRankingDataShow:YES];
}

- (void)loadRankingDataShow:(BOOL)show
{
    
}

- (void)addFooterView
{
    if (tableview.contentSize.height >= SCREENHEIGH) {
        [self pullDownUpdate];
    }
}

-(void)pullUpUpdate
{
//    self.refreshHeaderView = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableview.bounds.size.height, SCREENWIDTH, self.tableview.bounds.size.height)];
//    refreshHeaderView.delegate = self;
//    [tableview addSubview:refreshHeaderView];
//    [refreshHeaderView refreshLastUpdatedDate];
}
-(void)pullDownUpdate
{
    if (refreshFooterView == nil) {
        self.refreshFooterView = [[EGORefreshTableFootView alloc] init];
    }
    refreshFooterView.frame = CGRectMake(0, tableview.contentSize.height, SCREENWIDTH, 650);
    refreshFooterView.delegate = self;
    [tableview addSubview:refreshFooterView];
    [refreshFooterView refreshLastUpdatedDate];
}

#pragma mark :- 发布
- (IBAction)onReleaseAction:(UIButton *)sender {
    HeDistributeInviteVC *releasePage = [[HeDistributeInviteVC alloc]initWithNibName:@"HeDistributeInviteVC" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:releasePage animated:YES];
}
- (IBAction)onFilterAction:(UIButton *)sender {
    
}

#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource{
    _reloading = YES;
    //刷新列表
    [self loadRankingDataShow:NO];
    [self updateDataSource];
}

-(void)updateDataSource
{
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:1.0];//视图的数据下载完毕之后，开始刷新数据
}

- (void)doneLoadingTableViewData{
    
    //  model should call this when its done loading
    _reloading = NO;
    switch (updateOption) {
        case 1:
            [refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:tableview];
            break;
        case 2:
            [refreshFooterView egoRefreshScrollViewDataSourceDidFinishedLoading:tableview];
            break;
        default:
            break;
    }
}

#pragma mark -
#pragma mark UIScrollViewDelegate Methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //刚开始拖拽的时候触发下载数据
    [refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    [refreshFooterView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    [refreshFooterView egoRefreshScrollViewDidEndDragging:scrollView];
}

/*******************Foot*********************/
#pragma mark -
#pragma mark EGORefreshTableFootDelegate Methods
- (void)egoRefreshTableFootDidTriggerRefresh:(EGORefreshTableFootView*)view
{
    updateOption = 2;//加载历史标志
    pageNo++;
    
    @try {
        
    }
    @catch (NSException *exception) {
        //抛出异常不应当处理dateline
    }
    @finally {
        [self reloadTableViewDataSource];//触发刷新，开始下载数据
    }
}
- (BOOL)egoRefreshTableFootDataSourceIsLoading:(EGORefreshTableFootView*)view{
    
    return _reloading; // should return if data source model is reloading
    
}
- (NSDate*)egoRefreshTableFootDataSourceLastUpdated:(EGORefreshTableFootView*)view{
    
    return [NSDate date]; // should return date data source was last changed
    
}

/*******************Header*********************/
#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view
{
    updateOption = 1;//刷新加载标志
    pageNo = 1;
    @try {
        
        
    }
    @catch (NSException *exception) {
        //抛出异常不应当处理dateline
    }
    @finally {
        [self reloadTableViewDataSource];//触发刷新，开始下载数据
    }
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view
{
    return _reloading; // should return if data source model is reloading
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view
{
    return [NSDate date]; // should return date data source was last changed
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    
    static NSString *cellIndentifier = @"HeContestantTableCellIndentifier";
    static NSString *takeUserCellIdentifier = @"AskingTableViewCell";
    CGSize cellSize = [tableView rectForRowAtIndexPath:indexPath].size;
    TripListModel *tripList = self.dataSource[row];
//    NSString *reuseId = cellIndentifier;
    if (!tripList.isWaitOtherTake) {
        HeRealTrendTableCell *cell = [tableview dequeueReusableCellWithIdentifier:cellIndentifier];
        if (!cell) {
            cell = [[HeRealTrendTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier cellSize:cellSize];
        }
        return  cell;
    } else {
        return [tableview dequeueReusableCellWithIdentifier:takeUserCellIdentifier forIndexPath:indexPath];
    }
    
//    UITableViewCell *cell  = [tableView cellForRowAtIndexPath:indexPath];
//    if (!cell) {
//        if (!tripList.isWaitOtherTake) {
//            cell = [[HeRealTrendTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId cellSize:cellSize];
//        } else {
//            cell = [[AskingTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
//        }
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    }
//    
//    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TripListModel *tripModel = self.dataSource[indexPath.row];
    if (tripModel.isWaitOtherTake) {
        return tripModel.itemHeight;
    }
    return 120;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    //HeRealTrendTableCell
    kWeakSelf;
    if ([cell isKindOfClass:[HeRealTrendTableCell class] ]) {
        HeRealTrendTableCell *realTrendCell = (HeRealTrendTableCell *)cell;
        realTrendCell.model = self.dataSource[indexPath.row];
        realTrendCell.onLongPress = ^(TripListModel *tripModel) {
            //长按操作
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否现在开始行程?" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消行程" style:UIAlertActionStyleDefault handler:nil];
            UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"进入行程" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
               //进入行程页面
                if (tripModel.isOnGoing) {
                    TripOnGoingController *onGoingController = [[TripOnGoingController alloc]initWithNibName:@"TripOnGoingController" bundle:[NSBundle mainBundle]];
                    onGoingController.tripId = tripModel.carOwnerId;
                    [self.navigationController pushViewController:onGoingController animated:YES];
                    return ;
                }
                
                [ApiUtils startTripWithTripId:tripModel.carOwnerId onCompleteHandler:^{
                        TripOnGoingController *onGoingController = [[TripOnGoingController alloc]initWithNibName:@"TripOnGoingController" bundle:[NSBundle mainBundle]];
                    onGoingController.tripId = tripModel.carOwnerId;
                    tripModel.isOnGoing = YES;
                        [self.navigationController pushViewController:onGoingController animated:YES];
                    //进入行程详情
                } errorHandler:^(NSString *responseErrorInfo) {
                    [weakSelf showHint:responseErrorInfo];
                }];
            }];
            [alertController addAction:cancelAction];
            [alertController addAction:confirmAction];
            [weakSelf presentViewController:alertController animated:YES completion:nil];
        };
    } else if ([cell isKindOfClass:[AskingTableViewCell class]]) {
        AskingTableViewCell *askingCell = (AskingTableViewCell *)cell;
        askingCell.tripModel = self.dataSource[indexPath.row];
        askingCell.onContact = ^(TripListModel *model) {
//            [ApiUtils sendAskingFor:model.userId
//                             tripId:model.carOwnerId
//                    withCompleteHandler:^{
//                        [weakSelf showHint:@"邀约成功"];
//            } errorHandler:^(NSString *responseErrorInfo) {
//                [weakSelf showHint:responseErrorInfo];
//            }];
            [ApiUtils acceptTripWithTripId:model.carOwnerId onCompleteHandler:^{
                [weakSelf showHint:@"接取成功"];
            } errorHandler:^(NSString *responseErrorInfo) {
                [weakSelf showHint:responseErrorInfo];
            }];
        };
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    
    TripListModel *tripModel = self.dataSource[row];
        HeRealTimeDetailController *detailController = [[HeRealTimeDetailController alloc] initWithNibName:@"HeRealTimeDetailController" bundle:[NSBundle mainBundle]];
        detailController.hidesBottomBarWhenPushed = YES;
    detailController.tripId = tripModel.carOwnerId;
        detailController.title = @"详情内容";
        [self.navigationController pushViewController:detailController animated:YES];
    
    //测试内容
//    TripOnGoingController *onGoingController = [[TripOnGoingController alloc]initWithNibName:@"TripOnGoingController" bundle:[NSBundle mainBundle]];
//    [self.navigationController pushViewController:onGoingController animated:YES];
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
