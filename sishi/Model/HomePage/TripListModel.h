//
//  TripListModel.h
//
//  Created by likeSo  on 2016/12/24
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface TripListModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *carOwnerId;
@property (nonatomic, strong) NSString *carOwnerType;
@property (nonatomic, strong) NSString *carOwnerImg;
@property (nonatomic, assign) id carOwnerPositionY;
@property (nonatomic, strong) NSString *userHeader;
@property (nonatomic, assign) id carOwnerPositionX;
@property (nonatomic, strong) NSString *carAccess;
@property (nonatomic, strong) NSString *carOwnerCreatetime;
@property (nonatomic, strong) NSString *carOwnerStopplace;
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
