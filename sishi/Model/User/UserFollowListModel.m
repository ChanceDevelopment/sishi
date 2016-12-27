//
//  UserFollowListModel.m
//
//  Created by likeSo  on 2016/12/22
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "UserFollowListModel.h"


NSString *const kUserFollowListModelUserAge = @"userAge";
NSString *const kUserFollowListModelUserSex = @"userSex";
NSString *const kUserFollowListModelUserCarlable = @"userCarlable";
NSString *const kUserFollowListModelUserAlipay = @"userAlipay";
NSString *const kUserFollowListModelUserPwd = @"userPwd";
NSString *const kUserFollowListModelUsercarPass = @"usercarPass";
NSString *const kUserFollowListModelUserNick = @"userNick";
NSString *const kUserFollowListModelUserDrivinglicense = @"userDrivinglicense";
NSString *const kUserFollowListModelUserTrueName = @"userTrueName";
NSString *const kUserFollowListModelUserCredit = @"userCredit";
NSString *const kUserFollowListModelUserDriverphoet = @"userDriverphoet";
NSString *const kUserFollowListModelUserPositionX = @"userPositionX";
NSString *const kUserFollowListModelUserPrivatephoto = @"userPrivatephoto";
NSString *const kUserFollowListModelUserDaty = @"userDaty";
NSString *const kUserFollowListModelUserPass = @"userPass";
NSString *const kUserFollowListModelUserPhone = @"userPhone";
NSString *const kUserFollowListModelUserAddress = @"userAddress";
NSString *const kUserFollowListModelUserCity = @"userCity";
NSString *const kUserFollowListModelUserSign = @"userSign";
NSString *const kUserFollowListModelUserPayPwd = @"userPayPwd";
NSString *const kUserFollowListModelUserCarphoto = @"userCarphoto";
NSString *const kUserFollowListModelUserCard = @"userCard";
NSString *const kUserFollowListModelUserState = @"userState";
NSString *const kUserFollowListModelUserPositionY = @"userPositionY";
NSString *const kUserFollowListModelUserCarinfo = @"userCarinfo";
NSString *const kUserFollowListModelUserCreatetime = @"userCreatetime";
NSString *const kUserFollowListModelUserHeader = @"userHeader";
NSString *const kUserFollowListModelUserYear = @"userYear";
NSString *const kUserFollowListModelUserBalance = @"userBalance";
NSString *const kUserFollowListModelUserProvince = @"userProvince";
NSString *const kUserFollowListModelUserJudge = @"userJudge";
NSString *const kUserFollowListModelUserName = @"userName";
NSString *const kUserFollowListModelUserMouth = @"userMouth";
NSString *const kUserFollowListModelUserId = @"userId";


@interface UserFollowListModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation UserFollowListModel

@synthesize userAge = _userAge;
@synthesize userSex = _userSex;
@synthesize userCarlable = _userCarlable;
@synthesize userAlipay = _userAlipay;
@synthesize userPwd = _userPwd;
@synthesize usercarPass = _usercarPass;
@synthesize userNick = _userNick;
@synthesize userDrivinglicense = _userDrivinglicense;
@synthesize userTrueName = _userTrueName;
@synthesize userCredit = _userCredit;
@synthesize userDriverphoet = _userDriverphoet;
@synthesize userPositionX = _userPositionX;
@synthesize userPrivatephoto = _userPrivatephoto;
@synthesize userDaty = _userDaty;
@synthesize userPass = _userPass;
@synthesize userPhone = _userPhone;
@synthesize userAddress = _userAddress;
@synthesize userCity = _userCity;
@synthesize userSign = _userSign;
@synthesize userPayPwd = _userPayPwd;
@synthesize userCarphoto = _userCarphoto;
@synthesize userCard = _userCard;
@synthesize userState = _userState;
@synthesize userPositionY = _userPositionY;
@synthesize userCarinfo = _userCarinfo;
@synthesize userCreatetime = _userCreatetime;
@synthesize userHeader = _userHeader;
@synthesize userYear = _userYear;
@synthesize userBalance = _userBalance;
@synthesize userProvince = _userProvince;
@synthesize userJudge = _userJudge;
@synthesize userName = _userName;
@synthesize userMouth = _userMouth;
@synthesize userId = _userId;


