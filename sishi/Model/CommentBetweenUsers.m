//
//  CommentBetweenUsers.m
//
//  Created by likeSo  on 2016/12/25
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "CommentBetweenUsers.h"


NSString *const kCommentBetweenUsersUserId = @"userId";
NSString *const kCommentBetweenUsersUserNick = @"userNick";
NSString *const kCommentBetweenUsersEvaluateInfoToMe = @"evaluateInfoToMe";
NSString *const kCommentBetweenUsersEvaluateInfoMeTo = @"evaluateInfoMeTo";
NSString *const kCommentBetweenUsersUserCarlable = @"userCarlable";
NSString *const kCommentBetweenUsersUserSex = @"userSex";
NSString *const kCommentBetweenUsersUserAge = @"userAge";
NSString *const kCommentBetweenUsersUserHeader = @"userHeader";


@interface CommentBetweenUsers ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CommentBetweenUsers

@synthesize userId = _userId;
@synthesize userNick = _userNick;
@synthesize evaluateInfoToMe = _evaluateInfoToMe;
@synthesize evaluateInfoMeTo = _evaluateInfoMeTo;
@synthesize userCarlable = _userCarlable;
@synthesize userSex = _userSex;
@synthesize userAge = _userAge;
@synthesize userHeader = _userHeader;


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
            self.userId = [self objectOrNilForKey:kCommentBetweenUsersUserId fromDictionary:dict];
            self.userNick = [self objectOrNilForKey:kCommentBetweenUsersUserNick fromDictionary:dict];
            self.evaluateInfoToMe = [self objectOrNilForKey:kCommentBetweenUsersEvaluateInfoToMe fromDictionary:dict];
            self.evaluateInfoMeTo = [self objectOrNilForKey:kCommentBetweenUsersEvaluateInfoMeTo fromDictionary:dict];
            self.userCarlable = [self objectOrNilForKey:kCommentBetweenUsersUserCarlable fromDictionary:dict];
            self.userSex = [self objectOrNilForKey:kCommentBetweenUsersUserSex fromDictionary:dict];
            self.userAge = [self objectOrNilForKey:kCommentBetweenUsersUserAge fromDictionary:dict];
            self.userHeader = [self objectOrNilForKey:kCommentBetweenUsersUserHeader fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.userId forKey:kCommentBetweenUsersUserId];
    [mutableDict setValue:self.userNick forKey:kCommentBetweenUsersUserNick];
    [mutableDict setValue:self.evaluateInfoToMe forKey:kCommentBetweenUsersEvaluateInfoToMe];
    [mutableDict setValue:self.evaluateInfoMeTo forKey:kCommentBetweenUsersEvaluateInfoMeTo];
    [mutableDict setValue:self.userCarlable forKey:kCommentBetweenUsersUserCarlable];
    [mutableDict setValue:self.userSex forKey:kCommentBetweenUsersUserSex];
    [mutableDict setValue:self.userAge forKey:kCommentBetweenUsersUserAge];
    [mutableDict setValue:self.userHeader forKey:kCommentBetweenUsersUserHeader];

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

    self.userId = [aDecoder decodeObjectForKey:kCommentBetweenUsersUserId];
    self.userNick = [aDecoder decodeObjectForKey:kCommentBetweenUsersUserNick];
    self.evaluateInfoToMe = [aDecoder decodeObjectForKey:kCommentBetweenUsersEvaluateInfoToMe];
    self.evaluateInfoMeTo = [aDecoder decodeObjectForKey:kCommentBetweenUsersEvaluateInfoMeTo];
    self.userCarlable = [aDecoder decodeObjectForKey:kCommentBetweenUsersUserCarlable];
    self.userSex = [aDecoder decodeObjectForKey:kCommentBetweenUsersUserSex];
    self.userAge = [aDecoder decodeObjectForKey:kCommentBetweenUsersUserAge];
    self.userHeader = [aDecoder decodeObjectForKey:kCommentBetweenUsersUserHeader];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_userId forKey:kCommentBetweenUsersUserId];
    [aCoder encodeObject:_userNick forKey:kCommentBetweenUsersUserNick];
    [aCoder encodeObject:_evaluateInfoToMe forKey:kCommentBetweenUsersEvaluateInfoToMe];
    [aCoder encodeObject:_evaluateInfoMeTo forKey:kCommentBetweenUsersEvaluateInfoMeTo];
    [aCoder encodeObject:_userCarlable forKey:kCommentBetweenUsersUserCarlable];
    [aCoder encodeObject:_userSex forKey:kCommentBetweenUsersUserSex];
    [aCoder encodeObject:_userAge forKey:kCommentBetweenUsersUserAge];
    [aCoder encodeObject:_userHeader forKey:kCommentBetweenUsersUserHeader];
}

- (id)copyWithZone:(NSZone *)zone
{
    CommentBetweenUsers *copy = [[CommentBetweenUsers alloc] init];
    
    if (copy) {

        copy.userId = [self.userId copyWithZone:zone];
        copy.userNick = [self.userNick copyWithZone:zone];
        copy.evaluateInfoToMe = [self.evaluateInfoToMe copyWithZone:zone];
        copy.evaluateInfoMeTo = [self.evaluateInfoMeTo copyWithZone:zone];
        copy.userCarlable = [self.userCarlable copyWithZone:zone];
        copy.userSex = [self.userSex copyWithZone:zone];
        copy.userAge = [self.userAge copyWithZone:zone];
        copy.userHeader = [self.userHeader copyWithZone:zone];
    }
    
    return copy;
}


@end
