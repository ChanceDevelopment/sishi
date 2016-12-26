//
//  DynamicListModel.m
//
//  Created by likeSo  on 2016/12/24
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "DynamicListModel.h"


NSString *const kDynamicListModelUserId = @"userId";
NSString *const kDynamicListModelDynamicPositionX = @"dynamicPositionX";
NSString *const kDynamicListModelDynamicCreatetime = @"dynamicCreatetime";
NSString *const kDynamicListModelUserNick = @"userNick";
NSString *const kDynamicListModelDynamicId = @"dynamicId";
NSString *const kDynamicListModelDynamicPositionY = @"dynamicPositionY";
NSString *const kDynamicListModelUserSex = @"userSex";
NSString *const kDynamicListModelDynamicTripid = @"dynamicTripid";
NSString *const kDynamicListModelDynamicContent = @"dynamicContent";
NSString *const kDynamicListModelUserHeader = @"userHeader";
NSString *const kDynamicListModelDynamicWallurl = @"dynamicWallurl";


@interface DynamicListModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation DynamicListModel

@synthesize userId = _userId;
@synthesize dynamicPositionX = _dynamicPositionX;
@synthesize dynamicCreatetime = _dynamicCreatetime;
@synthesize userNick = _userNick;
@synthesize dynamicId = _dynamicId;
@synthesize dynamicPositionY = _dynamicPositionY;
@synthesize userSex = _userSex;
@synthesize dynamicTripid = _dynamicTripid;
@synthesize dynamicContent = _dynamicContent;
@synthesize userHeader = _userHeader;
@synthesize dynamicWallurl = _dynamicWallurl;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (void)setDynamicCreatetime:(double)dynamicCreatetime {
    _dynamicCreatetime = dynamicCreatetime;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:dynamicCreatetime];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy年MM月dd日 HH:mm";
    NSString *datetime = [formatter stringFromDate:date];
    self.datetime = datetime;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.userId = [self objectOrNilForKey:kDynamicListModelUserId fromDictionary:dict];
            self.dynamicPositionX = [self objectOrNilForKey:kDynamicListModelDynamicPositionX fromDictionary:dict];
            self.dynamicCreatetime = [[self objectOrNilForKey:kDynamicListModelDynamicCreatetime fromDictionary:dict] doubleValue];
            self.userNick = [self objectOrNilForKey:kDynamicListModelUserNick fromDictionary:dict];
            self.dynamicId = [self objectOrNilForKey:kDynamicListModelDynamicId fromDictionary:dict];
            self.dynamicPositionY = [self objectOrNilForKey:kDynamicListModelDynamicPositionY fromDictionary:dict];
            self.userSex = [self objectOrNilForKey:kDynamicListModelUserSex fromDictionary:dict];
            self.dynamicTripid = [self objectOrNilForKey:kDynamicListModelDynamicTripid fromDictionary:dict];
            self.dynamicContent = [self objectOrNilForKey:kDynamicListModelDynamicContent fromDictionary:dict];
            self.userHeader = [self objectOrNilForKey:kDynamicListModelUserHeader fromDictionary:dict];
            self.dynamicWallurl = [self objectOrNilForKey:kDynamicListModelDynamicWallurl fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.userId forKey:kDynamicListModelUserId];
    [mutableDict setValue:self.dynamicPositionX forKey:kDynamicListModelDynamicPositionX];
    [mutableDict setValue:[NSNumber numberWithDouble:self.dynamicCreatetime] forKey:kDynamicListModelDynamicCreatetime];
    [mutableDict setValue:self.userNick forKey:kDynamicListModelUserNick];
    [mutableDict setValue:self.dynamicId forKey:kDynamicListModelDynamicId];
    [mutableDict setValue:self.dynamicPositionY forKey:kDynamicListModelDynamicPositionY];
    [mutableDict setValue:self.userSex forKey:kDynamicListModelUserSex];
    [mutableDict setValue:self.dynamicTripid forKey:kDynamicListModelDynamicTripid];
    [mutableDict setValue:self.dynamicContent forKey:kDynamicListModelDynamicContent];
    [mutableDict setValue:self.userHeader forKey:kDynamicListModelUserHeader];
    [mutableDict setValue:self.dynamicWallurl forKey:kDynamicListModelDynamicWallurl];

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

    self.userId = [aDecoder decodeObjectForKey:kDynamicListModelUserId];
    self.dynamicPositionX = [aDecoder decodeObjectForKey:kDynamicListModelDynamicPositionX];
    self.dynamicCreatetime = [aDecoder decodeDoubleForKey:kDynamicListModelDynamicCreatetime];
    self.userNick = [aDecoder decodeObjectForKey:kDynamicListModelUserNick];
    self.dynamicId = [aDecoder decodeObjectForKey:kDynamicListModelDynamicId];
    self.dynamicPositionY = [aDecoder decodeObjectForKey:kDynamicListModelDynamicPositionY];
    self.userSex = [aDecoder decodeObjectForKey:kDynamicListModelUserSex];
    self.dynamicTripid = [aDecoder decodeObjectForKey:kDynamicListModelDynamicTripid];
    self.dynamicContent = [aDecoder decodeObjectForKey:kDynamicListModelDynamicContent];
    self.userHeader = [aDecoder decodeObjectForKey:kDynamicListModelUserHeader];
    self.dynamicWallurl = [aDecoder decodeObjectForKey:kDynamicListModelDynamicWallurl];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_userId forKey:kDynamicListModelUserId];
    [aCoder encodeObject:_dynamicPositionX forKey:kDynamicListModelDynamicPositionX];
    [aCoder encodeDouble:_dynamicCreatetime forKey:kDynamicListModelDynamicCreatetime];
    [aCoder encodeObject:_userNick forKey:kDynamicListModelUserNick];
    [aCoder encodeObject:_dynamicId forKey:kDynamicListModelDynamicId];
    [aCoder encodeObject:_dynamicPositionY forKey:kDynamicListModelDynamicPositionY];
    [aCoder encodeObject:_userSex forKey:kDynamicListModelUserSex];
    [aCoder encodeObject:_dynamicTripid forKey:kDynamicListModelDynamicTripid];
    [aCoder encodeObject:_dynamicContent forKey:kDynamicListModelDynamicContent];
    [aCoder encodeObject:_userHeader forKey:kDynamicListModelUserHeader];
    [aCoder encodeObject:_dynamicWallurl forKey:kDynamicListModelDynamicWallurl];
}

- (id)copyWithZone:(NSZone *)zone
{
    DynamicListModel *copy = [[DynamicListModel alloc] init];
    
    if (copy) {

        copy.userId = [self.userId copyWithZone:zone];
        copy.dynamicPositionX = [self.dynamicPositionX copyWithZone:zone];
        copy.dynamicCreatetime = self.dynamicCreatetime;
        copy.userNick = [self.userNick copyWithZone:zone];
        copy.dynamicId = [self.dynamicId copyWithZone:zone];
        copy.dynamicPositionY = [self.dynamicPositionY copyWithZone:zone];
        copy.userSex = [self.userSex copyWithZone:zone];
        copy.dynamicTripid = [self.dynamicTripid copyWithZone:zone];
        copy.dynamicContent = [self.dynamicContent copyWithZone:zone];
        copy.userHeader = [self.userHeader copyWithZone:zone];
        copy.dynamicWallurl = [self.dynamicWallurl copyWithZone:zone];
    }
    
    return copy;
}


@end
