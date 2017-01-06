//
//  ImageBannerView.m
//  sishi
//
//  Created by likeSo on 2016/12/15.
//  Copyright © 2016年 Channce. All rights reserved.
//

#import "ImageBannerView.h"
#import "Masonry.h"
#import "UIButton+EMWebCache.h"

@interface ImageBannerView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
/**
 *  用于展示图片
 */
@property(nonatomic,strong)UIScrollView *scrollView;

/**
 *  左侧按钮
 */
@property(nonatomic,strong)UIButton *leftSideButton;

/**
 *  右侧按钮
 */
@property(nonatomic,strong)UIButton *rightSideButton;

/**
 *  当前展示的图片的下标
 */
@property(nonatomic,assign,readonly)NSInteger imageIndex;


/**
 *  下标指示器
 */
@property(nonatomic,strong)UIPageControl *pageControl;

/**
 *  集合视图用于展示图片内容
 */
@property(nonatomic,strong)ImageBannerCollectionView *collectionView;


@end

@implementation ImageBannerView

- (NSInteger)imageIndex {
    NSInteger index = 0;
    CGFloat scrollViewWidth = self.scrollView.bounds.size.width;
    if (self.scrollView.contentOffset.x != 0) {
        index = self.scrollView.contentOffset.x / scrollViewWidth;
    }
    return index;
}

- (void)dealloc
{
//    [self removeObserver:self forKeyPath:@"_scrollView.contentOffset"];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
//        self.padding = 10;
//        self.leftSideButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        self.leftSideButton.frame = CGRectMake(0, 0, self.padding, CGRectGetHeight(self.frame));
//        [self.leftSideButton addTarget:self action:@selector(onLeftSideAction:) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:self.leftSideButton];
//        
//        self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(self.padding, 0, CGRectGetWidth(self.frame) - self.padding * 2, CGRectGetHeight(frame))];
//        //self.scrollView.scrollEnabled = NO;
//        self.scrollView.pagingEnabled = YES;
//        self.scrollView.clipsToBounds = YES;
//        [self addSubview:self.scrollView];
//        
//        self.rightSideButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        self.rightSideButton.frame = CGRectMake(CGRectGetMaxX(self.scrollView.frame), 0, self.padding, CGRectGetHeight(self.frame));
//        [self.rightSideButton addTarget:self action:@selector(onRightSideAction:) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:self.rightSideButton];
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumInteritemSpacing = 10;
        self.collectionView = [[ImageBannerCollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
        self.collectionView.showsHorizontalScrollIndicator = YES;
        self.collectionView.backgroundColor = [UIColor whiteColor];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        [self addSubview:self.collectionView];
        self.collectionView.delaysContentTouches = NO;
        
        [self.collectionView registerClass:ImageBannerCollectionViewCell.self forCellWithReuseIdentifier:@"ImageBannerCollectionViewCell"];
        
        
//        self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame) - 14, CGRectGetWidth(self.frame), 14)];
//        self.pageControl.numberOfPages = 1;
//        self.pageControl.userInteractionEnabled = NO;
//        [self addSubview:self.pageControl];
//        [self addObserver:self forKeyPath:@"_scrollView.contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (void)setHorizontalPadding:(CGFloat)horizontalPadding {
    _horizontalPadding = horizontalPadding;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, horizontalPadding, 0, horizontalPadding);
}

#pragma mark :- 观察者,修改pageControl下标
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    self.pageControl.currentPage = self.imageIndex;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    [super setBackgroundColor:backgroundColor];
    self.leftSideButton.backgroundColor = backgroundColor;
    self.rightSideButton.backgroundColor = backgroundColor;
    self.scrollView.backgroundColor = backgroundColor;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.leftSideButton.frame = CGRectMake(0, 0, self.padding, CGRectGetHeight(self.frame));
    self.scrollView.frame = CGRectMake(self.padding, 0, CGRectGetWidth(self.frame) - self.padding * 2, CGRectGetHeight(self.frame));
    self.rightSideButton.frame =  self.rightSideButton.frame = CGRectMake(CGRectGetMaxX(self.scrollView.frame), 0, self.padding, CGRectGetHeight(self.frame));
    self.pageControl.frame = CGRectMake(0, CGRectGetHeight(self.frame) - 14, CGRectGetWidth(self.frame), 14);
}

#pragma mark :- side button actions 
- (void)onLeftSideAction:(UIButton *)btn {
    if (self.imageIndex == 0) {
        return;
    }
    CGFloat scrollViewWidth = self.scrollView.bounds.size.width;
    CGPoint contentOffset = CGPointMake(scrollViewWidth * (self.imageIndex - 1), 0);
    [self.scrollView setContentOffset:contentOffset animated:YES];
}

