//
//  LabelSelectView.h
//  sishi
//
//  Created by likeSo on 2016/12/15.
//  Copyright © 2016年 Channce. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^LabelSelectViewViewHeightChangeCallBack)(CGFloat viewHeight);

@class LabelSelectView;
@protocol LabelSelectViewDelegate <NSObject>
@optional
- (void)labelView:(LabelSelectView *)labelView didAddLabelName:(NSString *)labelName;

- (void)labelView:(LabelSelectView *)labelView didRemoveLabelName:(NSString *)labelName;

@end

@interface LabelSelectView : UICollectionView


/**
 *  代理
 */
@property(nonatomic,weak)id<LabelSelectViewDelegate> labelViewDelegate;

/**
 *  当设置标签之后回调,参数是目标标签View的高度
 */
@property(nonatomic,copy)LabelSelectViewViewHeightChangeCallBack onChangeHeight;

/**
 *  标签列表,设置此属性用于配置标签可选择信息
 */
@property(nonatomic,strong)NSArray <NSString *>* labelList;

/**
 *  已选中的标签列表
 */
@property(nonatomic,readonly)NSArray <NSString *>* selectedLabelList;


/**
 *  标签显示的字体,需要先设置此属性在设置标签列表
 */
@property(nonatomic,strong)UIFont *labelFont;

- (instancetype)initWithFrame:(CGRect)frame;

///删除指定的标签名
- (void)removeLabelWithName:(NSString *)labelName;


/**
 根据标签列表获取在指定宽度下的

 @param labels 标签列表
 */
- (CGFloat)labelViewHeightForLabels:(NSArray <NSString *>*)labels targetRectWidth:(CGFloat)rectWidth;


@end
