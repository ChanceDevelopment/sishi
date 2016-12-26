//
//  LabelSelectView.m
//  sishi
//
//  Created by likeSo on 2016/12/15.
//  Copyright © 2016年 Channce. All rights reserved.
//

#import "LabelSelectView.h"
#import "LabelSelectViewModel.h"
#import "LabelSelectViewCell.h"
#import "UICollectionViewLeftAlignedLayout.h"


@interface LabelSelectView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
/**
 *  标签Model列表
 */
@property(nonatomic,copy)NSMutableArray <LabelSelectViewModel *>*modelList;
@end

@implementation LabelSelectView

- (NSMutableArray<LabelSelectViewModel *> *)modelList {
    if (!_modelList) {
        _modelList = [NSMutableArray array];
    }
    return _modelList;
}


- (NSArray<NSString *> *)selectedLabelList {
    NSMutableArray <NSString *>* labelList = [NSMutableArray array];
    for (LabelSelectViewModel *labelModel in self.modelList) {
        if (labelModel.isSelected) {
                [labelList addObject:labelModel.labelString];
        }
    }
    return [NSArray arrayWithArray:labelList];
}

- (void)setLabelList:(NSArray<NSString *> *)labelList {
    _labelList = labelList;
    [self.modelList removeAllObjects];
    for (NSString *labelName in labelList) {
        LabelSelectViewModel *labelModel = [[LabelSelectViewModel alloc]initWithLabelString:labelName font:self.labelFont];
        [self.modelList addObject:labelModel];
    }
    [self reloadSections:[NSIndexSet indexSetWithIndex:0]];
}

- (instancetype)initWithFrame:(CGRect)frame {
    UICollectionViewLeftAlignedLayout *layout = [[UICollectionViewLeftAlignedLayout alloc]init];
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 5;
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        self.delegate = self;
        self.dataSource = self;
        self.scrollEnabled = NO;
        [self registerClass:[LabelSelectViewCell class] forCellWithReuseIdentifier:@"LabelSelectViewCell"];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.delegate = self;
    self.dataSource = self;
    self.scrollEnabled = NO;
    [self registerClass:[LabelSelectViewCell class] forCellWithReuseIdentifier:@"LabelSelectViewCell"];
    [(UICollectionViewLeftAlignedLayout *)self.collectionViewLayout setMinimumLineSpacing:5];
    [(UICollectionViewLeftAlignedLayout *)self.collectionViewLayout setMinimumInteritemSpacing:5];
}

#pragma mark :- Utils

- (CGFloat)labelViewHeightForLabels:(NSArray<NSString *> *)labels targetRectWidth:(CGFloat)rectWidth {
    NSUInteger lineCount = 1;
    CGFloat finalX = 0.0;
    CGFloat columeSpacing = 5.0;
    CGFloat itemHeight = 0.0;
    CGFloat lineSpacing = 5.0;
    for (NSString *labelName in labels) {
        LabelSelectViewModel *itemModel = [[LabelSelectViewModel alloc]initWithLabelString:labelName font:self.labelFont];
        if (itemHeight != itemModel.itemSize.height) {//获取每个单元格的高度
            itemHeight = itemModel.itemSize.height;
        }
        CGSize itemSize = itemModel.itemSize;
            if (rectWidth > itemSize.width + finalX + columeSpacing) {//可以放下当前的单元格
            finalX += itemSize.width + columeSpacing;
        } else {//放不下当前单元格,执行换行操作
            finalX = 0.0;
            lineCount += 1;
        }
    }
    CGFloat viewHeight = lineCount * itemHeight + (lineCount - 1) * lineSpacing;
    return viewHeight;
}


#pragma mark :- UICollectionViewDelegate & DataSource

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [collectionView dequeueReusableCellWithReuseIdentifier:@"LabelSelectViewCell" forIndexPath:indexPath];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.modelList.count;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(LabelSelectViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    cell.labelModel = self.modelList[indexPath.item];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.modelList[indexPath.item].itemSize;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.modelList objectAtIndex:indexPath.row].selected = ![self.modelList objectAtIndex:indexPath.row].isSelected;
    [self reloadItemsAtIndexPaths:@[indexPath]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
