//
//  LoginUserInfoModel.m
//
//  Created by likeSo  on 2016/12/22
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "LoginUserInfoModel.h"


NSString *const kLoginUserInfoModelUserAge = @"userAge";
NSString *const kLoginUserInfoModelUserSex = @"userSex";
NSString *const kLoginUserInfoModelUserCarlable = @"userCarlable";
NSString *const kLoginUserInfoModelUserAlipay = @"userAlipay";
NSString *const kLoginUserInfoModelUserPwd = @"userPwd";
NSString *const kLoginUserInfoModelUsercarPass = @"usercarPass";
NSString *const kLoginUserInfoModelUserNick = @"userNick";
NSString *const kLoginUserInfoModelUserDrivinglicense = @"userDrivinglicense";
NSString *const kLoginUserInfoModelUserTrueName = @"userTrueName";
NSString *const kLoginUserInfoModelUserCredit = @"userCredit";
NSString *const kLoginUserInfoModelUserDriverphoet = @"userDriverphoet";
NSString *const kLoginUserInfoModelUserPositionX = @"userPositionX";
NSString *const kLoginUserInfoModelUserPrivatephoto = @"userPrivatephoto";
NSString *const kLoginUserInfoModelUserDaty = @"userDaty";
NSString *const kLoginUserInfoModelUserPass = @"userPass";
NSString *const kLoginUserInfoModelUserPhone = @"userPhone";
NSString *const kLoginUserInfoModelUserAddress = @"userAddress";
NSString *const kLoginUserInfoModelUserCity = @"userCity";
NSString *const kLoginUserInfoModelUserSign = @"userSign";
NSString *const kLoginUserInfoModelUserPayPwd = @"userPayPwd";
NSString *const kLoginUserInfoModelUserCarphoto = @"userCarphoto";
NSString *const kLoginUserInfoModelUserCard = @"userCard";
NSString *const kLoginUserInfoModelUserState = @"userState";
NSString *const kLoginUserInfoModelUserPositionY = @"userPositionY";
NSString *const kLoginUserInfoModelUserCarinfo = @"userCarinfo";
NSString *const kLoginUserInfoModelUserCreatetime = @"userCreatetime";
NSString *const kLoginUserInfoModelUserHeader = @"userHeader";
NSString *const kLoginUserInfoModelUserYear = @"userYear";
NSString *const kLoginUserInfoModelUserBalance = @"userBalance";
NSString *const kLoginUserInfoModelUserProvince = @"userProvince";
NSString *const kLoginUserInfoModelUserJudge = @"userJudge";
NSString *const kLoginUserInfoModelUserName = @"userName";
NSString *const kLoginUserInfoModelUserMouth = @"userMouth";
NSString *const kLoginUserInfoModelUserId = @"userId";


