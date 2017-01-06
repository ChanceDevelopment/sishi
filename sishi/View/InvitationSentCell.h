//
//  InvitationSentCell.h
//  sishi
//
//  Created by likeSo on 2017/1/3.
//  Copyright © 2017年 Channce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatInvitationMessageModel.h"
#import "EaseUI.h"


///邀约 单元格 我发送的
@interface InvitationSentCell : UITableViewCell


/**
 *  聊天Model
 */
@property(nonatomic,strong)ChatInvitationMessageModel *chatModel;

@end
