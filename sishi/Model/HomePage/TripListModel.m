//
//  TripListModel.m
//
//  Created by likeSo  on 2016/12/24
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "TripListModel.h"


NSString *const kTripListModelCarOwnerId = @"carOwnerId";
NSString *const kTripListModelCarOwnerType = @"carOwnerType";
NSString *const kTripListModelCarOwnerImg = @"carOwnerImg";
NSString *const kTripListModelCarOwnerPositionY = @"carOwnerPositionY";
NSString *const kTripListModelUserHeader = @"userHeader";
NSString *const kTripListModelCarOwnerPositionX = @"carOwnerPositionX";
NSString *const kTripListModelCarAccess = @"carAccess";
NSString *const kTripListModelCarOwnerCreatetime = @"carOwnerCreatetime";
NSString *const kTripListModelCarOwnerStopplace = @"carOwnerStopplace";
NSString *const kTripListModelCarUserGotime = @"carUserGotime";
NSString *const kTripListModelCarOwnerStartplace = @"carOwnerStartplace";
NSString *const kTripListModelCarUserid = @"carUserid";
NSString *const kTripListModelCarIdentityWas = @"carIdentityWas";
NSString *const kTripListModelUserNick = @"userNick";
NSString *const kTripListModelCarOwnerNote = @"carOwnerNote";
NSString *const kTripListModelCarOwnerIsend = @"carOwnerIsend";
NSString *const kTripListModelCarUserLike = @"carUserLike";
NSString *const kTripListModelCarOwnerState = @"carOwnerState";
NSString *const kTripListModelCarEndtime = @"carEndtime";
NSString *const kTripListModelUserId = @"userId";


@interface TripListModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation TripListModel