@interface LoginUserInfoModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LoginUserInfoModel

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
            self.userAge = [self objectOrNilForKey:kLoginUserInfoModelUserAge fromDictionary:dict];
            self.userSex = [self objectOrNilForKey:kLoginUserInfoModelUserSex fromDictionary:dict];
            self.userCarlable = [self objectOrNilForKey:kLoginUserInfoModelUserCarlable fromDictionary:dict];
            self.userAlipay = [self objectOrNilForKey:kLoginUserInfoModelUserAlipay fromDictionary:dict];
            self.userPwd = [self objectOrNilForKey:kLoginUserInfoModelUserPwd fromDictionary:dict];
            self.usercarPass = [self objectOrNilForKey:kLoginUserInfoModelUsercarPass fromDictionary:dict];
            self.userNick = [self objectOrNilForKey:kLoginUserInfoModelUserNick fromDictionary:dict];
            self.userDrivinglicense = [self objectOrNilForKey:kLoginUserInfoModelUserDrivinglicense fromDictionary:dict];
            self.userTrueName = [self objectOrNilForKey:kLoginUserInfoModelUserTrueName fromDictionary:dict];
            self.userCredit = [self objectOrNilForKey:kLoginUserInfoModelUserCredit fromDictionary:dict];
            self.userDriverphoet = [self objectOrNilForKey:kLoginUserInfoModelUserDriverphoet fromDictionary:dict];
            self.userPositionX = [[self objectOrNilForKey:kLoginUserInfoModelUserPositionX fromDictionary:dict] doubleValue];
            self.userPrivatephoto = [self objectOrNilForKey:kLoginUserInfoModelUserPrivatephoto fromDictionary:dict];
            self.userDaty = [self objectOrNilForKey:kLoginUserInfoModelUserDaty fromDictionary:dict];
            self.userPass = [self objectOrNilForKey:kLoginUserInfoModelUserPass fromDictionary:dict];
            self.userPhone = [self objectOrNilForKey:kLoginUserInfoModelUserPhone fromDictionary:dict];
            self.userAddress = [self objectOrNilForKey:kLoginUserInfoModelUserAddress fromDictionary:dict];
            self.userCity = [self objectOrNilForKey:kLoginUserInfoModelUserCity fromDictionary:dict];
            self.userSign = [self objectOrNilForKey:kLoginUserInfoModelUserSign fromDictionary:dict];
            self.userPayPwd = [self objectOrNilForKey:kLoginUserInfoModelUserPayPwd fromDictionary:dict];
            self.userCarphoto = [self objectOrNilForKey:kLoginUserInfoModelUserCarphoto fromDictionary:dict];
            self.userCard = [self objectOrNilForKey:kLoginUserInfoModelUserCard fromDictionary:dict];
            self.userState = [self objectOrNilForKey:kLoginUserInfoModelUserState fromDictionary:dict];
            self.userPositionY = [[self objectOrNilForKey:kLoginUserInfoModelUserPositionY fromDictionary:dict] doubleValue];
            self.userCarinfo = [self objectOrNilForKey:kLoginUserInfoModelUserCarinfo fromDictionary:dict];
            self.userCreatetime = [[self objectOrNilForKey:kLoginUserInfoModelUserCreatetime fromDictionary:dict] doubleValue];
            self.userHeader = [self objectOrNilForKey:kLoginUserInfoModelUserHeader fromDictionary:dict];
            self.userYear = [self objectOrNilForKey:kLoginUserInfoModelUserYear fromDictionary:dict];
            self.userBalance = [self objectOrNilForKey:kLoginUserInfoModelUserBalance fromDictionary:dict];
            self.userProvince = [self objectOrNilForKey:kLoginUserInfoModelUserProvince fromDictionary:dict];
            self.userJudge = [self objectOrNilForKey:kLoginUserInfoModelUserJudge fromDictionary:dict];
            self.userName = [self objectOrNilForKey:kLoginUserInfoModelUserName fromDictionary:dict];
            self.userMouth = [self objectOrNilForKey:kLoginUserInfoModelUserMouth fromDictionary:dict];
            self.userId = [self objectOrNilForKey:kLoginUserInfoModelUserId fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.userAge forKey:kLoginUserInfoModelUserAge];
    [mutableDict setValue:self.userSex forKey:kLoginUserInfoModelUserSex];
    [mutableDict setValue:self.userCarlable forKey:kLoginUserInfoModelUserCarlable];
    [mutableDict setValue:self.userAlipay forKey:kLoginUserInfoModelUserAlipay];
    [mutableDict setValue:self.userPwd forKey:kLoginUserInfoModelUserPwd];
    [mutableDict setValue:self.usercarPass forKey:kLoginUserInfoModelUsercarPass];
    [mutableDict setValue:self.userNick forKey:kLoginUserInfoModelUserNick];
    [mutableDict setValue:self.userDrivinglicense forKey:kLoginUserInfoModelUserDrivinglicense];
    [mutableDict setValue:self.userTrueName forKey:kLoginUserInfoModelUserTrueName];
    [mutableDict setValue:self.userCredit forKey:kLoginUserInfoModelUserCredit];
    [mutableDict setValue:self.userDriverphoet forKey:kLoginUserInfoModelUserDriverphoet];
    [mutableDict setValue:[NSNumber numberWithDouble:self.userPositionX] forKey:kLoginUserInfoModelUserPositionX];
    [mutableDict setValue:self.userPrivatephoto forKey:kLoginUserInfoModelUserPrivatephoto];
    [mutableDict setValue:self.userDaty forKey:kLoginUserInfoModelUserDaty];
    [mutableDict setValue:self.userPass forKey:kLoginUserInfoModelUserPass];
    [mutableDict setValue:self.userPhone forKey:kLoginUserInfoModelUserPhone];
    [mutableDict setValue:self.userAddress forKey:kLoginUserInfoModelUserAddress];
    [mutableDict setValue:self.userCity forKey:kLoginUserInfoModelUserCity];
    [mutableDict setValue:self.userSign forKey:kLoginUserInfoModelUserSign];
    [mutableDict setValue:self.userPayPwd forKey:kLoginUserInfoModelUserPayPwd];
    [mutableDict setValue:self.userCarphoto forKey:kLoginUserInfoModelUserCarphoto];
    [mutableDict setValue:self.userCard forKey:kLoginUserInfoModelUserCard];
    [mutableDict setValue:self.userState forKey:kLoginUserInfoModelUserState];
    [mutableDict setValue:[NSNumber numberWithDouble:self.userPositionY] forKey:kLoginUserInfoModelUserPositionY];
    [mutableDict setValue:self.userCarinfo forKey:kLoginUserInfoModelUserCarinfo];
    [mutableDict setValue:[NSNumber numberWithDouble:self.userCreatetime] forKey:kLoginUserInfoModelUserCreatetime];
    [mutableDict setValue:self.userHeader forKey:kLoginUserInfoModelUserHeader];
    [mutableDict setValue:self.userYear forKey:kLoginUserInfoModelUserYear];
    [mutableDict setValue:self.userBalance forKey:kLoginUserInfoModelUserBalance];
    [mutableDict setValue:self.userProvince forKey:kLoginUserInfoModelUserProvince];
    [mutableDict setValue:self.userJudge forKey:kLoginUserInfoModelUserJudge];
    [mutableDict setValue:self.userName forKey:kLoginUserInfoModelUserName];
    [mutableDict setValue:self.userMouth forKey:kLoginUserInfoModelUserMouth];
    [mutableDict setValue:self.userId forKey:kLoginUserInfoModelUserId];

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

    self.userAge = [aDecoder decodeObjectForKey:kLoginUserInfoModelUserAge];
    self.userSex = [aDecoder decodeObjectForKey:kLoginUserInfoModelUserSex];
    self.userCarlable = [aDecoder decodeObjectForKey:kLoginUserInfoModelUserCarlable];
    self.userAlipay = [aDecoder decodeObjectForKey:kLoginUserInfoModelUserAlipay];
    self.userPwd = [aDecoder decodeObjectForKey:kLoginUserInfoModelUserPwd];
    self.usercarPass = [aDecoder decodeObjectForKey:kLoginUserInfoModelUsercarPass];
    self.userNick = [aDecoder decodeObjectForKey:kLoginUserInfoModelUserNick];
    self.userDrivinglicense = [aDecoder decodeObjectForKey:kLoginUserInfoModelUserDrivinglicense];
    self.userTrueName = [aDecoder decodeObjectForKey:kLoginUserInfoModelUserTrueName];
    self.userCredit = [aDecoder decodeObjectForKey:kLoginUserInfoModelUserCredit];
    self.userDriverphoet = [aDecoder decodeObjectForKey:kLoginUserInfoModelUserDriverphoet];
    self.userPositionX = [aDecoder decodeDoubleForKey:kLoginUserInfoModelUserPositionX];
    self.userPrivatephoto = [aDecoder decodeObjectForKey:kLoginUserInfoModelUserPrivatephoto];
    self.userDaty = [aDecoder decodeObjectForKey:kLoginUserInfoModelUserDaty];
    self.userPass = [aDecoder decodeObjectForKey:kLoginUserInfoModelUserPass];
    self.userPhone = [aDecoder decodeObjectForKey:kLoginUserInfoModelUserPhone];
    self.userAddress = [aDecoder decodeObjectForKey:kLoginUserInfoModelUserAddress];
    self.userCity = [aDecoder decodeObjectForKey:kLoginUserInfoModelUserCity];
    self.userSign = [aDecoder decodeObjectForKey:kLoginUserInfoModelUserSign];
    self.userPayPwd = [aDecoder decodeObjectForKey:kLoginUserInfoModelUserPayPwd];
    self.userCarphoto = [aDecoder decodeObjectForKey:kLoginUserInfoModelUserCarphoto];
    self.userCard = [aDecoder decodeObjectForKey:kLoginUserInfoModelUserCard];
    self.userState = [aDecoder decodeObjectForKey:kLoginUserInfoModelUserState];
    self.userPositionY = [aDecoder decodeDoubleForKey:kLoginUserInfoModelUserPositionY];
    self.userCarinfo = [aDecoder decodeObjectForKey:kLoginUserInfoModelUserCarinfo];
    self.userCreatetime = [aDecoder decodeDoubleForKey:kLoginUserInfoModelUserCreatetime];
    self.userHeader = [aDecoder decodeObjectForKey:kLoginUserInfoModelUserHeader];
    self.userYear = [aDecoder decodeObjectForKey:kLoginUserInfoModelUserYear];
    self.userBalance = [aDecoder decodeObjectForKey:kLoginUserInfoModelUserBalance];
    self.userProvince = [aDecoder decodeObjectForKey:kLoginUserInfoModelUserProvince];
    self.userJudge = [aDecoder decodeObjectForKey:kLoginUserInfoModelUserJudge];
    self.userName = [aDecoder decodeObjectForKey:kLoginUserInfoModelUserName];
    self.userMouth = [aDecoder decodeObjectForKey:kLoginUserInfoModelUserMouth];
    self.userId = [aDecoder decodeObjectForKey:kLoginUserInfoModelUserId];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_userAge forKey:kLoginUserInfoModelUserAge];
    [aCoder encodeObject:_userSex forKey:kLoginUserInfoModelUserSex];
    [aCoder encodeObject:_userCarlable forKey:kLoginUserInfoModelUserCarlable];
    [aCoder encodeObject:_userAlipay forKey:kLoginUserInfoModelUserAlipay];
    [aCoder encodeObject:_userPwd forKey:kLoginUserInfoModelUserPwd];
    [aCoder encodeObject:_usercarPass forKey:kLoginUserInfoModelUsercarPass];
    [aCoder encodeObject:_userNick forKey:kLoginUserInfoModelUserNick];
    [aCoder encodeObject:_userDrivinglicense forKey:kLoginUserInfoModelUserDrivinglicense];
    [aCoder encodeObject:_userTrueName forKey:kLoginUserInfoModelUserTrueName];
    [aCoder encodeObject:_userCredit forKey:kLoginUserInfoModelUserCredit];
    [aCoder encodeObject:_userDriverphoet forKey:kLoginUserInfoModelUserDriverphoet];
    [aCoder encodeDouble:_userPositionX forKey:kLoginUserInfoModelUserPositionX];
    [aCoder encodeObject:_userPrivatephoto forKey:kLoginUserInfoModelUserPrivatephoto];
    [aCoder encodeObject:_userDaty forKey:kLoginUserInfoModelUserDaty];
    [aCoder encodeObject:_userPass forKey:kLoginUserInfoModelUserPass];
    [aCoder encodeObject:_userPhone forKey:kLoginUserInfoModelUserPhone];
    [aCoder encodeObject:_userAddress forKey:kLoginUserInfoModelUserAddress];
    [aCoder encodeObject:_userCity forKey:kLoginUserInfoModelUserCity];
    [aCoder encodeObject:_userSign forKey:kLoginUserInfoModelUserSign];
    [aCoder encodeObject:_userPayPwd forKey:kLoginUserInfoModelUserPayPwd];
    [aCoder encodeObject:_userCarphoto forKey:kLoginUserInfoModelUserCarphoto];
    [aCoder encodeObject:_userCard forKey:kLoginUserInfoModelUserCard];
    [aCoder encodeObject:_userState forKey:kLoginUserInfoModelUserState];
    [aCoder encodeDouble:_userPositionY forKey:kLoginUserInfoModelUserPositionY];
    [aCoder encodeObject:_userCarinfo forKey:kLoginUserInfoModelUserCarinfo];
    [aCoder encodeDouble:_userCreatetime forKey:kLoginUserInfoModelUserCreatetime];
    [aCoder encodeObject:_userHeader forKey:kLoginUserInfoModelUserHeader];
    [aCoder encodeObject:_userYear forKey:kLoginUserInfoModelUserYear];
    [aCoder encodeObject:_userBalance forKey:kLoginUserInfoModelUserBalance];
    [aCoder encodeObject:_userProvince forKey:kLoginUserInfoModelUserProvince];
    [aCoder encodeObject:_userJudge forKey:kLoginUserInfoModelUserJudge];
    [aCoder encodeObject:_userName forKey:kLoginUserInfoModelUserName];
    [aCoder encodeObject:_userMouth forKey:kLoginUserInfoModelUserMouth];
    [aCoder encodeObject:_userId forKey:kLoginUserInfoModelUserId];
}

