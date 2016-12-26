//
//  ImageAdder.m
//  sishi
//
//  Created by likeSo on 2016/12/16.
//  Copyright © 2016年 Channce. All rights reserved.
//

#import "ImageAdder.h"
#import "ImageAdderViewCell.h"
#import "Masonry.h"

@interface ImageAdder ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

/**
 *  添加图片 按钮
 */
@property(nonatomic,strong)UIButton *addBtn;

@end

@implementation ImageAdder

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"contentSize"];
}

- (UIButton *)addBtn {
    if (!_addBtn) {
        _addBtn  =[UIButton buttonWithType:UIButtonTypeSystem];
        [_addBtn setBackgroundImage:[UIImage imageNamed:@"add_pho.png"] forState:UIControlStateNormal];
        [_addBtn addTarget:self action:@selector(onAddImage:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}

- (NSMutableArray<UIImage *> *)imageList {
    if (!_imageList) {
        _imageList = [NSMutableArray array];
    }
    return _imageList;
}

- (instancetype)initWithFrame:(CGRect)frame {
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.minimumLineSpacing = 5.0;
    layout.minimumInteritemSpacing = 5.0;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
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
    [self registerClass:UICollectionViewCell.self forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [self registerClass:ImageAdderViewCell.self forCellWithReuseIdentifier:@"ImageAdderViewCell"];
    [self addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
}

#pragma mark :- ObserverCallBack

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if (self.onChangeHeight) {
        self.onChangeHeight(self.contentSize.height);
    }
}

#pragma mark :- UICollectionViewDelegate & DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.onlyShow) {
        return self.imageLinkGroup.count;
    } else {
        return self.imageList.count + 1;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.onlyShow) {
        return [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageAdderViewCell" forIndexPath:indexPath];
    } else {//非展示模式
        if (indexPath.item <= self.imageList.count - 1 && self.imageList.count >= 1) {
            return [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageAdderViewCell" forIndexPath:indexPath];
        } else {//展示图片
            UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
            [cell.contentView addSubview:self.addBtn];
            [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(cell.contentView);
            }];
            return cell;
        }
    }
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell isKindOfClass:[ImageAdderViewCell class]]) {
        if (!self.onlyShow) {
            ((ImageAdderViewCell *)cell).image = self.imageList[indexPath.item];
            kWeakSelf;
            ((ImageAdderViewCell *)cell).onRemoveImage = ^{
                if (weakSelf.imageAdderDelegate && [weakSelf.imageAdderDelegate respondsToSelector:@selector(imageAdder:willRemoveImageInList:atIndex:)]) {
                    [weakSelf.imageAdderDelegate imageAdder:self willRemoveImageInList:weakSelf.imageList atIndex:indexPath.item];
                }
                [weakSelf.imageList removeObjectAtIndex:indexPath.item];
                [weakSelf reloadSections:[NSIndexSet indexSetWithIndex:0]];
            };
        } else {
            ImageAdderViewCell *imageCell = (ImageAdderViewCell *)cell;
            imageCell.imageLink = self.imageLinkGroup[indexPath.item];
        }
    }
}


#pragma mark :- 添加图片按钮
- (void)onAddImage:(UIButton *)btn {
    if (self.imageList.count >= self.imageLimitCanAdd) {
        if (_imageLimitCanAdd >= 1) {
            return;
        }
    }
    if (self.imageAdderDelegate && [self.imageAdderDelegate respondsToSelector:@selector(imageAdder:addImageWithImageList:)]) {
        [self.imageAdderDelegate imageAdder:self addImageWithImageList:self.imageList];
    }
}

- (void)appendImage:(UIImage *)imageToAppend {//添加图片
    [self.imageList addObject:imageToAppend];
    [self reloadSections:[NSIndexSet indexSetWithIndex:0]];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
