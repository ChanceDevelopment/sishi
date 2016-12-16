//
//  LabelSelectView.h
//  sishi
//
//  Created by likeSo on 2016/12/15.
//  Copyright © 2016年 Channce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LabelSelectView : UICollectionView

/**
 *  标签列表,设置此属性用于配置标签可选择信息
 */
@property(nonatomic,strong)NSArray <NSString *>* labelList;


- (instancetype)initWithFrame:(CGRect)frame;

@end
