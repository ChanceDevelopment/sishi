//
//  ImageBannerView.h
//  sishi
//
//  Created by likeSo on 2016/12/15.
//  Copyright © 2016年 Channce. All rights reserved.
//

#import <UIKit/UIKit.h>






typedef void(^ImageBannerTapImageCallBack)(NSArray <NSString *>*imageLinkList,NSUInteger selectedIndex);
//typedef void(^ImageBannerTapImageCallBack)(NSString *imageName);

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

/**
 *  点击图片回调
 */
@property(nonatomic,copy)ImageBannerTapImageCallBack onTapImage;

/**
 *  单元格左右两边距离View顶端的距离
 */
@property(nonatomic,assign)CGFloat horizontalPadding;

@end



#pragma mark :- 图片展示 UICollectionView 自定义

@interface ImageBannerCollectionView : UICollectionView

@end




#pragma mark :- 图片展示单元格
@class ImageBannerCollectionViewCell;
typedef void(^ImageBannerCellOnTapImageCallBack)(ImageBannerCollectionViewCell *cell);

@interface ImageBannerCollectionViewCell : UICollectionViewCell
/**
 *  图片链接
 */
@property(nonatomic,strong)NSString *imagelink;

/**
 *  图片被点击时回调
 */
@property(nonatomic,copy)ImageBannerCellOnTapImageCallBack onImageTap;
@end
