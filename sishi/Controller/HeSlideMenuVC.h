//
//  HeSlideMenuVC.h
//  carTune
//
//  Created by Tony on 16/6/28.
//  Copyright © 2016年 Jitsun. All rights reserved.
//

#import "HeBaseViewController.h"
#import "HeBaseViewController.h"
#import "HeInfoMenuVC.h"
#import "CustomNavigationController.h"

@protocol SelectIndexPathProtocol <NSObject>

- (void)selectAtIndex:(NSIndexPath *)path animation:(BOOL)animation;

@end

@interface HeSlideMenuVC : HeBaseViewController
@property(strong,nonatomic) HeInfoMenuVC *hostVC;
@property(nonatomic,strong) IBOutlet UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *channelArray;
@property(nonatomic,assign)id<SelectIndexPathProtocol>selectIndexDelegate;
@property(strong,nonatomic) CustomNavigationController *customnav;

@end
