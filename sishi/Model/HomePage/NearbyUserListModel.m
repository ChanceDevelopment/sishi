//
//  NearbyUserListModel.m
//
//  Created by likeSo  on 2016/12/24
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "NearbyUserListModel.h"


NSString *const kNearbyUserListModelUserNick = @"userNick";
NSString *const kNearbyUserListModelUserCarlable = @"userCarlable";
NSString *const kNearbyUserListModelFollowState = @"followState";
NSString *const kNearbyUserListModelUserHeader = @"userHeader";
NSString *const kNearbyUserListModelUserPaperWall = @"userPaperWall";
NSString *const kNearbyUserListModelUserId = @"userId";
NSString *const kNearbyUserListModelUserName = @"userName";
NSString *const kNearbyUserListModelCity = @"city";
NSString *const kNearbyUserListModelDistance = @"distance";
NSString *const kNearbyUserListModelUserSign = @"userSign";
NSString *const kNearbyUserListModelHxId = @"hxId";
NSString *const kNearbyUserListModelUserSex = @"userSex";


@interface NearbyUserListModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation NearbyUserListModel

@synthesize userNick = _userNick;
@synthesize userCarlable = _userCarlable;
@synthesize followState = _followState;
@synthesize userHeader = _userHeader;
@synthesize userPaperWall = _userPaperWall;
@synthesize userId = _userId;
@synthesize userName = _userName;
@synthesize city = _city;
@synthesize distance = _distance;
@synthesize userSign = _userSign;
@synthesize hxId = _hxId;
@synthesize userSex = _userSex;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.userNick = [self objectOrNilForKey:kNearbyUserListModelUserNick fromDictionary:dict];
            self.userCarlable = [self objectOrNilForKey:kNearbyUserListModelUserCarlable fromDictionary:dict];
            self.followState = [self objectOrNilForKey:kNearbyUserListModelFollowState fromDictionary:dict];
            self.userHeader = [self objectOrNilForKey:kNearbyUserListModelUserHeader fromDictionary:dict];
            self.userPaperWall = [self objectOrNilForKey:kNearbyUserListModelUserPaperWall fromDictionary:dict];
            self.userId = [self objectOrNilForKey:kNearbyUserListModelUserId fromDictionary:dict];
            self.userName = [self objectOrNilForKey:kNearbyUserListModelUserName fromDictionary:dict];
            self.city = [self objectOrNilForKey:kNearbyUserListModelCity fromDictionary:dict];
            self.distance = [[self objectOrNilForKey:kNearbyUserListModelDistance fromDictionary:dict] doubleValue];
            self.userSign = [self objectOrNilForKey:kNearbyUserListModelUserSign fromDictionary:dict];
            self.hxId = [self objectOrNilForKey:kNearbyUserListModelHxId fromDictionary:dict];
            self.userSex = [self objectOrNilForKey:kNearbyUserListModelUserSex fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.userNick forKey:kNearbyUserListModelUserNick];
    [mutableDict setValue:self.userCarlable forKey:kNearbyUserListModelUserCarlable];
    [mutableDict setValue:self.followState forKey:kNearbyUserListModelFollowState];
    [mutableDict setValue:self.userHeader forKey:kNearbyUserListModelUserHeader];
    [mutableDict setValue:self.userPaperWall forKey:kNearbyUserListModelUserPaperWall];
    [mutableDict setValue:self.userId forKey:kNearbyUserListModelUserId];
    [mutableDict setValue:self.userName forKey:kNearbyUserListModelUserName];
    [mutableDict setValue:self.city forKey:kNearbyUserListModelCity];
    [mutableDict setValue:[NSNumber numberWithDouble:self.distance] forKey:kNearbyUserListModelDistance];
    [mutableDict setValue:self.userSign forKey:kNearbyUserListModelUserSign];
    [mutableDict setValue:self.hxId forKey:kNearbyUserListModelHxId];
    [mutableDict setValue:self.userSex forKey:kNearbyUserListModelUserSex];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.userNick = [aDecoder decodeObjectForKey:kNearbyUserListModelUserNick];
    self.userCarlable = [aDecoder decodeObjectForKey:kNearbyUserListModelUserCarlable];
    self.followState = [aDecoder decodeObjectForKey:kNearbyUserListModelFollowState];
    self.userHeader = [aDecoder decodeObjectForKey:kNearbyUserListModelUserHeader];
    self.userPaperWall = [aDecoder decodeObjectForKey:kNearbyUserListModelUserPaperWall];
    self.userId = [aDecoder decodeObjectForKey:kNearbyUserListModelUserId];
    self.userName = [aDecoder decodeObjectForKey:kNearbyUserListModelUserName];
    self.city = [aDecoder decodeObjectForKey:kNearbyUserListModelCity];
    self.distance = [aDecoder decodeDoubleForKey:kNearbyUserListModelDistance];
    self.userSign = [aDecoder decodeObjectForKey:kNearbyUserListModelUserSign];
    self.hxId = [aDecoder decodeObjectForKey:kNearbyUserListModelHxId];
    self.userSex = [aDecoder decodeObjectForKey:kNearbyUserListModelUserSex];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_userNick forKey:kNearbyUserListModelUserNick];
    [aCoder encodeObject:_userCarlable forKey:kNearbyUserListModelUserCarlable];
    [aCoder encodeObject:_followState forKey:kNearbyUserListModelFollowState];
    [aCoder encodeObject:_userHeader forKey:kNearbyUserListModelUserHeader];
    [aCoder encodeObject:_userPaperWall forKey:kNearbyUserListModelUserPaperWall];
    [aCoder encodeObject:_userId forKey:kNearbyUserListModelUserId];
    [aCoder encodeObject:_userName forKey:kNearbyUserListModelUserName];
    [aCoder encodeObject:_city forKey:kNearbyUserListModelCity];
    [aCoder encodeDouble:_distance forKey:kNearbyUserListModelDistance];
    [aCoder encodeObject:_userSign forKey:kNearbyUserListModelUserSign];
    [aCoder encodeObject:_hxId forKey:kNearbyUserListModelHxId];
    [aCoder encodeObject:_userSex forKey:kNearbyUserListModelUserSex];
}

- (id)copyWithZone:(NSZone *)zone
{
    NearbyUserListModel *copy = [[NearbyUserListModel alloc] init];
    
    if (copy) {

        copy.userNick = [self.userNick copyWithZone:zone];
        copy.userCarlable = [self.userCarlable copyWithZone:zone];
        copy.followState = [self.followState copyWithZone:zone];
        copy.userHeader = [self.userHeader copyWithZone:zone];
        copy.userPaperWall = [self.userPaperWall copyWithZone:zone];
        copy.userId = [self.userId copyWithZone:zone];
        copy.userName = [self.userName copyWithZone:zone];
        copy.city = [self.city copyWithZone:zone];
        copy.distance = self.distance;
        copy.userSign = [self.userSign copyWithZone:zone];
        copy.hxId = [self.hxId copyWithZone:zone];
        copy.userSex = [self.userSex copyWithZone:zone];
    }
    
    return copy;
}


@end
