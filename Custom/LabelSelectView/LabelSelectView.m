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


@interface LabelSelectView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
/**
 *  标签Model列表
 */
@property(nonatomic,copy)NSMutableArray <LabelSelectViewModel *>*modelList;
@end

@implementation LabelSelectView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[LabelSelectViewCell class] forCellWithReuseIdentifier:@"LabelSelectViewCell"];
    }
    return self;
}

#pragma mark :- UICollectionViewDelegate & DataSource

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [collectionView dequeueReusableCellWithReuseIdentifier:@"LabelSelectViewCell" forIndexPath:indexPath];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.modelList.count;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(LabelSelectViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    cell.labelString = [self.modelList[indexPath.item] labelString];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.modelList[indexPath.item].itemSize;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
