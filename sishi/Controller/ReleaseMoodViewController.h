//
//  ReleaseMoodViewController.h
//  sishi
//
//  Created by likeSo on 2016/12/26.
//  Copyright © 2016年 Channce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TripDetailModel.h"

/**
 发表 心情 界面
 */
@interface ReleaseMoodViewController : UIViewController
/**
 *  行程Id
 */
@property(nonatomic,copy)NSString *tripId;

/**
 *  详情界面model
 */
@property(nonatomic,strong)TripDetailModel *tripModel;

@end
