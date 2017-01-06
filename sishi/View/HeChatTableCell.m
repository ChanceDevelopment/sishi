//
//  HeChatTableCell.m
//  sishi
//
//  Created by HeDongMing on 16/8/18.
//  Copyright © 2016年 Channce. All rights reserved.
//

#import "HeChatTableCell.h"
#import "Masonry.h"

@interface HeChatTableCell ()
/**
 *  未读消息数目显示Label
 */
@property(nonatomic,strong)UILabel *unReadMessageLabel;

@end
@interface UILabel (Utils)

@end

@implementation UILabel (Utils)

- (CGSize)intrinsicContentSize {//重写此方法用于增大UILabel的默认大小,达到html中margin的效果
    CGSize defaultSize = [super intrinsicContentSize];
    return CGSizeMake(defaultSize.width + 8, defaultSize.height + 4);
}

@end

@implementation HeChatTableCell
@synthesize headImage;
@synthesize titleLabel;
@synthesize contentLabel;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellSize:(CGSize)cellsize
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier cellSize:cellsize];
    if (self) {
        CGFloat headX = 10;
        CGFloat headY = 10;
        CGFloat headW = 60;
        CGFloat headH = headW;
        headImage = [[UIImageView alloc] initWithFrame:CGRectMake(headX, headY, headW, headH)];
        headImage.image = [UIImage imageNamed:@"demo_nearBgImage.jpg"];
        headImage.layer.masksToBounds = YES;
        headImage.layer.cornerRadius = headW / 2.0;
        headImage.layer.borderColor = [UIColor whiteColor].CGColor;
        headImage.layer.borderWidth = 1.0;
        headImage.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:headImage];
        
        CGFloat titleX = CGRectGetMaxX(headImage.frame) + 10;
        CGFloat titleY = headY;
        CGFloat titleW = SCREENWIDTH - titleX - headX;
        CGFloat titleH = headH / 2.0;
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleX, titleY, titleW, titleH)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.font = [UIFont systemFontOfSize:20.0];
        titleLabel.text = @"何晓明";
        [self addSubview:titleLabel];
        
        
        CGFloat tipX = CGRectGetMaxX(headImage.frame) + 10;;
        CGFloat tipY = CGRectGetMaxY(titleLabel.frame);
        CGFloat tipW = SCREENWIDTH - 2 * tipX;
        CGFloat tipH = headH / 2.0;;
        
        contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(tipX, tipY, tipW, tipH)];
        contentLabel.backgroundColor = [UIColor clearColor];
        contentLabel.textColor = [UIColor redColor];
        contentLabel.font = [UIFont systemFontOfSize:15.0];
        contentLabel.text = @"晚上一起去吃饭吧";
        [self addSubview:contentLabel];
        
        
        self.unReadMessageLabel = [[UILabel alloc]init];
        self.unReadMessageLabel.font = [UIFont systemFontOfSize:12];
        self.unReadMessageLabel.textColor = [UIColor whiteColor];
        self.unReadMessageLabel.layer.cornerRadius = 2;
        self.unReadMessageLabel.clipsToBounds = YES;
        self.unReadMessageLabel.hidden = YES;
        self.unReadMessageLabel.backgroundColor = [UIColor colorWithRed:72 / 255.0 green:215 / 255.0 blue:190 / 255.0 alpha:0.6];
        [self.contentView addSubview:self.unReadMessageLabel];
        [self.unReadMessageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.headImage);
            make.right.equalTo(self.contentView).offset(-10);
        }];
    }
    return self;
}


- (void)setUnReadMessageCount:(NSUInteger)unReadMessageCount {
    _unReadMessageCount = unReadMessageCount;
    if (unReadMessageCount <= 0) {
        self.unReadMessageLabel.hidden = YES;
    } else {
        self.unReadMessageLabel.hidden = NO;
        self.unReadMessageLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)unReadMessageCount];
    }
}
@end