@synthesize carOwnerId = _carOwnerId;
@synthesize carOwnerType = _carOwnerType;
@synthesize carOwnerImg = _carOwnerImg;
@synthesize carOwnerPositionY = _carOwnerPositionY;
@synthesize userHeader = _userHeader;
@synthesize carOwnerPositionX = _carOwnerPositionX;
@synthesize carAccess = _carAccess;
@synthesize carOwnerCreatetime = _carOwnerCreatetime;
@synthesize carOwnerStopplace = _carOwnerStopplace;
@synthesize carUserGotime = _carUserGotime;
@synthesize carOwnerStartplace = _carOwnerStartplace;
@synthesize carUserid = _carUserid;
@synthesize carIdentityWas = _carIdentityWas;
@synthesize userNick = _userNick;
@synthesize carOwnerNote = _carOwnerNote;
@synthesize carOwnerIsend = _carOwnerIsend;
@synthesize carUserLike = _carUserLike;
@synthesize carOwnerState = _carOwnerState;
@synthesize carEndtime = _carEndtime;
@synthesize userId = _userId;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (void)setIsWaitOtherTake:(BOOL)isWaitOtherTake {
    _isWaitOtherTake = isWaitOtherTake;
    CGFloat toplineDistance = 70.f;
    CGFloat padding = 30.0;
    UIFont *labelFont = [UIFont systemFontOfSize:14];
    CGFloat itemWidth  =SCREENWIDTH - 20;
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:labelFont,NSFontAttributeName, nil];
    
    NSString *nickName = [NSString stringWithFormat:@"%@发起一条邀约",self.userNick];
    CGSize nickSize = [nickName boundingRectWithSize:CGSizeMake(itemWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    NSString *destinationName = [NSString stringWithFormat:@"目的地 : %@",self.carOwnerStopplace];
    CGSize destinationSize = [destinationName boundingRectWithSize:CGSizeMake(itemWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    NSString *goTimeString = [NSString stringWithFormat:@"时间 : %@",self.goTimeDescription];
    CGSize goTimeStringSize = [goTimeString boundingRectWithSize:CGSizeMake(itemWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    NSString *stopPlaceString = [NSString stringWithFormat:@"出发地 : %@",self.carOwnerStartplace
                                 ];
    CGSize stopPlaceSize = [stopPlaceString boundingRectWithSize:CGSizeMake(itemWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    NSString *wishLabelString =  [NSString stringWithFormat:@"期待邀约的Ta : %@",self.carUserLike];
    CGSize wishLabelSize = [wishLabelString boundingRectWithSize:CGSizeMake(itemWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    NSString *noteLabelString =  [NSString stringWithFormat:@"备注 : %@",self.carOwnerNote];
    CGSize labelSize = [noteLabelString boundingRectWithSize:CGSizeMake(itemWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    self.itemHeight = toplineDistance + padding + nickSize.height + destinationSize.height + goTimeStringSize.height + stopPlaceSize.height + wishLabelSize.height + labelSize.height;
}


#pragma mark :- Setters

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.carOwnerId = [self objectOrNilForKey:kTripListModelCarOwnerId fromDictionary:dict];
            self.carOwnerType = [self objectOrNilForKey:kTripListModelCarOwnerType fromDictionary:dict];
            self.carOwnerImg = [self objectOrNilForKey:kTripListModelCarOwnerImg fromDictionary:dict];
            self.carOwnerPositionY = [self objectOrNilForKey:kTripListModelCarOwnerPositionY fromDictionary:dict];
            self.userHeader = [self objectOrNilForKey:kTripListModelUserHeader fromDictionary:dict];
            self.carOwnerPositionX = [self objectOrNilForKey:kTripListModelCarOwnerPositionX fromDictionary:dict];
            self.carAccess = [self objectOrNilForKey:kTripListModelCarAccess fromDictionary:dict];
            self.carOwnerCreatetime = [self objectOrNilForKey:kTripListModelCarOwnerCreatetime fromDictionary:dict];
            self.carOwnerStopplace = [self objectOrNilForKey:kTripListModelCarOwnerStopplace fromDictionary:dict];
            self.carUserGotime = [[self objectOrNilForKey:kTripListModelCarUserGotime fromDictionary:dict] doubleValue];
            self.carOwnerStartplace = [self objectOrNilForKey:kTripListModelCarOwnerStartplace fromDictionary:dict];
            self.carUserid = [self objectOrNilForKey:kTripListModelCarUserid fromDictionary:dict];
            self.carIdentityWas = [self objectOrNilForKey:kTripListModelCarIdentityWas fromDictionary:dict];
            self.userNick = [self objectOrNilForKey:kTripListModelUserNick fromDictionary:dict];
            self.carOwnerNote = [self objectOrNilForKey:kTripListModelCarOwnerNote fromDictionary:dict];
            self.carOwnerIsend = [[self objectOrNilForKey:kTripListModelCarOwnerIsend fromDictionary:dict] doubleValue];
            self.carUserLike = [self objectOrNilForKey:kTripListModelCarUserLike fromDictionary:dict];
            self.carOwnerState = [self objectOrNilForKey:kTripListModelCarOwnerState fromDictionary:dict];
            self.carEndtime = [self objectOrNilForKey:kTripListModelCarEndtime fromDictionary:dict];
            self.userId = [self objectOrNilForKey:kTripListModelUserId fromDictionary:dict];

    }
    
    return self;
    
}

- (void)setCarUserGotime:(double)carUserGotime {
    _carUserGotime = carUserGotime;
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy/MM/dd HH:mm";
    NSDate *date =[NSDate dateWithTimeIntervalSince1970:carUserGotime / 1000];
    self.goTimeDescription = [formatter stringFromDate:date];
}
- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.carOwnerId forKey:kTripListModelCarOwnerId];
    [mutableDict setValue:self.carOwnerType forKey:kTripListModelCarOwnerType];
    [mutableDict setValue:self.carOwnerImg forKey:kTripListModelCarOwnerImg];
    [mutableDict setValue:self.carOwnerPositionY forKey:kTripListModelCarOwnerPositionY];
    [mutableDict setValue:self.userHeader forKey:kTripListModelUserHeader];
    [mutableDict setValue:self.carOwnerPositionX forKey:kTripListModelCarOwnerPositionX];
    [mutableDict setValue:self.carAccess forKey:kTripListModelCarAccess];
    [mutableDict setValue:self.carOwnerCreatetime forKey:kTripListModelCarOwnerCreatetime];
    [mutableDict setValue:self.carOwnerStopplace forKey:kTripListModelCarOwnerStopplace];
    [mutableDict setValue:[NSNumber numberWithDouble:self.carUserGotime] forKey:kTripListModelCarUserGotime];
    [mutableDict setValue:self.carOwnerStartplace forKey:kTripListModelCarOwnerStartplace];
    [mutableDict setValue:self.carUserid forKey:kTripListModelCarUserid];
    [mutableDict setValue:self.carIdentityWas forKey:kTripListModelCarIdentityWas];
    [mutableDict setValue:self.userNick forKey:kTripListModelUserNick];
    [mutableDict setValue:self.carOwnerNote forKey:kTripListModelCarOwnerNote];
    [mutableDict setValue:[NSNumber numberWithDouble:self.carOwnerIsend] forKey:kTripListModelCarOwnerIsend];
    [mutableDict setValue:self.carUserLike forKey:kTripListModelCarUserLike];
    [mutableDict setValue:self.carOwnerState forKey:kTripListModelCarOwnerState];
    [mutableDict setValue:self.carEndtime forKey:kTripListModelCarEndtime];
    [mutableDict setValue:self.userId forKey:kTripListModelUserId];

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

    self.carOwnerId = [aDecoder decodeObjectForKey:kTripListModelCarOwnerId];
    self.carOwnerType = [aDecoder decodeObjectForKey:kTripListModelCarOwnerType];
    self.carOwnerImg = [aDecoder decodeObjectForKey:kTripListModelCarOwnerImg];
    self.carOwnerPositionY = [aDecoder decodeObjectForKey:kTripListModelCarOwnerPositionY];
    self.userHeader = [aDecoder decodeObjectForKey:kTripListModelUserHeader];
    self.carOwnerPositionX = [aDecoder decodeObjectForKey:kTripListModelCarOwnerPositionX];
    self.carAccess = [aDecoder decodeObjectForKey:kTripListModelCarAccess];
    self.carOwnerCreatetime = [aDecoder decodeObjectForKey:kTripListModelCarOwnerCreatetime];
    self.carOwnerStopplace = [aDecoder decodeObjectForKey:kTripListModelCarOwnerStopplace];
    self.carUserGotime = [aDecoder decodeDoubleForKey:kTripListModelCarUserGotime];
    self.carOwnerStartplace = [aDecoder decodeObjectForKey:kTripListModelCarOwnerStartplace];
    self.carUserid = [aDecoder decodeObjectForKey:kTripListModelCarUserid];
    self.carIdentityWas = [aDecoder decodeObjectForKey:kTripListModelCarIdentityWas];
    self.userNick = [aDecoder decodeObjectForKey:kTripListModelUserNick];
    self.carOwnerNote = [aDecoder decodeObjectForKey:kTripListModelCarOwnerNote];
    self.carOwnerIsend = [aDecoder decodeDoubleForKey:kTripListModelCarOwnerIsend];
    self.carUserLike = [aDecoder decodeObjectForKey:kTripListModelCarUserLike];
    self.carOwnerState = [aDecoder decodeObjectForKey:kTripListModelCarOwnerState];
    self.carEndtime = [aDecoder decodeObjectForKey:kTripListModelCarEndtime];
    self.userId = [aDecoder decodeObjectForKey:kTripListModelUserId];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_carOwnerId forKey:kTripListModelCarOwnerId];
    [aCoder encodeObject:_carOwnerType forKey:kTripListModelCarOwnerType];
    [aCoder encodeObject:_carOwnerImg forKey:kTripListModelCarOwnerImg];
    [aCoder encodeObject:_carOwnerPositionY forKey:kTripListModelCarOwnerPositionY];
    [aCoder encodeObject:_userHeader forKey:kTripListModelUserHeader];
    [aCoder encodeObject:_carOwnerPositionX forKey:kTripListModelCarOwnerPositionX];
    [aCoder encodeObject:_carAccess forKey:kTripListModelCarAccess];
    [aCoder encodeObject:_carOwnerCreatetime forKey:kTripListModelCarOwnerCreatetime];
    [aCoder encodeObject:_carOwnerStopplace forKey:kTripListModelCarOwnerStopplace];
    [aCoder encodeDouble:_carUserGotime forKey:kTripListModelCarUserGotime];
    [aCoder encodeObject:_carOwnerStartplace forKey:kTripListModelCarOwnerStartplace];
    [aCoder encodeObject:_carUserid forKey:kTripListModelCarUserid];
    [aCoder encodeObject:_carIdentityWas forKey:kTripListModelCarIdentityWas];
    [aCoder encodeObject:_userNick forKey:kTripListModelUserNick];
    [aCoder encodeObject:_carOwnerNote forKey:kTripListModelCarOwnerNote];
    [aCoder encodeDouble:_carOwnerIsend forKey:kTripListModelCarOwnerIsend];
    [aCoder encodeObject:_carUserLike forKey:kTripListModelCarUserLike];
    [aCoder encodeObject:_carOwnerState forKey:kTripListModelCarOwnerState];
    [aCoder encodeObject:_carEndtime forKey:kTripListModelCarEndtime];
    [aCoder encodeObject:_userId forKey:kTripListModelUserId];
}

- (id)copyWithZone:(NSZone *)zone
{
    TripListModel *copy = [[TripListModel alloc] init];
    
    if (copy) {

        copy.carOwnerId = [self.carOwnerId copyWithZone:zone];
        copy.carOwnerType = [self.carOwnerType copyWithZone:zone];
        copy.carOwnerImg = [self.carOwnerImg copyWithZone:zone];
        copy.carOwnerPositionY = [self.carOwnerPositionY copyWithZone:zone];
        copy.userHeader = [self.userHeader copyWithZone:zone];
        copy.carOwnerPositionX = [self.carOwnerPositionX copyWithZone:zone];
        copy.carAccess = [self.carAccess copyWithZone:zone];
        copy.carOwnerCreatetime = [self.carOwnerCreatetime copyWithZone:zone];
        copy.carOwnerStopplace = [self.carOwnerStopplace copyWithZone:zone];
        copy.carUserGotime = self.carUserGotime;
        copy.carOwnerStartplace = [self.carOwnerStartplace copyWithZone:zone];
        copy.carUserid = [self.carUserid copyWithZone:zone];
        copy.carIdentityWas = [self.carIdentityWas copyWithZone:zone];
        copy.userNick = [self.userNick copyWithZone:zone];
        copy.carOwnerNote = [self.carOwnerNote copyWithZone:zone];
        copy.carOwnerIsend = self.carOwnerIsend;
        copy.carUserLike = [self.carUserLike copyWithZone:zone];
        copy.carOwnerState = [self.carOwnerState copyWithZone:zone];
        copy.carEndtime = [self.carEndtime copyWithZone:zone];
        copy.userId = [self.userId copyWithZone:zone];
    }
    
    return copy;
}


@end
