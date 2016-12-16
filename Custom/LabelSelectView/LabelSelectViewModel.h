//
//  LabelSelectViewModel.h
//  sishi
//
//  Created by likeSo on 2016/12/15.
//  Copyright © 2016年 Channce. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LabelSelectViewModel : NSObject

/**
 *  标签名称
 */
@property(nonatomic,strong)NSString *labelString;

/**
 *  单元格大小
 */
@property(nonatomic,assign)CGSize itemSize;



- (instancetype)initWithLabelString:(NSString *)label;

@end
