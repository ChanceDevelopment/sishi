//
//  NSDictionary+Utils.m
//  sishi
//
//  Created by likeSo on 2017/1/5.
//  Copyright © 2017年 Channce. All rights reserved.
//

#import "NSDictionary+Utils.h"

@implementation NSDictionary (Utils)
- (id)objectForKey:(NSString *)key ifNil:(id)nilHandler {
    id valueOfKey = [self objectForKey:key];
    return valueOfKey ? valueOfKey : nilHandler;
}
@end
