//
//  DynamicListModel.h
//
//  Created by likeSo  on 2016/12/24
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface DynamicListModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *userId;
@property (nonatomic, assign) id dynamicPositionX;
@property (nonatomic, assign) double dynamicCreatetime;
/**
 *  时间格式化文本
 */
@property(nonatomic,copy)NSString *datetime;
@property (nonatomic, strong) NSString *userNick;
@property (nonatomic, strong) NSString *dynamicId;
@property (nonatomic, assign) id dynamicPositionY;
@property (nonatomic, strong) NSString *userSex;
@property (nonatomic, strong) NSString *dynamicTripid;
@property (nonatomic, strong) NSString *dynamicContent;
@property (nonatomic, strong) NSString *userHeader;
@property (nonatomic, strong) NSString *dynamicWallurl;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