- (NSString *)userAge {//copy and paste
    if (!_userAge || [_userAge isEqual:[NSNull null]]) {
        return @"";
    }
    return _userAge;
}

- (NSString *)userProvince {
    if (!_userProvince || [_userProvince isEqual:[NSNull null]]) {
        return @"";
    }
    return _userProvince;
}

- (NSString *)userCity {
    if (!_userCity  || [_userCity isEqual:[NSNull null]]) {
        return @"";
    }
    return _userCity;
}

- (NSString *)userCredit {
    if (!_userCredit  || [_userCredit isEqual:[NSNull null]]) {
        return @"";
    }
    return _userCity;
}

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
            self.userAge = [self objectOrNilForKey:kUserFollowListModelUserAge fromDictionary:dict];
            self.userSex = [self objectOrNilForKey:kUserFollowListModelUserSex fromDictionary:dict];
            self.userCarlable = [self objectOrNilForKey:kUserFollowListModelUserCarlable fromDictionary:dict];
            self.userAlipay = [self objectOrNilForKey:kUserFollowListModelUserAlipay fromDictionary:dict];
            self.userPwd = [self objectOrNilForKey:kUserFollowListModelUserPwd fromDictionary:dict];
            self.usercarPass = [[self objectOrNilForKey:kUserFollowListModelUsercarPass fromDictionary:dict] integerValue];
            self.userNick = [self objectOrNilForKey:kUserFollowListModelUserNick fromDictionary:dict];
            self.userDrivinglicense = [self objectOrNilForKey:kUserFollowListModelUserDrivinglicense fromDictionary:dict];
            self.userTrueName = [self objectOrNilForKey:kUserFollowListModelUserTrueName fromDictionary:dict];
            self.userCredit = [self objectOrNilForKey:kUserFollowListModelUserCredit fromDictionary:dict];
            self.userDriverphoet = [self objectOrNilForKey:kUserFollowListModelUserDriverphoet fromDictionary:dict];
            self.userPositionX = [self objectOrNilForKey:kUserFollowListModelUserPositionX fromDictionary:dict];
            self.userPrivatephoto = [self objectOrNilForKey:kUserFollowListModelUserPrivatephoto fromDictionary:dict];
            self.userDaty = [self objectOrNilForKey:kUserFollowListModelUserDaty fromDictionary:dict];
            self.userPass = [[self objectOrNilForKey:kUserFollowListModelUserPass fromDictionary:dict] integerValue];
            self.userPhone = [self objectOrNilForKey:kUserFollowListModelUserPhone fromDictionary:dict];
            self.userAddress = [self objectOrNilForKey:kUserFollowListModelUserAddress fromDictionary:dict];
            self.userCity = [self objectOrNilForKey:kUserFollowListModelUserCity fromDictionary:dict];
            self.userSign = [self objectOrNilForKey:kUserFollowListModelUserSign fromDictionary:dict];
            self.userPayPwd = [self objectOrNilForKey:kUserFollowListModelUserPayPwd fromDictionary:dict];
            self.userCarphoto = [self objectOrNilForKey:kUserFollowListModelUserCarphoto fromDictionary:dict];
            self.userCard = [self objectOrNilForKey:kUserFollowListModelUserCard fromDictionary:dict];
            self.userState = [self objectOrNilForKey:kUserFollowListModelUserState fromDictionary:dict];
            self.userPositionY = [self objectOrNilForKey:kUserFollowListModelUserPositionY fromDictionary:dict];
            self.userCarinfo = [self objectOrNilForKey:kUserFollowListModelUserCarinfo fromDictionary:dict];
            self.userCreatetime = [[self objectOrNilForKey:kUserFollowListModelUserCreatetime fromDictionary:dict] doubleValue];
            self.userHeader = [self objectOrNilForKey:kUserFollowListModelUserHeader fromDictionary:dict];
            self.userYear = [self objectOrNilForKey:kUserFollowListModelUserYear fromDictionary:dict];
            self.userBalance = [self objectOrNilForKey:kUserFollowListModelUserBalance fromDictionary:dict];
            self.userProvince = [self objectOrNilForKey:kUserFollowListModelUserProvince fromDictionary:dict];
            self.userJudge = [self objectOrNilForKey:kUserFollowListModelUserJudge fromDictionary:dict];
            self.userName = [self objectOrNilForKey:kUserFollowListModelUserName fromDictionary:dict];
            self.userMouth = [self objectOrNilForKey:kUserFollowListModelUserMouth fromDictionary:dict];
            self.userId = [self objectOrNilForKey:kUserFollowListModelUserId fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.userAge forKey:kUserFollowListModelUserAge];
    [mutableDict setValue:self.userSex forKey:kUserFollowListModelUserSex];
    [mutableDict setValue:self.userCarlable forKey:kUserFollowListModelUserCarlable];
    [mutableDict setValue:self.userAlipay forKey:kUserFollowListModelUserAlipay];
    [mutableDict setValue:self.userPwd forKey:kUserFollowListModelUserPwd];
    [mutableDict setValue:[NSNumber numberWithDouble:self.usercarPass] forKey:kUserFollowListModelUsercarPass];
    [mutableDict setValue:self.userNick forKey:kUserFollowListModelUserNick];
    [mutableDict setValue:self.userDrivinglicense forKey:kUserFollowListModelUserDrivinglicense];
    [mutableDict setValue:self.userTrueName forKey:kUserFollowListModelUserTrueName];
    [mutableDict setValue:self.userCredit forKey:kUserFollowListModelUserCredit];
    [mutableDict setValue:self.userDriverphoet forKey:kUserFollowListModelUserDriverphoet];
    [mutableDict setValue:self.userPositionX forKey:kUserFollowListModelUserPositionX];
    [mutableDict setValue:self.userPrivatephoto forKey:kUserFollowListModelUserPrivatephoto];
    [mutableDict setValue:self.userDaty forKey:kUserFollowListModelUserDaty];
    [mutableDict setValue:[NSNumber numberWithDouble:self.userPass] forKey:kUserFollowListModelUserPass];
    [mutableDict setValue:self.userPhone forKey:kUserFollowListModelUserPhone];
    [mutableDict setValue:self.userAddress forKey:kUserFollowListModelUserAddress];
    [mutableDict setValue:self.userCity forKey:kUserFollowListModelUserCity];
    [mutableDict setValue:self.userSign forKey:kUserFollowListModelUserSign];
    [mutableDict setValue:self.userPayPwd forKey:kUserFollowListModelUserPayPwd];
    [mutableDict setValue:self.userCarphoto forKey:kUserFollowListModelUserCarphoto];
    [mutableDict setValue:self.userCard forKey:kUserFollowListModelUserCard];
    [mutableDict setValue:self.userState forKey:kUserFollowListModelUserState];
    [mutableDict setValue:self.userPositionY forKey:kUserFollowListModelUserPositionY];
    [mutableDict setValue:self.userCarinfo forKey:kUserFollowListModelUserCarinfo];
    [mutableDict setValue:[NSNumber numberWithDouble:self.userCreatetime] forKey:kUserFollowListModelUserCreatetime];
    [mutableDict setValue:self.userHeader forKey:kUserFollowListModelUserHeader];
    [mutableDict setValue:self.userYear forKey:kUserFollowListModelUserYear];
    [mutableDict setValue:self.userBalance forKey:kUserFollowListModelUserBalance];
    [mutableDict setValue:self.userProvince forKey:kUserFollowListModelUserProvince];
    [mutableDict setValue:self.userJudge forKey:kUserFollowListModelUserJudge];
    [mutableDict setValue:self.userName forKey:kUserFollowListModelUserName];
    [mutableDict setValue:self.userMouth forKey:kUserFollowListModelUserMouth];
    [mutableDict setValue:self.userId forKey:kUserFollowListModelUserId];

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

    self.userAge = [aDecoder decodeObjectForKey:kUserFollowListModelUserAge];
    self.userSex = [aDecoder decodeObjectForKey:kUserFollowListModelUserSex];
    self.userCarlable = [aDecoder decodeObjectForKey:kUserFollowListModelUserCarlable];
    self.userAlipay = [aDecoder decodeObjectForKey:kUserFollowListModelUserAlipay];
    self.userPwd = [aDecoder decodeObjectForKey:kUserFollowListModelUserPwd];
    self.usercarPass = [aDecoder decodeDoubleForKey:kUserFollowListModelUsercarPass];
    self.userNick = [aDecoder decodeObjectForKey:kUserFollowListModelUserNick];
    self.userDrivinglicense = [aDecoder decodeObjectForKey:kUserFollowListModelUserDrivinglicense];
    self.userTrueName = [aDecoder decodeObjectForKey:kUserFollowListModelUserTrueName];
    self.userCredit = [aDecoder decodeObjectForKey:kUserFollowListModelUserCredit];
    self.userDriverphoet = [aDecoder decodeObjectForKey:kUserFollowListModelUserDriverphoet];
    self.userPositionX = [aDecoder decodeObjectForKey:kUserFollowListModelUserPositionX];
    self.userPrivatephoto = [aDecoder decodeObjectForKey:kUserFollowListModelUserPrivatephoto];
    self.userDaty = [aDecoder decodeObjectForKey:kUserFollowListModelUserDaty];
    self.userPass = [aDecoder decodeDoubleForKey:kUserFollowListModelUserPass];
    self.userPhone = [aDecoder decodeObjectForKey:kUserFollowListModelUserPhone];
    self.userAddress = [aDecoder decodeObjectForKey:kUserFollowListModelUserAddress];
    self.userCity = [aDecoder decodeObjectForKey:kUserFollowListModelUserCity];
    self.userSign = [aDecoder decodeObjectForKey:kUserFollowListModelUserSign];
    self.userPayPwd = [aDecoder decodeObjectForKey:kUserFollowListModelUserPayPwd];
    self.userCarphoto = [aDecoder decodeObjectForKey:kUserFollowListModelUserCarphoto];
    self.userCard = [aDecoder decodeObjectForKey:kUserFollowListModelUserCard];
    self.userState = [aDecoder decodeObjectForKey:kUserFollowListModelUserState];
    self.userPositionY = [aDecoder decodeObjectForKey:kUserFollowListModelUserPositionY];
    self.userCarinfo = [aDecoder decodeObjectForKey:kUserFollowListModelUserCarinfo];
    self.userCreatetime = [aDecoder decodeDoubleForKey:kUserFollowListModelUserCreatetime];
    self.userHeader = [aDecoder decodeObjectForKey:kUserFollowListModelUserHeader];
    self.userYear = [aDecoder decodeObjectForKey:kUserFollowListModelUserYear];
    self.userBalance = [aDecoder decodeObjectForKey:kUserFollowListModelUserBalance];
    self.userProvince = [aDecoder decodeObjectForKey:kUserFollowListModelUserProvince];
    self.userJudge = [aDecoder decodeObjectForKey:kUserFollowListModelUserJudge];
    self.userName = [aDecoder decodeObjectForKey:kUserFollowListModelUserName];
    self.userMouth = [aDecoder decodeObjectForKey:kUserFollowListModelUserMouth];
    self.userId = [aDecoder decodeObjectForKey:kUserFollowListModelUserId];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_userAge forKey:kUserFollowListModelUserAge];
    [aCoder encodeObject:_userSex forKey:kUserFollowListModelUserSex];
    [aCoder encodeObject:_userCarlable forKey:kUserFollowListModelUserCarlable];
    [aCoder encodeObject:_userAlipay forKey:kUserFollowListModelUserAlipay];
    [aCoder encodeObject:_userPwd forKey:kUserFollowListModelUserPwd];
    [aCoder encodeDouble:_usercarPass forKey:kUserFollowListModelUsercarPass];
    [aCoder encodeObject:_userNick forKey:kUserFollowListModelUserNick];
    [aCoder encodeObject:_userDrivinglicense forKey:kUserFollowListModelUserDrivinglicense];
    [aCoder encodeObject:_userTrueName forKey:kUserFollowListModelUserTrueName];
    [aCoder encodeObject:_userCredit forKey:kUserFollowListModelUserCredit];
    [aCoder encodeObject:_userDriverphoet forKey:kUserFollowListModelUserDriverphoet];
    [aCoder encodeObject:_userPositionX forKey:kUserFollowListModelUserPositionX];
    [aCoder encodeObject:_userPrivatephoto forKey:kUserFollowListModelUserPrivatephoto];
    [aCoder encodeObject:_userDaty forKey:kUserFollowListModelUserDaty];
    [aCoder encodeDouble:_userPass forKey:kUserFollowListModelUserPass];
    [aCoder encodeObject:_userPhone forKey:kUserFollowListModelUserPhone];
    [aCoder encodeObject:_userAddress forKey:kUserFollowListModelUserAddress];
    [aCoder encodeObject:_userCity forKey:kUserFollowListModelUserCity];
    [aCoder encodeObject:_userSign forKey:kUserFollowListModelUserSign];
    [aCoder encodeObject:_userPayPwd forKey:kUserFollowListModelUserPayPwd];
    [aCoder encodeObject:_userCarphoto forKey:kUserFollowListModelUserCarphoto];
    [aCoder encodeObject:_userCard forKey:kUserFollowListModelUserCard];
    [aCoder encodeObject:_userState forKey:kUserFollowListModelUserState];
    [aCoder encodeObject:_userPositionY forKey:kUserFollowListModelUserPositionY];
    [aCoder encodeObject:_userCarinfo forKey:kUserFollowListModelUserCarinfo];
    [aCoder encodeDouble:_userCreatetime forKey:kUserFollowListModelUserCreatetime];
    [aCoder encodeObject:_userHeader forKey:kUserFollowListModelUserHeader];
    [aCoder encodeObject:_userYear forKey:kUserFollowListModelUserYear];
    [aCoder encodeObject:_userBalance forKey:kUserFollowListModelUserBalance];
    [aCoder encodeObject:_userProvince forKey:kUserFollowListModelUserProvince];
    [aCoder encodeObject:_userJudge forKey:kUserFollowListModelUserJudge];
    [aCoder encodeObject:_userName forKey:kUserFollowListModelUserName];
    [aCoder encodeObject:_userMouth forKey:kUserFollowListModelUserMouth];
    [aCoder encodeObject:_userId forKey:kUserFollowListModelUserId];
}

