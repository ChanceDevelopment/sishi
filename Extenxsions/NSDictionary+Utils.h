//
//  NSDictionary+Utils.h
//  sishi
//
//  Created by likeSo on 2017/1/5.
//  Copyright © 2017年 Channce. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Utils)

/**
 object for the key ,if nil ,it will return nilHandler if the value of key is nil

 @param key 要获取的key
 @param nilHandler 如果key的value为空,则返回此值
 @return -.-
 */
- (id)objectForKey:(NSString *)key ifNil:(id)nilHandler;
@end
