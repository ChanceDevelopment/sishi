//
//  TripEditController.h
//  sishi
//
//  Created by likeSo on 2016/12/15.
//  Copyright © 2016年 Channce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TripDetailModel.h"

typedef void(^TripEditControllerUpdatedTripInfoCallback)();

/// 行程编辑页面
@interface TripEditController : UIViewController
/**
 *  行程详情Model
 */
@property(nonatomic,strong)TripDetailModel *detailModel;

/**
 *  更新当前行程信息时回调
 */
@property(nonatomic,copy)TripEditControllerUpdatedTripInfoCallback  onUpdateTripInfo;

@end
