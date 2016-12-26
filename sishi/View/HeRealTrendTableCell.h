//
//  HeRealTrendTableCell.h
//  sishi
//
//  Created by HeDongMing on 16/8/18.
//  Copyright © 2016年 Channce. All rights reserved.
//

#import "HeBaseTableViewCell.h"
#import "DynamicListModel.h"
#import "ApiUtils.h"

@interface HeRealTrendTableCell : HeBaseTableViewCell
@property(strong,nonatomic)UIView *bgView;
@property(strong,nonatomic)UIImageView *headImage;
@property(strong,nonatomic)UILabel *titleLabel;
@property(strong,nonatomic)UILabel *timeLabel;
@property(strong,nonatomic)UILabel *contentLabel;

/**
 *  单元格Model
 */
@property(nonatomic,strong)TripListModel *model;


@end