- (id)copyWithZone:(NSZone *)zone
{
    UserFollowListModel *copy = [[UserFollowListModel alloc] init];
    
    if (copy) {

        copy.userAge = [self.userAge copyWithZone:zone];
        copy.userSex = [self.userSex copyWithZone:zone];
        copy.userCarlable = [self.userCarlable copyWithZone:zone];
        copy.userAlipay = [self.userAlipay copyWithZone:zone];
        copy.userPwd = [self.userPwd copyWithZone:zone];
        copy.usercarPass = self.usercarPass;
        copy.userNick = [self.userNick copyWithZone:zone];
        copy.userDrivinglicense = [self.userDrivinglicense copyWithZone:zone];
        copy.userTrueName = [self.userTrueName copyWithZone:zone];
        copy.userCredit = [self.userCredit copyWithZone:zone];
        copy.userDriverphoet = [self.userDriverphoet copyWithZone:zone];
        copy.userPositionX = [self.userPositionX copyWithZone:zone];
        copy.userPrivatephoto = [self.userPrivatephoto copyWithZone:zone];
        copy.userDaty = [self.userDaty copyWithZone:zone];
        copy.userPass = self.userPass;
        copy.userPhone = [self.userPhone copyWithZone:zone];
        copy.userAddress = [self.userAddress copyWithZone:zone];
        copy.userCity = [self.userCity copyWithZone:zone];
        copy.userSign = [self.userSign copyWithZone:zone];
        copy.userPayPwd = [self.userPayPwd copyWithZone:zone];
        copy.userCarphoto = [self.userCarphoto copyWithZone:zone];
        copy.userCard = [self.userCard copyWithZone:zone];
        copy.userState = [self.userState copyWithZone:zone];
        copy.userPositionY = [self.userPositionY copyWithZone:zone];
        copy.userCarinfo = [self.userCarinfo copyWithZone:zone];
        copy.userCreatetime = self.userCreatetime;
        copy.userHeader = [self.userHeader copyWithZone:zone];
        copy.userYear = [self.userYear copyWithZone:zone];
        copy.userBalance = [self.userBalance copyWithZone:zone];
        copy.userProvince = [self.userProvince copyWithZone:zone];
        copy.userJudge = [self.userJudge copyWithZone:zone];
        copy.userName = [self.userName copyWithZone:zone];
        copy.userMouth = [self.userMouth copyWithZone:zone];
        copy.userId = [self.userId copyWithZone:zone];
    }
    
    return copy;
}


@end
