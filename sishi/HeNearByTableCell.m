//
//  HeNearByTableCell.m
//  sishi
//
//  Created by HeDongMing on 16/8/17.
//  Copyright © 2016年 Channce. All rights reserved.
//

#import "HeNearByTableCell.h"
#import "Masonry.h"
#import "ApiUtils.h"
#import "sishiDefine.h"
@interface HeNearByTableCell ()

/**
 *  是否已点赞
 */
@property(nonatomic,assign,getter=isUpvoted)BOOL upvoted;

@end


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
        
        
        
//        UILabel *nearbyLabel = [[UILabel alloc]initWithFrame:CGRectZero];
//        nearbyLabel.frame = CGRectMake(10, 10, 80, 20);
//        nearbyLabel.text = [NSString stringWithFormat:@"附近%@",isUser];
//        nearbyLabel.font = [UIFont systemFontOfSize:13];
//        nearbyLabel.textColor = [UIColor colorWithWhite:0.7 alpha:1];
//        [self addSubview:nearbyLabel];
        
        CGFloat bgX = nameX;
//        CGFloat bgY = CGRectGetMaxY(nearbyLabel.frame) + 10;
        CGFloat bgY = 35;
        CGFloat bgW = nameW;
        CGFloat bgH = 120;
        
        self.bgImage = [[ImageBannerView alloc]initWithFrame:CGRectMake(bgX, bgY, bgW, bgH)];
        self.bgImage.padding = 25;
        self.bgImage.backgroundColor = [UIColor whiteColor];
//        self.bgImage.imageLinkGroup = @[@"",@"",@""];
        [self addSubview:self.bgImage];
        
        self.upvoteButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [self.upvoteButton setTitle:@"👍" forState:UIControlStateNormal];
        [self.upvoteButton setImage:[UIImage imageNamed:@"icon_follow_white.png"] forState:UIControlStateNormal];
        
        [self.upvoteButton addTarget:self action:@selector(onUpvote:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.upvoteButton];
        [self.upvoteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bgImage).offset(5);
            make.right.equalTo(self.bgImage).offset(-30);
            make.size.mas_equalTo(CGSizeMake(25, 25));
        }];
        
        CGFloat headW = 50;
        CGFloat headH = headW;
        CGFloat headX = nameX + nameW - headW - 20;
        CGFloat headY = bgY + bgH - headH / 2.0;
        
        headImage = [[UIImageView alloc] initWithFrame:CGRectMake(headX, headY, headW, headH)];
        headImage.image = [UIImage imageNamed:@"demo_nearBgImage.jpg"];
        headImage.userInteractionEnabled = YES;
        headImage.layer.masksToBounds = YES;
        headImage.layer.borderWidth = 1.0;
        headImage.layer.borderColor = [UIColor whiteColor].CGColor;
        headImage.layer.cornerRadius = headW / 2.0;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTapUserHead:)];
        [headImage addGestureRecognizer:tap];
        headImage.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:headImage];
        
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameX, nameY, nameW, nameH)];
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.textColor = [UIColor blackColor];
        nameLabel.font = [UIFont fontWithName:@"Helvetica" size:16.0];
        nameLabel.text = @"我叫小沈阳";
        [self addSubview:nameLabel];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(headImage.mas_left);
            make.top.equalTo(bgImage.mas_bottom).offset(10);
        }];
        
        CGFloat addressX = nameX;
        CGFloat addressY = CGRectGetMaxY(bgImage.frame);
        CGFloat addressW = SCREENWIDTH - 2 * addressX;
        CGFloat addressH = 25;
        
        distanceLabel = [[UILabel alloc] initWithFrame:CGRectZero];//CGRectMake(addressX, addressY, addressW, addressH)
        distanceLabel.backgroundColor = [UIColor clearColor];
        distanceLabel.textColor = [UIColor grayColor];
        distanceLabel.font = [UIFont systemFontOfSize:15.0];
        distanceLabel.text = @"距离您0.25km";
        [self addSubview:distanceLabel];
        [distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@10);
            make.centerY.equalTo(nameLabel);
        }];
        
        self.contactButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contactButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        self.contactButton.layer.cornerRadius = 5;
        [self.contactButton.titleLabel setFont:[UIFont systemFontOfSize:11]];
        self.contactButton.clipsToBounds = YES;
        self.contactButton.layer.borderWidth = 1;
        self.contactButton.layer.borderColor = [[UIColor redColor] CGColor];
        [self.contactButton addTarget:self action:@selector(onContact:) forControlEvents:UIControlEventTouchUpInside];
        [self.contactButton setTitle:@"约Ta" forState:UIControlStateNormal];
        [self addSubview:self.contactButton];
        [self.contactButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.distanceLabel);
            make.left.equalTo(self.distanceLabel.mas_right).offset(10);
            make.width.equalTo(@(45));
            make.height.equalTo(@(25));
        }];
        
        CGFloat markX = 10;
        CGFloat markY = CGRectGetMaxY(distanceLabel.frame);
        CGFloat markW = SCREENWIDTH - 2 * markX;
        CGFloat markH = 25;
        
        tipLabel = [[UILabel alloc] initWithFrame:CGRectZero];//CGRectMake(markX, markY, markW, markH)
        tipLabel.backgroundColor = [UIColor clearColor];
        tipLabel.textColor = [UIColor blackColor];
        tipLabel.font = [UIFont systemFontOfSize:15.0];
        tipLabel.text = @"自由、爱情、生活、美食";
        [self addSubview:tipLabel];
        [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(distanceLabel);
            make.top.equalTo(distanceLabel.mas_bottom).offset(10);
        }];
        
    }
    return self;
}

