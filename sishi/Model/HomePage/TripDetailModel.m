//
//  TripDetailModel.m
//
//  Created by likeSo  on 2016/12/24
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "TripDetailModel.h"


NSString *const kTripDetailModelCarOwnerId = @"carOwnerId";
NSString *const kTripDetailModelCarOwnerType = @"carOwnerType";
NSString *const kTripDetailModelCarOwnerImg = @"carOwnerImg";
NSString *const kTripDetailModelSetUserId = @"setUserId";
NSString *const kTripDetailModelGetUserId = @"getUserId";
NSString *const kTripDetailModelCarOwnerPositionX = @"carOwnerPositionX";
NSString *const kTripDetailModelSetUserNick = @"setUserNick";
NSString *const kTripDetailModelCarAccess = @"carAccess";
NSString *const kTripDetailModelCarOwnerCreatetime = @"carOwnerCreatetime";
NSString *const kTripDetailModelCarOwnerStopplace = @"carOwnerStopplace";
NSString *const kTripDetailModelCarUserGotime = @"carUserGotime";
NSString *const kTripDetailModelCarOwnerStartplace = @"carOwnerStartplace";
NSString *const kTripDetailModelCarUserid = @"carUserid";
NSString *const kTripDetailModelCarIdentityWas = @"carIdentityWas";
NSString *const kTripDetailModelCarOwnerNote = @"carOwnerNote";
NSString *const kTripDetailModelGetHeader = @"getHeader";
NSString *const kTripDetailModelCarOwnerIsend = @"carOwnerIsend";
NSString *const kTripDetailModelSetHeader = @"setHeader";
NSString *const kTripDetailModelCarUserLike = @"carUserLike";
NSString *const kTripDetailModelGetUserNick = @"getUserNick";
NSString *const kTripDetailModelCarOwnerState = @"carOwnerState";
NSString *const kTripDetailModelCarOwnerPositionY = @"carOwnerPositionY";
NSString *const kTripDetailModelCarEndtime = @"carEndtime";


@interface TripDetailModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation TripDetailModel

