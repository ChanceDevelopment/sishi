//
//  HeNearByTableCell.h
//  sishi
//
//  Created by HeDongMing on 16/8/17.
//  Copyright © 2016年 Channce. All rights reserved.
//

#import "HeBaseTableViewCell.h"
#import "ImageBannerView.h"

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



@end
