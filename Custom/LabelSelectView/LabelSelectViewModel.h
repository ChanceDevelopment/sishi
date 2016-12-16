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

/**
 *  标签需要展示的文字的字体
 */
@property(nonatomic,strong)UIFont *font;

/**
 *  当前标签是否被点击
 */
@property(nonatomic,assign,getter=isSelected)BOOL selected;



- (instancetype)initWithLabelString:(NSString *)label font:(UIFont *)font;

@end
