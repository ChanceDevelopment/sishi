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

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"contentSize"];
}

- (NSMutableArray<LabelSelectViewModel *> *)modelList {
    if (!_modelList) {
        _modelList = [NSMutableArray array];
    }
    return _modelList;
}

//遍历标签列表,找到某一标签则删除该标签
- (void)removeLabelWithName:(NSString *)labelName {
    NSMutableArray <NSString *>* labelNameList = [NSMutableArray arrayWithArray:self.labelList];
    for (int i = 0; i < self.labelList.count; i ++) {
        NSString *indexLabelName = self.labelList[i];
        if ([indexLabelName isEqualToString:labelName]) {
            [labelNameList removeObjectAtIndex:i];
            self.labelList = [NSArray arrayWithArray:labelNameList];
            break;
        }
    }
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
        [self setupView];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupView];
}

- (void)setupView {
    self.delegate = self;
    self.dataSource = self;
    self.scrollEnabled = NO;
    [self registerClass:[LabelSelectViewCell class] forCellWithReuseIdentifier:@"LabelSelectViewCell"];
    [self addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    [(UICollectionViewLeftAlignedLayout *)self.collectionViewLayout setMinimumLineSpacing:5];
    [(UICollectionViewLeftAlignedLayout *)self.collectionViewLayout setMinimumInteritemSpacing:5];
}


#pragma mark :- Obsever
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (self.onChangeHeight) {
        self.onChangeHeight(self.contentSize.height);
    }
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
    BOOL isSelected = ![self.modelList objectAtIndex:indexPath.row].isSelected;
    [self.modelList objectAtIndex:indexPath.row].selected = isSelected;
    [self reloadItemsAtIndexPaths:@[indexPath]];
    if (isSelected) {
        if (self.labelViewDelegate && [self.labelViewDelegate respondsToSelector:@selector(labelView:didAddLabelName:)]) {
            [self.labelViewDelegate labelView:self didAddLabelName:self.labelList[indexPath.item]];//通知代理选中该下标下的标签
        }
    } else {
        if (self.labelViewDelegate && [self.labelViewDelegate respondsToSelector:@selector(labelView:didRemoveLabelName:)]) {
            [self.labelViewDelegate labelView:self didRemoveLabelName:self.labelList[indexPath.item]];
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
