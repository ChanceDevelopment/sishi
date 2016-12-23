//
//  SelectViewContainer.m
//  sishi
//
//  Created by likeSo on 2016/12/23.
//  Copyright © 2016年 Channce. All rights reserved.
//

#import "SelectViewContainer.h"
#import "Masonry.h"
@interface SelectViewContainer ()
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation SelectViewContainer


+ (SelectViewContainer *)defaultContainerView {
    SelectViewContainer *container = [[[NSBundle mainBundle] loadNibNamed:@"SelectViewContainer" owner:nil options:nil] firstObject];
    container.layer.cornerRadius = 3;
    container.clipsToBounds  = YES;
    container.confirmBtn.layer.cornerRadius = 5;
    container.confirmBtn.clipsToBounds = YES;
    return container;
}

- (void)showWithContentView:(UIView *)subView
                  withTitle:(NSString *)titleString {
    self.titleLabel.text = titleString;
    [self addSubview:subView];
    [subView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
        make.bottom.equalTo(self.confirmBtn.mas_top).offset(-5);
        make.left.right.equalTo(self);
    }];
    
    UIView *superView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    superView.alpha = 0.0;
    UITapGestureRecognizer *bgContainerViewTapGest = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onBgTap:)];
    [superView addGestureRecognizer:bgContainerViewTapGest];
    superView.userInteractionEnabled = NO;
    [superView addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(superView);
        make.width.equalTo(superView).offset(-60);
        make.height.equalTo(self.mas_width).multipliedBy(0.9);
    }];
    superView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    [[UIApplication sharedApplication].keyWindow addSubview:superView];
    [UIView animateWithDuration:0.2 animations:^{
        self.superview.alpha = 1.0;
        superView.userInteractionEnabled = YES;
    }];
}

- (void)hide {
    [self.superview setUserInteractionEnabled:NO];
    [UIView animateWithDuration:0.1 animations:^{
        self.superview.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self.superview removeFromSuperview];
            [self removeFromSuperview];
        }
    }];
}


- (IBAction)onConfirm:(UIButton *)sender {
    if (self.onConfirm) {
        self.onConfirm();
    }
    [self hide];
}

- (void)onBgTap:(UITapGestureRecognizer *)tap {
    [self hide];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
