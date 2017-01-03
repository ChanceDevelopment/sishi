//
//  InvitationSentCell.m
//  sishi
//
//  Created by likeSo on 2017/1/3.
//  Copyright © 2017年 Channce. All rights reserved.
//

#import "InvitationSentCell.h"

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
        
        CGFloat headerWidth = 50;
        
        self.headerImage = [UIButton buttonWithType:UIButtonTypeCustom];
        self.headerImage.frame = CGRectMake(SCREENWIDTH - headerWidth - 15, 10, headerWidth, headerWidth);
        self.headerImage.layer.cornerRadius = headerWidth * 0.5;
        self.headerImage.clipsToBounds = YES;
        [self.headerImage setImage:[UIImage imageNamed:DEFAULTERRORIMAGE] forState:UIControlStateNormal];
        [self.contentView addSubview:self.headerImage];
        
//        UIBezierPath *shapePath = [UIBezierPath bezierPathWithRect:<#(CGRect)#>]
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
