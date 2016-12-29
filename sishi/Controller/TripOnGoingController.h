//
//  TripOnGoingController.h
//  sishi
//
//  Created by likeSo on 2016/12/28.
//  Copyright © 2016年 Channce. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 行程进行中地图页面
 */
@interface TripOnGoingController : UIViewController
/**
 *  行程Id
 */
@property(nonatomic,strong)NSString *tripId;

/**
 *  另一个用户的Id,如果当前是车主则存储乘客Id,反之则存储车主Id
 */
@property(nonatomic,strong)NSString *associateId;


@end
