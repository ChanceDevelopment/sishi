//
//  CommentBetweenUsers.h
//
//  Created by likeSo  on 2016/12/25
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface CommentBetweenUsers : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *userNick;
@property (nonatomic, strong) NSString *evaluateInfoToMe;
@property (nonatomic, strong) NSString *evaluateInfoMeTo;
@property (nonatomic, strong) NSString *userCarlable;
@property (nonatomic, strong) NSString *userSex;
@property (nonatomic, strong) NSString *userAge;
@property (nonatomic, strong) NSString *userHeader;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