- (void)onRightSideAction:(UIButton *)btn {
    if (self.imageIndex >= self.imageLinkGroup.count - 1) {//到达最后一张图片
        return;
    }
    CGFloat scrollViewWidth = self.scrollView.bounds.size.width;
    CGPoint contentOffset = CGPointMake(scrollViewWidth * (self.imageIndex + 1), 0);
    [self.scrollView setContentOffset:contentOffset animated:YES];
}

- (void)setImageLinkGroup:(NSArray<NSString *> *)imageLinkGroup {
    _imageLinkGroup = imageLinkGroup;
//    for (UIView *subView in self.scrollView.subviews) {
//        [subView removeFromSuperview];
//    }
//    self.pageControl.numberOfPages = imageLinkGroup.count;
//    UIImage *placeHolderImage = [UIImage imageNamed:DEFAULTERRORIMAGE];
//    CGFloat scrollViewWidth = CGRectGetWidth(self.frame) - self.padding * 2;
//    for (NSInteger index = 0; index < imageLinkGroup.count; index ++) {
//        CGFloat originX = index * scrollViewWidth;
//        UIImageView *imageView =[[ UIImageView alloc]initWithFrame:CGRectMake(originX, 0, scrollViewWidth, CGRectGetHeight(self.frame))];
//        imageView.frame = CGRectMake(originX, 0, scrollViewWidth, CGRectGetHeight(self.frame));
//        imageView.contentMode = UIViewContentModeScaleAspectFill;
//        imageView.clipsToBounds = YES;
//        imageView.userInteractionEnabled = YES;
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTapImage:)];
//        [imageView addGestureRecognizer:tap];
//        imageView.tag = 10000 + index;
//        [imageView sd_setImageWithURL:[NSURL URLWithString:imageLinkGroup[index]] placeholderImage:placeHolderImage];
//        [self.scrollView addSubview:imageView];
//    }
//    [self.scrollView setContentOffset:CGPointZero animated:YES];
    [self.collectionView reloadData];
}
#pragma mark :- UICollectionViewDelegate & DataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageLinkGroup.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageBannerCollectionViewCell" forIndexPath:indexPath];
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(SCREENWIDTH - (self.horizontalPadding * 2), self.bounds.size.height);
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(ImageBannerCollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    cell.imagelink = self.imageLinkGroup[indexPath.item];
    kWeakSelf;
    cell.onImageTap = ^(ImageBannerCollectionViewCell *imageCell) {
        if (weakSelf.onTapImage) {
            weakSelf.onTapImage(weakSelf.imageLinkGroup,[weakSelf.imageLinkGroup indexOfObject:imageCell.imagelink]);
        }
    };
}


//- (void)onTapImage:(UITapGestureRecognizer *)gesture {
//    NSInteger selectIndex = gesture.view.tag - 10000;
//    if (self.onTapImage) {
//        self.onTapImage(self.imageLinkGroup,selectIndex);
//    }
//}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end



@implementation ImageBannerCollectionView


- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        
    }
    return self;
}
- (BOOL)touchesShouldCancelInContentView:(UIView *)view {
    return YES;
}

- (BOOL)canCancelContentTouches {
    return YES;
}

@end




#pragma mark :- 图片展示单元格

@interface ImageBannerCollectionViewCell ()

/**
 *  图片展示 按钮
 */
@property(nonatomic,strong)UIButton *imageBtn;


@end

@implementation ImageBannerCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.imageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        
        self.imageBtn.imageView.contentMode = UIViewContentModeCenter;
        self.imageBtn.contentEdgeInsets = UIEdgeInsetsZero;
        self.imageBtn.contentMode = UIViewContentModeScaleAspectFill;
        self.imageBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentFill;
        self.imageBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentFill;
        
        
        
        self.imageBtn.clipsToBounds = YES;
        self.imageBtn.backgroundColor = [UIColor whiteColor];
        [self.imageBtn addTarget:self action:@selector(onImageTap:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.imageBtn];
        [self.imageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    return self;
}

- (void)setImagelink:(NSString *)imagelink {
    _imagelink = imagelink;
    NSURL *imageUrl = [NSURL URLWithString:imagelink];
    UIImage *errorImage = [UIImage imageNamed:@"demo_nearBgImage.jpg"];
    [self.imageBtn sd_setImageWithURL:imageUrl forState:UIControlStateNormal placeholderImage:errorImage];
}

- (void)onImageTap:(UIButton *)btn {
    if (self.onImageTap) {
        self.onImageTap(self);
    }
}

@end






