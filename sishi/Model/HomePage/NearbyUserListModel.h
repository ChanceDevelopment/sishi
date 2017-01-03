//
//  NearbyUserListModel.h
//
//  Created by likeSo  on 2016/12/24
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface NearbyUserListModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *userNick;
@property (nonatomic, strong) NSString *userCarlable;
@property (nonatomic, strong) NSString *followState;
@property (nonatomic, copy) NSString * userHeader;
@property (nonatomic, strong) NSString *userPaperWall;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, assign) double distance;
@property (nonatomic, copy) NSString * userSign;
@property (nonatomic, strong) NSString *hxId;
@property (nonatomic, strong) NSString *userSex;


/**
 *  是否进行过点赞操作
 */
@property(nonatomic,assign)BOOL isUpvoted;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