- (void)setModel:(NearbyUserListModel *)model {
    _model = model;
    NSArray *imagelist = [model.userPaperWall componentsSeparatedByString:@","];
    NSMutableArray *imageLinkArray = [NSMutableArray arrayWithCapacity:imagelist.count];
    for (NSString *imageName in imagelist) {
        [imageLinkArray addObject:[NSString stringWithFormat:@"%@%@",[ApiUtils baseUrl],imageName]];
    }
    self.bgImage.imageLinkGroup = [NSArray arrayWithArray:imageLinkArray];
    NSString *distance = [NSString stringWithFormat:@"距离您%.2fkm",model.distance];
    self.distanceLabel.text = distance;
    self.nameLabel.text = model.userNick;
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[ApiUtils baseUrl],model.userHeader]] placeholderImage:[UIImage imageNamed:DEFAULTERRORIMAGE]];
    self.tipLabel.text = model.userSign;
    if (model.isUpvoted) {
         [self.upvoteButton setImage:[UIImage imageNamed:@"icon_follow_red.png"] forState:UIControlStateNormal];
    } else {
        [self.upvoteButton setImage:[UIImage imageNamed:@"icon_follow_white.png"] forState:UIControlStateNormal];
    }
}

- (void)onTapUserHead:(UITapGestureRecognizer *)tap {
    
}

- (void)onContact:(UIButton *)btn {
    if (self.onContactAction) {
        self.onContactAction(self);
    }
}

- (void)onUpvote:(UIButton *)btn {
    if (!self.model.isUpvoted) {//点赞
        [ApiUtils userFocusWithUserId:self.model.userId onComplete:^{
            [btn setImage:[UIImage imageNamed:@"icon_follow_red.png"] forState:UIControlStateNormal];
            self.model.isUpvoted = YES;
        } onError:nil];
        
    } else {//取消点赞
        [ApiUtils removeFocusOnUser:self.model.userId onComplete:^{
            [btn setImage:[UIImage imageNamed:@"icon_follow_white.png"] forState:UIControlStateNormal];
            self.model.isUpvoted = NO;
        } errorHandler:nil];
    }
}

@end
