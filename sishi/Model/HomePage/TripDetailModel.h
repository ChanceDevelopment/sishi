//
//  TripDetailModel.h
//
//  Created by likeSo  on 2016/12/24
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface TripDetailModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *carOwnerId;
@property (nonatomic, assign) double carOwnerType;
@property (nonatomic, strong) NSString *carOwnerImg;
@property (nonatomic, strong) NSString *setUserId;
@property (nonatomic, strong) NSString *getUserId;
@property (nonatomic, assign) double carOwnerPositionX;
@property (nonatomic, strong) NSString *setUserNick;
@property (nonatomic, strong) NSString *carAccess;
@property (nonatomic, assign) double carOwnerCreatetime;
@property (nonatomic, strong) NSString *carOwnerStopplace;
@property (nonatomic, assign) double carUserGotime;
@property (nonatomic, strong) NSString *carOwnerStartplace;
@property (nonatomic, strong) NSString *carUserid;
@property (nonatomic, strong) NSString *carIdentityWas;
@property (nonatomic, strong) NSString *carOwnerNote;
@property (nonatomic, strong) NSString *getHeader;
@property (nonatomic, assign) double carOwnerIsend;
@property (nonatomic, strong) NSString *setHeader;
@property (nonatomic, strong) NSString *carUserLike;
@property (nonatomic, strong) NSString *getUserNick;
@property (nonatomic, assign) double carOwnerState;
@property (nonatomic, assign) double carOwnerPositionY;
@property (nonatomic, assign) double carEndtime;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
