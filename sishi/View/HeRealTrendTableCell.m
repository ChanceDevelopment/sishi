//
//  HeRealTrendTableCell.m
//  sishi
//
//  Created by HeDongMing on 16/8/18.
//  Copyright © 2016年 Channce. All rights reserved.
//

#import "HeRealTrendTableCell.h"


@implementation HeRealTrendTableCell
@synthesize bgView;
@synthesize headImage;
@synthesize titleLabel;
@synthesize timeLabel;
@synthesize contentLabel;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setModel:(TripListModel *)model {
    _model = model;
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[ApiUtils baseUrl],model.userHeader]]];
    self.timeLabel.text = model.carEndtime;
//    self.contentLabel.text = model.dynamicContent;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellSize:(CGSize)cellsize
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier cellSize:cellsize];
    if (self) {
        CGFloat bgX = 10;
        CGFloat bgY = 10;
        CGFloat bgW = SCREENWIDTH - 2 * bgX;
        CGFloat bgH = cellsize.height - 2 * bgY;
        bgView = [[UIView alloc] initWithFrame:CGRectMake(bgX, bgY, bgW, bgH)];
        bgView.backgroundColor = UIColorFromRGB(0xeeeeee);
        bgView.layer.masksToBounds = YES;
        bgView.layer.cornerRadius = 5.0;
        [self addSubview:bgView];
        
        CGFloat headX = 5;
        CGFloat headY = 5;
        CGFloat headW = 60;
        CGFloat headH = headW;
        headImage = [[UIImageView alloc] initWithFrame:CGRectMake(headX, headY, headW, headH)];
        headImage.image = [UIImage imageNamed:@"demo_nearBgImage.jpg"];
        headImage.layer.masksToBounds = YES;
        headImage.layer.cornerRadius = headW / 2.0;
        headImage.layer.borderColor = [UIColor whiteColor].CGColor;
        headImage.layer.borderWidth = 1.0;
        headImage.contentMode = UIViewContentModeScaleAspectFill;
        [bgView addSubview:headImage];
        
        CGFloat titleX = CGRectGetMaxX(headImage.frame) + 10;
        CGFloat titleY = headY;
        CGFloat titleW = SCREENWIDTH - titleX - headX;
        CGFloat titleH = 40;
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleX, titleY, titleW, titleH)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = [UIColor redColor];
        titleLabel.font = [UIFont systemFontOfSize:20.0];
        titleLabel.text = @"我的实时状态";
        [bgView addSubview:titleLabel];
        
        CGFloat timeX = CGRectGetMaxX(headImage.frame) + 10;
        CGFloat timeY = CGRectGetMaxY(titleLabel.frame);
        CGFloat timeW = SCREENWIDTH - titleX - headX;
        CGFloat timeH = 20;
        
        timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(timeX, timeY, timeW, timeH)];
        timeLabel.backgroundColor = [UIColor clearColor];
        timeLabel.textColor = [UIColor grayColor];
        timeLabel.font = [UIFont systemFontOfSize:15.0];
        timeLabel.text = @"三分钟前，洪都路段";
        [bgView addSubview:timeLabel];
        
        CGFloat tipX = headX;
        CGFloat tipY = CGRectGetMaxY(headImage.frame) + 10;
        CGFloat tipW = SCREENWIDTH - 2 * tipX;
        CGFloat tipH = 20;
        
        contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(tipX, tipY, tipW, tipH)];
        contentLabel.backgroundColor = [UIColor clearColor];
        contentLabel.textColor = [UIColor grayColor];
        contentLabel.font = [UIFont systemFontOfSize:17.0];
        contentLabel.text = @"正在行车，尚未发出邀请";
        [bgView addSubview:contentLabel];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    
    //上分割线，
    CGContextSetStrokeColorWithColor(context, ([UIColor clearColor]).CGColor);
    CGContextStrokeRect(context, CGRectMake(0, -1, rect.size.width, 1));
    
    //下分割线
    CGContextSetStrokeColorWithColor(context, ([UIColor clearColor]).CGColor);
    CGContextStrokeRect(context, CGRectMake(0, rect.size.height, rect.size.width, 1));
}

@end
