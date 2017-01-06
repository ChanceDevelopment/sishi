//
//  InvitationSentCell.m
//  sishi
//
//  Created by likeSo on 2017/1/3.
//  Copyright © 2017年 Channce. All rights reserved.
//

#import "InvitationSentCell.h"
#import "Masonry.h"
#import "UIButton+EMWebCache.h"
#import "ApiUtils.h"

@interface InvitationSentCell ()
/**
 *  背景View
 */
@property(nonatomic,strong)UIView *bgView;

/**
 *  头像
 */
@property(nonatomic,strong)UIButton *headerImage;

/**
 *  预约时间 Label
 */
@property(nonatomic,strong)UILabel *dateLabel;

/**
 *  目的地Label
 */
@property(nonatomic,strong)UILabel *destinationLabel;

/**
 *  上车位置Label
 */
@property(nonatomic,strong)UILabel *startPlaceLabel;

/**
 *  备注内容Label
 */
@property(nonatomic,strong)UILabel *noteLabel;

/**
 *  当前邀约申请状态Label
 */
@property(nonatomic,strong)UILabel *stateLabel;

@end

@implementation InvitationSentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor colorWithRed:239 / 255.0 green:235 / 255.0 blue:239 / 255.0 alpha:1];
        
        self.headerImage = [UIButton buttonWithType:UIButtonTypeCustom];
        self.headerImage.layer.cornerRadius = 22.5;
        self.headerImage.clipsToBounds = YES;
        [self.headerImage setImage:[UIImage imageNamed:DEFAULTERRORIMAGE] forState:UIControlStateNormal];
        NSString *uImage = [Tool defaultsForKey:kDefaultsUserHeaderImage];
        NSString *imageUri = [NSString stringWithFormat:@"%@%@",[ApiUtils baseUrl],uImage];
        [self.headerImage sd_setImageWithURL:[NSURL URLWithString:imageUri] forState:UIControlStateNormal];
        self.headerImage.imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:self.headerImage];
        [self.headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-15);
            make.top.equalTo(self.contentView).offset(10);
            make.size.mas_equalTo(CGSizeMake(45, 45));
        }];
        
        self.bgView = [[UIView alloc]init];//需要替换为imageView展示.9图
        self.bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.bgView];
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headerImage);
            make.right.equalTo(self.headerImage.mas_left).offset(-5);
            make.left.equalTo(self.contentView).offset(25);
        }];
        
        UILabel *invitationLabel = [[UILabel alloc] init];
        invitationLabel.text = @"我向您发起一条邀约";
        invitationLabel.font = [UIFont systemFontOfSize:14];
        [self.bgView addSubview:invitationLabel];
        [invitationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self.bgView).offset(8);
            make.right.lessThanOrEqualTo(self.contentView).offset(-8);
        }];
        
        self.dateLabel = [[UILabel alloc]init];
        self.dateLabel.text = @"预约时间 : 7月3日 11:00";
        self.dateLabel.font = [UIFont systemFontOfSize:13];
        self.dateLabel.textColor = [UIColor colorWithWhite:0.5 alpha:1];
        [self.bgView addSubview:self.dateLabel];
        [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(invitationLabel);
            make.top.equalTo(invitationLabel.mas_bottom).offset(5);
            make.right.lessThanOrEqualTo(self.bgView).offset(-8);
        }];
        
//        self.startPlaceLabel = [[UILabel alloc]init];
//        self.startPlaceLabel.text = @"目的地 : 西溪湿地公园";
//        self.startPlaceLabel.font = [UIFont systemFontOfSize:13];
//        self.startPlaceLabel.textColor = [UIColor colorWithWhite:0.5 alpha:1];
//        [self.bgView addSubview:self.startPlaceLabel];
//        [self.startPlaceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.dateLabel);
//            make.top.equalTo(self.dateLabel.mas_bottom).offset(5);
//            make.right.lessThanOrEqualTo(self.bgView).offset(-8);
//        }];
        
        self.destinationLabel = [[UILabel alloc]init];
        self.destinationLabel.text = @"目的地 : 西溪湿地公园";
        self.destinationLabel.font = [UIFont systemFontOfSize:13];
        self.destinationLabel.textColor = [UIColor colorWithWhite:0.5 alpha:1];
        [self.bgView addSubview:self.destinationLabel];
        [self.destinationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.dateLabel);
            make.top.equalTo(self.dateLabel.mas_bottom).offset(5);
            make.right.lessThanOrEqualTo(self.bgView).offset(-8);
        }];
        
        self.startPlaceLabel = [[UILabel alloc]init];
        self.startPlaceLabel.text = @"我的上车位置 : 拱墅区西南小区";
        self.startPlaceLabel.font = [UIFont systemFontOfSize:13];
        self.startPlaceLabel.textColor = [UIColor colorWithWhite:0.5 alpha:1];
        [self.bgView addSubview:self.startPlaceLabel];
        [self.startPlaceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.destinationLabel);
            make.top.equalTo(self.destinationLabel.mas_bottom).offset(5);
            make.right.lessThanOrEqualTo(self.bgView).offset(-8);
        }];
        
        self.noteLabel = [[UILabel alloc]init];
        self.noteLabel.text = @"备注 : 备注内容";
        self.noteLabel.font = [UIFont systemFontOfSize:13];
        self.noteLabel.textColor = [UIColor colorWithWhite:0.5 alpha:1];
        [self.bgView addSubview:self.noteLabel];
        [self.noteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.startPlaceLabel);
            make.top.equalTo(self.startPlaceLabel.mas_bottom).offset(5);
            make.right.lessThanOrEqualTo(self.bgView).offset(-8);
        }];
        
        UIView *lineView = [UIView new];
        lineView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
        [self.bgView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.bgView);
            make.top.equalTo(self.noteLabel.mas_bottom).offset(5);
            make.height.equalTo(@1);
        }];
        
        self.stateLabel = [[UILabel alloc]init];
        self.stateLabel.text = @"对方尚未接受您的邀请";
        self.stateLabel.textAlignment = NSTextAlignmentCenter;
        self.stateLabel.font = [UIFont systemFontOfSize:13];
        self.stateLabel.textColor = [UIColor colorWithWhite:0.3 alpha:1];
//        self.stateLabel.layer.borderWidth = 1.0;
//        self.stateLabel.layer.borderColor = [UIColor blackColor].CGColor;
        [self.bgView addSubview:self.stateLabel];
        [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.noteLabel.mas_bottom).offset(5);
            make.left.right.bottom.equalTo(self.bgView);
            make.height.equalTo(@(25));
        }];
        
        
    }
    return self;
}

- (void)layoutSubviews {//
    [super layoutSubviews];
    
//    CGFloat bgWidth = self.bgView.bounds.size.width;
//    CGFloat halfWidth = self.bgView.bounds.size.width * 0.5;
//    CGFloat radiusWidth = 3;
//    CGFloat clipsWidth = 8;
//    
//    UIBezierPath *shapePath = [UIBezierPath bezierPathWithRect:self.bgView.bounds];
//    [shapePath moveToPoint:CGPointMake(halfWidth, 0)];
//    [shapePath addLineToPoint:CGPointMake(bgWidth - radiusWidth - clipsWidth, 0)];
    
}

- (void)setChatModel:(ChatInvitationMessageModel *)chatModel {
    _chatModel = chatModel;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
