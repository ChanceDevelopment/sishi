//
//  ImageBannerView.h
//  sishi
//
//  Created by likeSo on 2016/12/15.
//  Copyright © 2016年 Channce. All rights reserved.
//

#import <UIKit/UIKit.h>

//首页单元格图片展示View
@interface ImageBannerView : UIView

/**
 *  图片图片链接数组
 */
@property(nonatomic,copy)NSArray <NSString *>*imageLinkGroup;

/**
 *  图片展示区域距离当前View左右两端的距离
 */
@property(nonatomic,assign)CGFloat padding;

@end