- (id)copyWithZone:(NSZone *)zone
{
    LoginUserInfoModel *copy = [[LoginUserInfoModel alloc] init];
    
    if (copy) {

        copy.userAge = [self.userAge copyWithZone:zone];
        copy.userSex = [self.userSex copyWithZone:zone];
        copy.userCarlable = [self.userCarlable copyWithZone:zone];
        copy.userAlipay = [self.userAlipay copyWithZone:zone];
        copy.userPwd = [self.userPwd copyWithZone:zone];
        copy.usercarPass = [self.usercarPass copyWithZone:zone];
        copy.userNick = [self.userNick copyWithZone:zone];
        copy.userDrivinglicense = [self.userDrivinglicense copyWithZone:zone];
        copy.userTrueName = [self.userTrueName copyWithZone:zone];
        copy.userCredit = [self.userCredit copyWithZone:zone];
        copy.userDriverphoet = [self.userDriverphoet copyWithZone:zone];
        copy.userPositionX = self.userPositionX;
        copy.userPrivatephoto = [self.userPrivatephoto copyWithZone:zone];
        copy.userDaty = [self.userDaty copyWithZone:zone];
        copy.userPass = [self.userPass copyWithZone:zone];
        copy.userPhone = [self.userPhone copyWithZone:zone];
        copy.userAddress = [self.userAddress copyWithZone:zone];
        copy.userCity = [self.userCity copyWithZone:zone];
        copy.userSign = [self.userSign copyWithZone:zone];
        copy.userPayPwd = [self.userPayPwd copyWithZone:zone];
        copy.userCarphoto = [self.userCarphoto copyWithZone:zone];
        copy.userCard = [self.userCard copyWithZone:zone];
        copy.userState = [self.userState copyWithZone:zone];
        copy.userPositionY = self.userPositionY;
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
