//
//  LabelSelectViewCell.h
//  sishi
//
//  Created by likeSo on 2016/12/15.
//  Copyright © 2016年 Channce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "LabelSelectViewModel.h"

@interface LabelSelectViewCell : UICollectionViewCell

/**
 *  当前标签的Model
 */
@property(nonatomic,strong)LabelSelectViewModel *labelModel;


@end
