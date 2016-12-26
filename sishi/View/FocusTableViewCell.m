//
//  FocusTableViewCell.m
//  sishi
//
//  Created by likeSo on 2016/12/16.
//  Copyright © 2016年 Channce. All rights reserved.
//

#import "FocusTableViewCell.h"
#import "sishiDefine.h"
#import "ApiUtils.h"

@interface FocusTableViewCell ()
@property (weak, nonatomic) IBOutlet UIButton *contactButton;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *hobbyTagLabel;
@property (weak, nonatomic) IBOutlet UILabel *hobbyLabel;

@end

@implementation FocusTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.headImageView.layer.cornerRadius = 22.5;
    self.headImageView.clipsToBounds = YES;
    
    self.contactButton.layer.cornerRadius = 3;
    self.contactButton.layer.borderWidth = 1;
    self.contactButton.layer.borderColor = UIColorFromRGB(0XFF585B).CGColor;
    self.contactButton.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)onContact:(UIButton *)sender {
    if (self.onContact) {
        self.onContact(self.model);
    }
}

- (void)setModel:(UserFollowListModel *)model {
    _model = model;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[ApiUtils baseUrl],model.userHeader]] placeholderImage:[UIImage imageNamed:@"demo_nearBgImage.jpg"]];
    self.headImageView.clipsToBounds = YES;
    self.nameLabel.text = model.userNick;
    self.hobbyLabel.text = model.userCarlable;
}

@end
