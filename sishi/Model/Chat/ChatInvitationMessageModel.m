//
//  ChatInvitationMessageModel.m
//  sishi
//
//  Created by likeSo on 2017/1/4.
//  Copyright © 2017年 Channce. All rights reserved.
//

#import "ChatInvitationMessageModel.h"

@implementation ChatInvitationMessageModel


- (instancetype)initWithMessage:(EMMessage *)message {
    if (self = [super initWithMessage:message]) {
    }
    return self;
}

- (BOOL)isSentFromMe {
    NSString *myUid = [Tool uid];
    return [self.setterId isEqualToString:myUid];
}

- (void)setInvitationDate:(NSString *)invitationDate {
    _invitationDate = [NSString stringWithFormat:@"预约时间 : %@",invitationDate];
}

- (void)setStopPlace:(NSString *)stopPlace {
    _stopPlace = [NSString stringWithFormat:@"目的地 : %@",stopPlace];
}

- (void)setStartPlace:(NSString *)startPlace {
    _startPlace = [NSString stringWithFormat:@"上车位置 : %@",startPlace];
}

- (void)setNote:(NSString *)note {
    _note = [NSString stringWithFormat:@"备注 : %@",note];
}


- (CGFloat)cellHeight {
    
    CGFloat bgWidth = SCREENWIDTH - 45 - 15 - 5 - 25;//背景View的宽度
    
    CGFloat itemHeight = 0.0;//头像顶部的距离
    
    CGFloat verticalSpacing = 10 + 8 /*邀约顶部距离*/ + 5 /*预约时间*/ + 5 /*目的地*/ + 5 /*上车位置*/ + 5 /*备注内容*/ + 5 + 25 + 10/*bgView底部距离单元格底部距离*/;//所有控件顶部以及底部的间距
    
    NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:13],NSFontAttributeName, nil];
    
    CGFloat invitationTextHeight = [@"我向您发起一条邀约" boundingRectWithSize:CGSizeMake(bgWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont  systemFontOfSize:14]} context:nil].size.height;//邀约 高度
    
    CGFloat dateTextHeight = [self.invitationDate boundingRectWithSize:CGSizeMake(bgWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:textAttributes context:nil].size.height;//邀约时间
    
    CGFloat destinationTextHeight = [self.stopPlace boundingRectWithSize:CGSizeMake(bgWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:textAttributes context:nil].size.height;//目的地
    
    CGFloat startPlaceTextHeight = [self.startPlace boundingRectWithSize:CGSizeMake(bgWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:textAttributes context:nil].size.height;//上车位置
    
    CGFloat noteTextHeight = [self.note boundingRectWithSize:CGSizeMake(bgWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:textAttributes context:nil].size.height;
    itemHeight = verticalSpacing + invitationTextHeight + dateTextHeight + destinationTextHeight + startPlaceTextHeight + noteTextHeight;
    
    return itemHeight;
}
@end