@synthesize carOwnerId = _carOwnerId;
@synthesize carOwnerType = _carOwnerType;
@synthesize carOwnerImg = _carOwnerImg;
@synthesize setUserId = _setUserId;
@synthesize getUserId = _getUserId;
@synthesize carOwnerPositionX = _carOwnerPositionX;
@synthesize setUserNick = _setUserNick;
@synthesize carAccess = _carAccess;
@synthesize carOwnerCreatetime = _carOwnerCreatetime;
@synthesize carOwnerStopplace = _carOwnerStopplace;
@synthesize carUserGotime = _carUserGotime;
@synthesize carOwnerStartplace = _carOwnerStartplace;
@synthesize carUserid = _carUserid;
@synthesize carIdentityWas = _carIdentityWas;
@synthesize carOwnerNote = _carOwnerNote;
@synthesize getHeader = _getHeader;
@synthesize carOwnerIsend = _carOwnerIsend;
@synthesize setHeader = _setHeader;
@synthesize carUserLike = _carUserLike;
@synthesize getUserNick = _getUserNick;
@synthesize carOwnerState = _carOwnerState;
@synthesize carOwnerPositionY = _carOwnerPositionY;
@synthesize carEndtime = _carEndtime;


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
            self.carOwnerId = [self objectOrNilForKey:kTripDetailModelCarOwnerId fromDictionary:dict];
            self.carOwnerType = [[self objectOrNilForKey:kTripDetailModelCarOwnerType fromDictionary:dict] doubleValue];
            self.carOwnerImg = [self objectOrNilForKey:kTripDetailModelCarOwnerImg fromDictionary:dict];
            self.setUserId = [self objectOrNilForKey:kTripDetailModelSetUserId fromDictionary:dict];
            self.getUserId = [self objectOrNilForKey:kTripDetailModelGetUserId fromDictionary:dict];
            self.carOwnerPositionX = [[self objectOrNilForKey:kTripDetailModelCarOwnerPositionX fromDictionary:dict] doubleValue];
            self.setUserNick = [self objectOrNilForKey:kTripDetailModelSetUserNick fromDictionary:dict];
            self.carAccess = [self objectOrNilForKey:kTripDetailModelCarAccess fromDictionary:dict];
            self.carOwnerCreatetime = [[self objectOrNilForKey:kTripDetailModelCarOwnerCreatetime fromDictionary:dict] doubleValue];
            self.carOwnerStopplace = [self objectOrNilForKey:kTripDetailModelCarOwnerStopplace fromDictionary:dict];
            self.carUserGotime = [[self objectOrNilForKey:kTripDetailModelCarUserGotime fromDictionary:dict] doubleValue];
            self.carOwnerStartplace = [self objectOrNilForKey:kTripDetailModelCarOwnerStartplace fromDictionary:dict];
            self.carUserid = [self objectOrNilForKey:kTripDetailModelCarUserid fromDictionary:dict];
            self.carIdentityWas = [self objectOrNilForKey:kTripDetailModelCarIdentityWas fromDictionary:dict];
            self.carOwnerNote = [self objectOrNilForKey:kTripDetailModelCarOwnerNote fromDictionary:dict];
            self.getHeader = [self objectOrNilForKey:kTripDetailModelGetHeader fromDictionary:dict];
            self.carOwnerIsend = [[self objectOrNilForKey:kTripDetailModelCarOwnerIsend fromDictionary:dict] doubleValue];
            self.setHeader = [self objectOrNilForKey:kTripDetailModelSetHeader fromDictionary:dict];
            self.carUserLike = [self objectOrNilForKey:kTripDetailModelCarUserLike fromDictionary:dict];
            self.getUserNick = [self objectOrNilForKey:kTripDetailModelGetUserNick fromDictionary:dict];
            self.carOwnerState = [[self objectOrNilForKey:kTripDetailModelCarOwnerState fromDictionary:dict] doubleValue];
            self.carOwnerPositionY = [[self objectOrNilForKey:kTripDetailModelCarOwnerPositionY fromDictionary:dict] doubleValue];
            self.carEndtime = [[self objectOrNilForKey:kTripDetailModelCarEndtime fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (void)setCarUserGotime:(double)carUserGotime {
    _carUserGotime = carUserGotime;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:carUserGotime / 1000];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm";
    self.startDate = [dateFormatter stringFromDate:date];
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.carOwnerId forKey:kTripDetailModelCarOwnerId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.carOwnerType] forKey:kTripDetailModelCarOwnerType];
    [mutableDict setValue:self.carOwnerImg forKey:kTripDetailModelCarOwnerImg];
    [mutableDict setValue:self.setUserId forKey:kTripDetailModelSetUserId];
    [mutableDict setValue:self.getUserId forKey:kTripDetailModelGetUserId];
    [mutableDict setValue:[NSNumber numberWithDouble:self.carOwnerPositionX] forKey:kTripDetailModelCarOwnerPositionX];
    [mutableDict setValue:self.setUserNick forKey:kTripDetailModelSetUserNick];
    [mutableDict setValue:self.carAccess forKey:kTripDetailModelCarAccess];
    [mutableDict setValue:[NSNumber numberWithDouble:self.carOwnerCreatetime] forKey:kTripDetailModelCarOwnerCreatetime];
    [mutableDict setValue:self.carOwnerStopplace forKey:kTripDetailModelCarOwnerStopplace];
    [mutableDict setValue:[NSNumber numberWithDouble:self.carUserGotime] forKey:kTripDetailModelCarUserGotime];
    [mutableDict setValue:self.carOwnerStartplace forKey:kTripDetailModelCarOwnerStartplace];
    [mutableDict setValue:self.carUserid forKey:kTripDetailModelCarUserid];
    [mutableDict setValue:self.carIdentityWas forKey:kTripDetailModelCarIdentityWas];
    [mutableDict setValue:self.carOwnerNote forKey:kTripDetailModelCarOwnerNote];
    [mutableDict setValue:self.getHeader forKey:kTripDetailModelGetHeader];
    [mutableDict setValue:[NSNumber numberWithDouble:self.carOwnerIsend] forKey:kTripDetailModelCarOwnerIsend];
    [mutableDict setValue:self.setHeader forKey:kTripDetailModelSetHeader];
    [mutableDict setValue:self.carUserLike forKey:kTripDetailModelCarUserLike];
    [mutableDict setValue:self.getUserNick forKey:kTripDetailModelGetUserNick];
    [mutableDict setValue:[NSNumber numberWithDouble:self.carOwnerState] forKey:kTripDetailModelCarOwnerState];
    [mutableDict setValue:[NSNumber numberWithDouble:self.carOwnerPositionY] forKey:kTripDetailModelCarOwnerPositionY];
    [mutableDict setValue:[NSNumber numberWithDouble:self.carEndtime] forKey:kTripDetailModelCarEndtime];

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

    self.carOwnerId = [aDecoder decodeObjectForKey:kTripDetailModelCarOwnerId];
    self.carOwnerType = [aDecoder decodeDoubleForKey:kTripDetailModelCarOwnerType];
    self.carOwnerImg = [aDecoder decodeObjectForKey:kTripDetailModelCarOwnerImg];
    self.setUserId = [aDecoder decodeObjectForKey:kTripDetailModelSetUserId];
    self.getUserId = [aDecoder decodeObjectForKey:kTripDetailModelGetUserId];
    self.carOwnerPositionX = [aDecoder decodeDoubleForKey:kTripDetailModelCarOwnerPositionX];
    self.setUserNick = [aDecoder decodeObjectForKey:kTripDetailModelSetUserNick];
    self.carAccess = [aDecoder decodeObjectForKey:kTripDetailModelCarAccess];
    self.carOwnerCreatetime = [aDecoder decodeDoubleForKey:kTripDetailModelCarOwnerCreatetime];
    self.carOwnerStopplace = [aDecoder decodeObjectForKey:kTripDetailModelCarOwnerStopplace];
    self.carUserGotime = [aDecoder decodeDoubleForKey:kTripDetailModelCarUserGotime];
    self.carOwnerStartplace = [aDecoder decodeObjectForKey:kTripDetailModelCarOwnerStartplace];
    self.carUserid = [aDecoder decodeObjectForKey:kTripDetailModelCarUserid];
    self.carIdentityWas = [aDecoder decodeObjectForKey:kTripDetailModelCarIdentityWas];
    self.carOwnerNote = [aDecoder decodeObjectForKey:kTripDetailModelCarOwnerNote];
    self.getHeader = [aDecoder decodeObjectForKey:kTripDetailModelGetHeader];
    self.carOwnerIsend = [aDecoder decodeDoubleForKey:kTripDetailModelCarOwnerIsend];
    self.setHeader = [aDecoder decodeObjectForKey:kTripDetailModelSetHeader];
    self.carUserLike = [aDecoder decodeObjectForKey:kTripDetailModelCarUserLike];
    self.getUserNick = [aDecoder decodeObjectForKey:kTripDetailModelGetUserNick];
    self.carOwnerState = [aDecoder decodeDoubleForKey:kTripDetailModelCarOwnerState];
    self.carOwnerPositionY = [aDecoder decodeDoubleForKey:kTripDetailModelCarOwnerPositionY];
    self.carEndtime = [aDecoder decodeDoubleForKey:kTripDetailModelCarEndtime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_carOwnerId forKey:kTripDetailModelCarOwnerId];
    [aCoder encodeDouble:_carOwnerType forKey:kTripDetailModelCarOwnerType];
    [aCoder encodeObject:_carOwnerImg forKey:kTripDetailModelCarOwnerImg];
    [aCoder encodeObject:_setUserId forKey:kTripDetailModelSetUserId];
    [aCoder encodeObject:_getUserId forKey:kTripDetailModelGetUserId];
    [aCoder encodeDouble:_carOwnerPositionX forKey:kTripDetailModelCarOwnerPositionX];
    [aCoder encodeObject:_setUserNick forKey:kTripDetailModelSetUserNick];
    [aCoder encodeObject:_carAccess forKey:kTripDetailModelCarAccess];
    [aCoder encodeDouble:_carOwnerCreatetime forKey:kTripDetailModelCarOwnerCreatetime];
    [aCoder encodeObject:_carOwnerStopplace forKey:kTripDetailModelCarOwnerStopplace];
    [aCoder encodeDouble:_carUserGotime forKey:kTripDetailModelCarUserGotime];
    [aCoder encodeObject:_carOwnerStartplace forKey:kTripDetailModelCarOwnerStartplace];
    [aCoder encodeObject:_carUserid forKey:kTripDetailModelCarUserid];
    [aCoder encodeObject:_carIdentityWas forKey:kTripDetailModelCarIdentityWas];
    [aCoder encodeObject:_carOwnerNote forKey:kTripDetailModelCarOwnerNote];
    [aCoder encodeObject:_getHeader forKey:kTripDetailModelGetHeader];
    [aCoder encodeDouble:_carOwnerIsend forKey:kTripDetailModelCarOwnerIsend];
    [aCoder encodeObject:_setHeader forKey:kTripDetailModelSetHeader];
    [aCoder encodeObject:_carUserLike forKey:kTripDetailModelCarUserLike];
    [aCoder encodeObject:_getUserNick forKey:kTripDetailModelGetUserNick];
    [aCoder encodeDouble:_carOwnerState forKey:kTripDetailModelCarOwnerState];
    [aCoder encodeDouble:_carOwnerPositionY forKey:kTripDetailModelCarOwnerPositionY];
    [aCoder encodeDouble:_carEndtime forKey:kTripDetailModelCarEndtime];
}

