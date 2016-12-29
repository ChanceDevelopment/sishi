//
//  TripListModel.h
//
//  Created by likeSo  on 2016/12/24
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface TripListModel : NSObject <NSCoding, NSCopying>

/**
 *  是否是 未接取 状态,设置此属性将开始计算单元格高度
 */
@property(nonatomic,assign)BOOL isWaitOtherTake;

/**
 *  当作为待截取状态时,单元格高度
 */
@property(nonatomic,assign)CGFloat itemHeight;

@property (nonatomic, strong) NSString *carOwnerId;
@property (nonatomic, strong) NSString *carOwnerType;
@property (nonatomic, strong) NSString *carOwnerImg;
@property (nonatomic, assign) id carOwnerPositionY;
@property (nonatomic, strong) NSString *userHeader;
@property (nonatomic, assign) id carOwnerPositionX;
@property (nonatomic, strong) NSString *carAccess;
@property (nonatomic, strong) NSString *carOwnerCreatetime;
@property (nonatomic, strong) NSString *carOwnerStopplace;

/**
 *  当前行程是否已开启
 */
@property(nonatomic,assign)BOOL isOnGoing;//当前行程是否已开启

/**
 *  出发时间 字符串描述文本
 */
@property(nonatomic,strong)NSString *goTimeDescription;


@property (nonatomic, assign) double carUserGotime;
@property (nonatomic, strong) NSString *carOwnerStartplace;
@property (nonatomic, strong) NSString *carUserid;
@property (nonatomic, strong) NSString *carIdentityWas;
@property (nonatomic, strong) NSString *userNick;
@property (nonatomic, strong) NSString *carOwnerNote;
@property (nonatomic, assign) double carOwnerIsend;
@property (nonatomic, strong) NSString *carUserLike;
@property (nonatomic, strong) NSString *carOwnerState;
@property (nonatomic, strong) NSString *carEndtime;
@property (nonatomic, strong) NSString *userId;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
