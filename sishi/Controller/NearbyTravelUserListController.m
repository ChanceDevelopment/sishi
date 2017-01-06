//
//  NearbyTravelUserListController.m
//  sishi
//
//  Created by likeSo on 2016/12/29.
//  Copyright © 2016年 Channce. All rights reserved.
//

#import "NearbyTravelUserListController.h"
#import "MJRefresh.h"
#import "ApiUtils.h"
#import "Masonry.h"

@interface NearbyTravelUserListController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

/**
 *  用户列表
 */
@property(nonatomic,strong)NSMutableArray <UserFollowListModel *>* users;

/**
 *  current page index
 */
@property(nonatomic,assign)NSUInteger startIndex;

/**
 *  占位Label
 */
@property(nonatomic,strong)UILabel *placeholderLabel;


@end

@implementation NearbyTravelUserListController

- (NSMutableArray<UserFollowListModel *> *)users {
    if (!_users) {
        self.users = [NSMutableArray array];
    }
    return _users;
}

- (UILabel *)placeholderLabel {
    if (!_placeholderLabel) {
        _placeholderLabel = [[UILabel alloc]init];
        _placeholderLabel.hidden = YES;
        _placeholderLabel.text = @"暂无附近用户";
        _placeholderLabel.font = [UIFont systemFontOfSize:28];
        _placeholderLabel.textColor = [UIColor colorWithWhite:0.5 alpha:1];
        _placeholderLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _placeholderLabel;
}

//- (void)setNearbyUserList:(NSArray<UserFollowListModel *> *)nearbyUserList {
//    _nearbyUserList = nearbyUserList;
//    [self.users removeAllObjects];
//    [self.users addObjectsFromArray:nearbyUserList];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setupView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.rdv_tabBarController setTabBarHidden:YES animated:YES];
    self.navigationController.navigationBar.translucent = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.rdv_tabBarController setTabBarHidden:NO animated:YES];
}

- (void)setupView {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"附近等待出行用户";
    self.startIndex = 0;
    [self.tableView registerNib:[UINib nibWithNibName:@"FocusTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"FocusTableViewCell"];
    self.tableView.mj_header = ({
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(onHeaderRefresh:)];
        header.automaticallyChangeAlpha = YES;
        header;
    });
    self.tableView.mj_footer = ({
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(onFooterLoad:)];
        footer.automaticallyChangeAlpha = YES;
        footer;
    });
    self.tableView.tableFooterView = [UIView new];
    [self.tableView.mj_header beginRefreshing];
    
    [self.tableView addSubview:self.placeholderLabel];
    [self.placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.tableView);
    }];
    
}


- (void)reloadDataList {
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    self.placeholderLabel.hidden = self.users.count;
}

- (void)onHeaderRefresh:(MJRefreshNormalHeader *)header {
    CGFloat longitude = [[NSUserDefaults standardUserDefaults] doubleForKey:kDefaultsUserLocationlongitude];
    CGFloat latitude = [[NSUserDefaults standardUserDefaults] doubleForKey:kDefaultsUserLocationLatitude];
    NSString *judge = [[Tool judge] isEqualToString:@"0"] ? @"1" : @"0";
    [ApiUtils filterUserWithTripId:@"" carUserLike:self.hobbys gender:@"0" userJudge:judge longitude:longitude latitude:latitude startIndex:0 onResponseList:^(NSArray<UserFollowListModel *> *userModelList) {
        self.startIndex = 0;
        [self.users removeAllObjects];
        [self.users addObjectsFromArray:userModelList];
        [self reloadDataList];
        [header endRefreshing];
    } errorHandler:^(NSString *responseErrorInfo) {
        [self showHint:responseErrorInfo];
        [header endRefreshing];
    }];
}

- (void)onFooterLoad:(MJRefreshAutoNormalFooter *)footer {//copy & paste
    CGFloat longitude = [[NSUserDefaults standardUserDefaults] doubleForKey:kDefaultsUserLocationlongitude];
    CGFloat latitude = [[NSUserDefaults standardUserDefaults] doubleForKey:kDefaultsUserLocationLatitude];
    NSString *judge = [[Tool judge] isEqualToString:@"0"] ? @"1" : @"0";
    [ApiUtils filterUserWithTripId:@"" carUserLike:self.hobbys gender:@"0" userJudge:judge longitude:longitude latitude:latitude startIndex:self.startIndex onResponseList:^(NSArray<UserFollowListModel *> *userModelList) {
        [footer endRefreshing];
        [self.users removeAllObjects];
        self.startIndex += 1;
        [self.users addObjectsFromArray:userModelList];
        [self reloadDataList];
    } errorHandler:^(NSString *responseErrorInfo) {
        [self showHint:responseErrorInfo];
        [footer endRefreshing];
    }];
}

#pragma mark :- UITableViewDelegate & dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.users.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 85;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:@"FocusTableViewCell" forIndexPath:indexPath];
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(FocusTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.model = self.users[indexPath.row];
    kWeakSelf;
    cell.onContact = ^(UserFollowListModel *model) {
        NSLog(@"%@",model);
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onBeginTrip:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
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
