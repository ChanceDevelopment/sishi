//
//  LeftController.h
//  DDMenuController
//
//  Created by Devin Doty on 11/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeBaseViewController.h"
#import "HeInfoMenuVC.h"

@interface LeftController : HeBaseViewController
@property(strong,nonatomic) HeInfoMenuVC *hostVC;
@property(nonatomic,strong) UITableView *tableView;

@end
