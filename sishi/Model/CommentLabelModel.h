//
//  CommentLabelModel.h
//
//  Created by 龙少  on 2016/12/28
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface CommentLabelModel : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *labelId;
@property (nonatomic, strong) NSString *labelContent;
@property (nonatomic, assign) double labelCreatetime;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
