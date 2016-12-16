//
//  ImageAdderViewCell.h
//  sishi
//
//  Created by likeSo on 2016/12/16.
//  Copyright © 2016年 Channce. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ImageAdderCellOnDeleteImageCallBack) ();


@interface ImageAdderViewCell : UICollectionViewCell
/**
 *  图片链接,当ImageAdder的onlyShow == true时使用
 */
@property(nonatomic,copy)NSString *imageLink;

/**
 *  图片文件
 */
@property(nonatomic,strong)UIImage *image;

/**
 *  删除图片回调
 */
@property(nonatomic,copy)ImageAdderCellOnDeleteImageCallBack onRemoveImage;


- (instancetype)initWithFrame:(CGRect)frame;
@end
