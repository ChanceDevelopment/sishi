//
//  MyTripListController.m
//  sishi
//
//  Created by likeSo on 2016/12/16.
//  Copyright © 2016年 Channce. All rights reserved.
//

#import "MyTripListController.h"
#import "HeRealTrendTableCell.h"
#import "ApiUtils.h"
#import "MJRefresh.h"
#import "Masonry.h"
#import "HeRealTimeDetailController.h"

@interface MyTripListController ()
/**
 *  当前页面数据源
 */
@property(nonatomic,copy)NSMutableArray <TripListModel *>*dataList;

/**
 *  占位Label
 */
@property(nonatomic,strong)UILabel *placeholderLabel;

@end

@implementation MyTripListController


- (NSMutableArray<TripListModel *> *)dataList {
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}

- (UILabel *)placeholderLabel {
    if (!_placeholderLabel) {
        _placeholderLabel = [[UILabel alloc]init];
        _placeholderLabel.hidden = YES;
        _placeholderLabel.text = @"当前暂无行程";
        _placeholderLabel.font = [UIFont systemFontOfSize:28];
        _placeholderLabel.textColor = [UIColor colorWithWhite:0.5 alpha:1];
        _placeholderLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _placeholderLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
//    [self.tableView registerClass:[HeRealTrendTableCell class] forCellReuseIdentifier:@"HeRealTrendTableCell"];
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.navigationItem.title = @"我的行程列表";
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(onHeaderRefresh:)];
    self.tableView.mj_footer = ({
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(onFooterLoadMore:)];
        footer.automaticallyHidden = YES;
        footer.automaticallyChangeAlpha = YES;
        footer;
    });
    
    [self.tableView addSubview:self.placeholderLabel];
    [self.placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.tableView);
    }];
    [self.tableView.mj_header beginRefreshing];
}

- (void)reloadDataList {
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    self.placeholderLabel.hidden = self.dataList.count;
}

- (void)onHeaderRefresh:(MJRefreshNormalHeader *)header {
    
    [ApiUtils queryRealtimeTripInfoWithCompleteHandler:^(NSArray<TripListModel *> *tripList) {
        [header endRefreshing];
        [self.dataList removeAllObjects];
        [self.dataList addObjectsFromArray:tripList];
        [self reloadDataList];
    } errorHandler:^(NSString *responseErrorInfo) {
        [header endRefreshing];
        [self showHint:responseErrorInfo];
    }];
}

- (void)onFooterLoadMore:(MJRefreshAutoNormalFooter *)footer {
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.rdv_tabBarController setTabBarHidden:NO animated:YES];
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HeRealTrendTableCell"];
    if (!cell) {
        cell = [[HeRealTrendTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HeRealTrendTableCell" cellSize:CGSizeMake(SCREENWIDTH, 120)];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(HeRealTrendTableCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    TripListModel *tripModel = self.dataList[indexPath.row];
    cell.model = tripModel;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    HeRealTimeDetailController
    TripListModel *tripModel = self.dataList[indexPath.row];
    HeRealTimeDetailController *detailController = [[HeRealTimeDetailController alloc] initWithNibName:@"HeRealTimeDetailController" bundle:[NSBundle mainBundle]];
    detailController.tripId = tripModel.carOwnerId;
    detailController.title = @"详情内容";
    detailController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detailController animated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
