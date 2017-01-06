//
//  FocusListViewController.m
//  sishi
//
//  Created by likeSo on 2016/12/16.
//  Copyright © 2016年 Channce. All rights reserved.
//

#import "FocusListViewController.h"
#import "FocusTableViewCell.h"
#import "MJRefresh.h"
#import "ApiUtils.h"
#import "UIViewController+HUD.h"
#import "Masonry.h"

@interface FocusListViewController ()
/**
 *  关注用户列表
 */
@property(nonatomic,copy)NSMutableArray <UserFollowListModel *>*focusUserList;

/**
 *  占位Label
 */
@property(nonatomic,strong)UILabel *placeholderLabel;

/**
 *  当前分页页数
 */
@property(nonatomic,assign)NSInteger pageIndex;
@end

@implementation FocusListViewController

- (NSMutableArray<UserFollowListModel *> *)focusUserList  {
    if (!_focusUserList) {
        _focusUserList = [NSMutableArray array];
    }
    return _focusUserList;
}

- (UILabel *)placeholderLabel {
    if (!_placeholderLabel) {
        _placeholderLabel = [[UILabel alloc]init];
        _placeholderLabel.hidden = YES;
        _placeholderLabel.text = @"您还没有已关注的用户";
        _placeholderLabel.font = [UIFont systemFontOfSize:28];
        _placeholderLabel.textColor = [UIColor colorWithWhite:0.5 alpha:1];
        _placeholderLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _placeholderLabel;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageIndex = 0;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    self.navigationItem.title = @"我关注的";
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.tableView registerNib:[UINib nibWithNibName:@"FocusTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"FocusTableViewCell"];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(onHeaderRefresh:)];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
    [self.tableView addSubview:self.placeholderLabel];
    [self.placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.tableView);
    }];
    [self.tableView.mj_header beginRefreshing];
}

- (void)reloadDataList {
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    self.placeholderLabel.hidden = self.focusUserList.count;
}

- (void)onHeaderRefresh:(MJRefreshNormalHeader *)header {
    [ApiUtils queryMYFocusListWithResponseList:^(NSArray<UserFollowListModel *> *focusList) {
        [header endRefreshing];
        [self.focusUserList removeAllObjects];
        [self.focusUserList addObjectsFromArray:focusList];
        [self reloadDataList];
    } onError:^(NSString *responseErrorInfo) {
        [self showHint:responseErrorInfo];
        [header endRefreshing];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.focusUserList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 85;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FocusTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FocusTableViewCell" forIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(FocusTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    UserFollowListModel *model = self.focusUserList[indexPath.row];
    cell.model = model;
    kWeakSelf;
    cell.onContact = ^(UserFollowListModel *userModel) {
        [MBProgressHUD showHUDAddedTo:weakSelf.view.window animated:YES];
        [ApiUtils sendAskingFor:userModel.userId tripId:@"" withCompleteHandler:^{
            [MBProgressHUD hideHUDForView:weakSelf.view.window animated:YES];
            [weakSelf showHint:@"成功邀约"];
        } errorHandler:^(NSString *responseErrorInfo) {
            [MBProgressHUD hideHUDForView:weakSelf.view.window animated:YES];
            [self showHint:responseErrorInfo];
        }];
    };
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HeUserVC *userVC = [[HeUserVC alloc]initWithNibName:@"HeUserVC" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:userVC animated:YES];
    userVC.uid = self.focusUserList[indexPath.row].userId;
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
