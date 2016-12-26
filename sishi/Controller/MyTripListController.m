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

@interface MyTripListController ()
/**
 *  当前页面数据源
 */
@property(nonatomic,copy)NSMutableArray *dataList;
@end

@implementation MyTripListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
//    [self.tableView registerClass:[HeRealTrendTableCell class] forCellReuseIdentifier:@"HeRealTrendTableCell"];
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.navigationItem.title = @"我的行程列表";
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
}

- (void)onHeaderRefresh:(MJRefreshNormalHeader *)header {
    
    [ApiUtils queryTripListWithUser:[Tool uid] carOwnerIsend:@"4" onComplete:^(NSArray<TripListModel *> *response) {
        [header endRefreshing];
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
