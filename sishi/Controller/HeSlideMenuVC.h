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

@interface HeSlideMenuVC : HeBaseViewController
@property(strong,nonatomic) HeInfoMenuVC *hostVC;
@property(nonatomic,strong) IBOutlet UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *channelArray;

@end
