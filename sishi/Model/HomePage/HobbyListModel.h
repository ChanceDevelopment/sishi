//
//  HobbyListModel.h
//
//  Created by likeSo  on 2016/12/24
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface HobbyListModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *loveContent;
@property (nonatomic, assign) double loveCreatetime;
@property (nonatomic, strong) NSString *loveCreateter;
@property (nonatomic, strong) NSString *loveId;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