- (id)copyWithZone:(NSZone *)zone
{
    TripDetailModel *copy = [[TripDetailModel alloc] init];
    
    if (copy) {

        copy.carOwnerId = [self.carOwnerId copyWithZone:zone];
        copy.carOwnerType = self.carOwnerType;
        copy.carOwnerImg = [self.carOwnerImg copyWithZone:zone];
        copy.setUserId = [self.setUserId copyWithZone:zone];
        copy.getUserId = [self.getUserId copyWithZone:zone];
        copy.carOwnerPositionX = self.carOwnerPositionX;
        copy.setUserNick = [self.setUserNick copyWithZone:zone];
        copy.carAccess = [self.carAccess copyWithZone:zone];
        copy.carOwnerCreatetime = self.carOwnerCreatetime;
        copy.carOwnerStopplace = [self.carOwnerStopplace copyWithZone:zone];
        copy.carUserGotime = self.carUserGotime;
        copy.carOwnerStartplace = [self.carOwnerStartplace copyWithZone:zone];
        copy.carUserid = [self.carUserid copyWithZone:zone];
        copy.carIdentityWas = [self.carIdentityWas copyWithZone:zone];
        copy.carOwnerNote = [self.carOwnerNote copyWithZone:zone];
        copy.getHeader = [self.getHeader copyWithZone:zone];
        copy.carOwnerIsend = self.carOwnerIsend;
        copy.setHeader = [self.setHeader copyWithZone:zone];
        copy.carUserLike = [self.carUserLike copyWithZone:zone];
        copy.getUserNick = [self.getUserNick copyWithZone:zone];
        copy.carOwnerState = self.carOwnerState;
        copy.carOwnerPositionY = self.carOwnerPositionY;
        copy.carEndtime = self.carEndtime;
    }
    
    return copy;
}


@end
