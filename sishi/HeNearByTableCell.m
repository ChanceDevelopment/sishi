//
//  HeNearByTableCell.m
//  sishi
//
//  Created by HeDongMing on 16/8/17.
//  Copyright © 2016年 Channce. All rights reserved.
//

#import "HeNearByTableCell.h"

@implementation HeNearByTableCell
@synthesize nameLabel;
@synthesize bgImage;
@synthesize headImage;
@synthesize distanceLabel;
@synthesize tipLabel;

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
        CGFloat nameX = 10;
        CGFloat nameY = 10;
        CGFloat nameW = SCREENWIDTH - 2 * nameX;
        CGFloat nameH = 30;
        
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameX, nameY, nameW, nameH)];
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.textColor = [UIColor blackColor];
        nameLabel.font = [UIFont fontWithName:@"Helvetica" size:16.0];
        nameLabel.text = @"我叫小沈阳";
        [self addSubview:nameLabel];
        
        CGFloat bgX = nameX;
        CGFloat bgY = CGRectGetMaxY(nameLabel.frame);
        CGFloat bgW = nameW;
        CGFloat bgH = 120;
        bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(bgX, bgY, bgW, bgH)];
        bgImage.image = [UIImage imageNamed:@"demo_nearBgImage.jpg"];
        bgImage.layer.masksToBounds = YES;
        bgImage.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:bgImage];
        
        CGFloat headW = 50;
        CGFloat headH = headW;
        CGFloat headX = nameX + nameW - headW - 20;
        CGFloat headY = bgY + bgH - headH / 2.0;
        
        headImage = [[UIImageView alloc] initWithFrame:CGRectMake(headX, headY, headW, headH)];
        headImage.image = [UIImage imageNamed:@"demo_nearBgImage.jpg"];
        headImage.layer.masksToBounds = YES;
        headImage.layer.borderWidth = 1.0;
        headImage.layer.borderColor = [UIColor whiteColor].CGColor;
        headImage.layer.cornerRadius = headW / 2.0;
        headImage.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:headImage];
        
        CGFloat addressX = nameX;
        CGFloat addressY = CGRectGetMaxY(bgImage.frame);
        CGFloat addressW = SCREENWIDTH - 2 * addressX;
        CGFloat addressH = 25;
        
        distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(addressX, addressY, addressW, addressH)];
        distanceLabel.backgroundColor = [UIColor clearColor];
        distanceLabel.textColor = [UIColor grayColor];
        distanceLabel.font = [UIFont systemFontOfSize:15.0];
        distanceLabel.text = @"距离您0.25km";
        [self addSubview:distanceLabel];
        
        CGFloat markX = 10;
        CGFloat markY = CGRectGetMaxY(distanceLabel.frame);
        CGFloat markW = SCREENWIDTH - 2 * markX;
        CGFloat markH = 25;
        
        tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(markX, markY, markW, markH)];
        tipLabel.backgroundColor = [UIColor clearColor];
        tipLabel.textColor = [UIColor blackColor];
        tipLabel.font = [UIFont systemFontOfSize:15.0];
        tipLabel.text = @"自由、爱情、生活、美食";
        [self addSubview:tipLabel];
        
    }
    return self;
}

@end
