//
//  HobbyListModel.m
//
//  Created by likeSo  on 2016/12/24
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "HobbyListModel.h"


NSString *const kHobbyListModelLoveContent = @"loveContent";
NSString *const kHobbyListModelLoveCreatetime = @"loveCreatetime";
NSString *const kHobbyListModelLoveCreateter = @"loveCreateter";
NSString *const kHobbyListModelLoveId = @"loveId";


@interface HobbyListModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation HobbyListModel

@synthesize loveContent = _loveContent;
@synthesize loveCreatetime = _loveCreatetime;
@synthesize loveCreateter = _loveCreateter;
@synthesize loveId = _loveId;


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
            self.loveContent = [self objectOrNilForKey:kHobbyListModelLoveContent fromDictionary:dict];
            self.loveCreatetime = [[self objectOrNilForKey:kHobbyListModelLoveCreatetime fromDictionary:dict] doubleValue];
            self.loveCreateter = [self objectOrNilForKey:kHobbyListModelLoveCreateter fromDictionary:dict];
            self.loveId = [self objectOrNilForKey:kHobbyListModelLoveId fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.loveContent forKey:kHobbyListModelLoveContent];
    [mutableDict setValue:[NSNumber numberWithDouble:self.loveCreatetime] forKey:kHobbyListModelLoveCreatetime];
    [mutableDict setValue:self.loveCreateter forKey:kHobbyListModelLoveCreateter];
    [mutableDict setValue:self.loveId forKey:kHobbyListModelLoveId];

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

    self.loveContent = [aDecoder decodeObjectForKey:kHobbyListModelLoveContent];
    self.loveCreatetime = [aDecoder decodeDoubleForKey:kHobbyListModelLoveCreatetime];
    self.loveCreateter = [aDecoder decodeObjectForKey:kHobbyListModelLoveCreateter];
    self.loveId = [aDecoder decodeObjectForKey:kHobbyListModelLoveId];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_loveContent forKey:kHobbyListModelLoveContent];
    [aCoder encodeDouble:_loveCreatetime forKey:kHobbyListModelLoveCreatetime];
    [aCoder encodeObject:_loveCreateter forKey:kHobbyListModelLoveCreateter];
    [aCoder encodeObject:_loveId forKey:kHobbyListModelLoveId];
}

- (id)copyWithZone:(NSZone *)zone
{
    HobbyListModel *copy = [[HobbyListModel alloc] init];
    
    if (copy) {

        copy.loveContent = [self.loveContent copyWithZone:zone];
        copy.loveCreatetime = self.loveCreatetime;
        copy.loveCreateter = [self.loveCreateter copyWithZone:zone];
        copy.loveId = [self.loveId copyWithZone:zone];
    }
    
    return copy;
}


@end
