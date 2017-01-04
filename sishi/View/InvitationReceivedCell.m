//
//  InvitationReceivedCell.m
//  sishi
//
//  Created by likeSo on 2017/1/3.
//  Copyright © 2017年 Channce. All rights reserved.
//

#import "InvitationReceivedCell.h"
#import "Masonry.h"

@interface InvitationReceivedCell ()

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

@end

@implementation InvitationReceivedCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor colorWithRed:239 / 255.0 green:235 / 255.0 blue:239 / 255.0 alpha:1];
        
        self.headerImage = [UIButton buttonWithType:UIButtonTypeCustom];
        self.headerImage.layer.cornerRadius = 22.5;
        self.headerImage.clipsToBounds = YES;
        [self.headerImage setImage:[UIImage imageNamed:DEFAULTERRORIMAGE] forState:UIControlStateNormal];
        [self.contentView addSubview:self.headerImage];
        self.headerImage.imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.headerImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15);
            make.top.equalTo(self.contentView).offset(10);
            make.size.mas_equalTo(CGSizeMake(45, 45));
        }];
        
        self.bgView = [[UIView alloc]init];
        self.bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.bgView];
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.headerImage);
            make.left.equalTo(self.headerImage.mas_right).offset(5);
            make.right.equalTo(self.contentView).offset(-25);
//            make.height.equalTo(@180);
        }];
        
        UILabel *invitationLabel = [[UILabel alloc] init];
        invitationLabel.text = @"我向您发起一条邀约";
        invitationLabel.font = [UIFont systemFontOfSize:14];
        [self.bgView addSubview:invitationLabel];
        [invitationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self.bgView).offset(8);
            make.right.lessThanOrEqualTo(self.bgView).offset(-8);
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
////
//        self.destinationLabel = [[UILabel alloc]init];
//        self.destinationLabel.text = @"目的地 : 西溪湿地公园";
//        self.destinationLabel.font = [UIFont systemFontOfSize:13];
//        self.destinationLabel.textColor = [UIColor colorWithWhite:0.5 alpha:1];
//        [self.bgView addSubview:self.destinationLabel];
//        [self.destinationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.dateLabel);
//            make.top.equalTo(self.dateLabel.mas_bottom).offset(5);
//            make.right.lessThanOrEqualTo(self.bgView).offset(-8);
//        }];
//
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
//
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
//
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
        
        
        UIView *lineView = [[UIView alloc]init];
        lineView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
        [self.bgView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.bgView);
            make.top.equalTo(self.noteLabel.mas_bottom).offset(10);
            make.height.equalTo(@1);
        }];
        
        UIButton *acceptBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [acceptBtn setTitle:@"欣然接受" forState:UIControlStateNormal];
        acceptBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        acceptBtn.tintColor = [UIColor colorWithRed:119  / 255.0 green:177 / 255.0 blue:96 / 255.0 alpha:1];
        [self.bgView addSubview:acceptBtn];
        [acceptBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.equalTo(self.bgView);
            make.top.equalTo(lineView.mas_bottom);
        }];
        
        UIButton *refuseBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [refuseBtn setTitle:@"残忍拒绝" forState:UIControlStateNormal];
        refuseBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        refuseBtn.tintColor = [UIColor colorWithRed:179  / 255.0 green:67 / 255.0 blue:53 / 255.0 alpha:1];
        [self.bgView addSubview:refuseBtn];
        [refuseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.bgView);
            make.left.equalTo(acceptBtn.mas_right);
            make.top.equalTo(lineView.mas_bottom);
            make.width.height.equalTo(acceptBtn);
        }];
        
        UIButton *contactBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [contactBtn setTitle:@"沟通一下" forState:UIControlStateNormal];
        contactBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        contactBtn.tintColor = [UIColor colorWithRed:65  / 255.0 green:66 / 255.0 blue:69 / 255.0 alpha:1];
        [self.bgView addSubview:contactBtn];
        [contactBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.equalTo(self.bgView);
            make.top.equalTo(lineView.mas_bottom);
            make.left.equalTo(refuseBtn.mas_right);
            make.width.height.equalTo(refuseBtn);
        }];
        
        
    }
    return self;
}


- (void)setModel:(id<IMessageModel>)model {
//    super.model = model;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
