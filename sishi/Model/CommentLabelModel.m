//
//  CommentLabelModel.m
//
//  Created by 龙少  on 2016/12/28
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "CommentLabelModel.h"


NSString *const kCommentLabelModelLabelId = @"labelId";
NSString *const kCommentLabelModelLabelContent = @"labelContent";
NSString *const kCommentLabelModelLabelCreatetime = @"labelCreatetime";


@interface CommentLabelModel ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation CommentLabelModel

@synthesize labelId = _labelId;
@synthesize labelContent = _labelContent;
@synthesize labelCreatetime = _labelCreatetime;


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
            self.labelId = [self objectOrNilForKey:kCommentLabelModelLabelId fromDictionary:dict];
            self.labelContent = [self objectOrNilForKey:kCommentLabelModelLabelContent fromDictionary:dict];
            self.labelCreatetime = [[self objectOrNilForKey:kCommentLabelModelLabelCreatetime fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.labelId forKey:kCommentLabelModelLabelId];
    [mutableDict setValue:self.labelContent forKey:kCommentLabelModelLabelContent];
    [mutableDict setValue:[NSNumber numberWithDouble:self.labelCreatetime] forKey:kCommentLabelModelLabelCreatetime];

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

    self.labelId = [aDecoder decodeObjectForKey:kCommentLabelModelLabelId];
    self.labelContent = [aDecoder decodeObjectForKey:kCommentLabelModelLabelContent];
    self.labelCreatetime = [aDecoder decodeDoubleForKey:kCommentLabelModelLabelCreatetime];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_labelId forKey:kCommentLabelModelLabelId];
    [aCoder encodeObject:_labelContent forKey:kCommentLabelModelLabelContent];
    [aCoder encodeDouble:_labelCreatetime forKey:kCommentLabelModelLabelCreatetime];
}

- (id)copyWithZone:(NSZone *)zone
{
    CommentLabelModel *copy = [[CommentLabelModel alloc] init];
    
    if (copy) {

        copy.labelId = [self.labelId copyWithZone:zone];
        copy.labelContent = [self.labelContent copyWithZone:zone];
        copy.labelCreatetime = self.labelCreatetime;
    }
    
    return copy;
}


@end
