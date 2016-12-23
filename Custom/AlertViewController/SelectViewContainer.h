//
//  SelectViewContainer.h
//  sishi
//
//  Created by likeSo on 2016/12/23.
//  Copyright © 2016年 Channce. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectViewContainerCallBack)(void);

@interface SelectViewContainer : UIView
/**
 *  "确定"按钮 点击时回调
 */
@property(nonatomic,copy)SelectViewContainerCallBack onConfirm;

+ (SelectViewContainer *)defaultContainerView;

- (void)hide;


- (void)showWithContentView:(UIView *)subView withTitle:(NSString *)titleString;
@end
