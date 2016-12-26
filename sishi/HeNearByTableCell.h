//
//  HeNearByTableCell.h
//  sishi
//
//  Created by HeDongMing on 16/8/17.
//  Copyright © 2016年 Channce. All rights reserved.
//

#import "HeBaseTableViewCell.h"
#import "ImageBannerView.h"
#import "NearbyUserListModel.h"

@class HeNearByTableCell;
typedef void(^NearbyTableViewCellCallBack)(HeNearByTableCell *targetCell);


@interface HeNearByTableCell : HeBaseTableViewCell
@property(strong,nonatomic)UILabel *nameLabel;
@property(strong,nonatomic)ImageBannerView *bgImage;
@property(strong,nonatomic)UIImageView *headImage;
@property(strong,nonatomic)UILabel *distanceLabel;
@property(strong,nonatomic)UILabel *tipLabel;
/**
 *  约Ta 按钮
 */
@property(nonatomic,strong)UIButton *contactButton;

/**
 *  点赞按钮
 */
@property(nonatomic,strong)UIButton *upvoteButton;

/**
 *  单元格Model
 */
@property(nonatomic,strong)NearbyUserListModel *model;


/**
 *  点击 "约他" 按钮 回调
 */
@property(nonatomic,copy)NearbyTableViewCellCallBack onContactAction;

@end
