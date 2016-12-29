//
//  ImageAdder.h
//  sishi
//
//  Created by likeSo on 2016/12/16.
//  Copyright © 2016年 Channce. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ImageAdderOnChangeViewHeightCallBack) (CGFloat viewheight);

@class ImageAdder;

@protocol ImageAdderAddImageProtocol <NSObject>

@optional
- (void)imageAdder:(ImageAdder *)imageAdder addImageWithImageList:(NSArray <UIImage *>*)imageList;

/**
 当onlyShow == false时回调此方法
 */
- (void)imageAdder:(ImageAdder *)imageAdder didSelectimageInList:(NSArray <UIImage *>*)imageList atIndex:(NSUInteger)index;

/**
 当onlyShow == true时回调此方法
 */
- (void)imageAdder:(ImageAdder *)imageAdder didSelectImageInStringList:(NSArray <NSString *>*)stringList atIndex:(NSUInteger)index;

- (void)imageAdder:(ImageAdder *)imageAdder willRemoveImageInList:(NSArray <UIImage *>*)imageList atIndex:(NSUInteger)index;

//当长按某下标图片时
- (void)imageAdder:(ImageAdder *)imageAdder longPressAtIndexPathRow:(NSUInteger)index;
@end

/**
 图片添加器
 */
@interface ImageAdder : UICollectionView

/**
 *  是否只作为展示模式
 */
@property(nonatomic,assign)BOOL onlyShow;

/**
 *  图片链接数组,仅当onlyShow == true时可用
 */
@property(nonatomic,strong)NSArray <NSString *>*imageLinkGroup;

/**
 *  可添加的图片数量
 */
@property(nonatomic,assign)NSUInteger imageLimitCanAdd;

/**
 *  代理
 */
@property(nonatomic,weak)id<ImageAdderAddImageProtocol> imageAdderDelegate;

/**
 *  单元格大小
 */
@property(nonatomic,assign)CGSize itemSize;

/**
 *  图片对象数组
 */
@property(nonatomic,copy)NSMutableArray <UIImage *>* imageList;

/**
 *  当View的高度改变时回调
 */
@property(nonatomic,copy)ImageAdderOnChangeViewHeightCallBack onChangeHeight;

- (instancetype)initWithFrame:(CGRect)frame;

- (void)appendImage:(UIImage *)imageToAppend;

@end
