//
//  ChatInvitationMessageModel.h
//  sishi
//
//  Created by likeSo on 2017/1/4.
//  Copyright © 2017年 Channce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EaseUI.h"


/**
 环信 邀约消息 自定义Model
 */
@interface ChatInvitationMessageModel : EaseMessageModel
/**
 *  预约时间 文本描述
 */
@property(nonatomic,strong)NSString *invitationDate;

/**
 *  目的地
 */
@property(nonatomic,strong)NSString *stopPlace;

/**
 *  上车位置
 */
@property(nonatomic,strong)NSString *startPlace;

/**
 *  备注信息
 */
@property(nonatomic,strong)NSString *note;

/**
 *  行程Id
 */
@property(nonatomic,strong)NSString *tripId;

/**
 *  是否是我发送的邀约信息
 */
@property(nonatomic,assign)BOOL isSentFromMe;

/**
 *  消息发布人的 id
 */
@property(nonatomic,strong)NSString *setterId;

/**
 *  消息发布人 昵称
 */
@property(nonatomic,strong)NSString *setterNickName;

/**
 *  消息发布人 头像
 */
@property(nonatomic,strong)NSString *setterHeaderImage;



/**
 *  消息接收者 id
 */
@property(nonatomic,strong)NSString *getterId;

/**
 *  消息接收者 昵称
 */
@property(nonatomic,strong)NSString *getterNickName;

/**
 *  消息接收者 头像
 */
@property(nonatomic,strong)NSString *getterHeaderImage;


- (instancetype)initWithMessage:(EMMessage *)message;

@end
