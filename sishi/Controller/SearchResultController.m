//
//  SearchResultController.m
//  sishi
//
//  Created by likeSo on 2016/12/19.
//  Copyright © 2016年 Channce. All rights reserved.
//

#import "SearchResultController.h"
#import "MJRefresh.h"
#import "ApiUtils.h"

@interface SearchResultController ()
/**
 *  搜索结果数据源
 */
@property(nonatomic,strong)NSMutableArray *searchResultList;

/**
 *  当前显示页数
 */
@property(nonatomic,assign)NSInteger pageIndex;

@end

@implementation SearchResultController

- (NSMutableArray *)searchResultList {
    if (!_searchResultList) {
        _searchResultList = [NSMutableArray array];
    }
    return _searchResultList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"搜索结果";
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(onHeaderRefresh:)];
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)onHeaderRefresh:(MJRefreshNormalHeader *)header {
    
    NSString *judge = [[Tool judge] isEqualToString:@"0"] ? @"1" : @"0";
    CGFloat longitude = [[NSUserDefaults standardUserDefaults]doubleForKey:kDefaultsUserLocationlongitude];
    CGFloat latitude = [[NSUserDefaults standardUserDefaults] doubleForKey:kDefaultsUserLocationLatitude];
    [ApiUtils filterUserWithTripId:@"" carUserLike:self.hobbyList gender:@"0" userJudge:judge longitude:longitude latitude:latitude startIndex:0 onResponseList:^(NSArray *responseList) {
        
    } errorHandler:^(NSString *responseErrorInfo) {
        
    }];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return self.searchResultList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    
    // Configure the cell...
    
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
