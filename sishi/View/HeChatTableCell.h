//
//  HeChatTableCell.h
//  sishi
//
//  Created by HeDongMing on 16/8/18.
//  Copyright © 2016年 Channce. All rights reserved.
//

#import "HeBaseTableViewCell.h"

@interface HeChatTableCell : HeBaseTableViewCell
@property(strong,nonatomic)UIImageView *headImage;
@property(strong,nonatomic)UILabel *titleLabel;
@property(strong,nonatomic)UILabel *contentLabel;
/**
 *  未读消息数目
 */
@property(nonatomic,assign)NSUInteger unReadMessageCount;
@end
