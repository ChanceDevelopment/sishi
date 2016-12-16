//
//  FocusTableViewCell.m
//  sishi
//
//  Created by likeSo on 2016/12/16.
//  Copyright © 2016年 Channce. All rights reserved.
//

#import "FocusTableViewCell.h"
#import "sishiDefine.h"
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
    self.contactButton.layer.cornerRadius = 2;
    self.contactButton.layer.borderWidth = 1;
    self.contactButton.layer.borderColor = UIColorFromRGB(0XFF585B).CGColor;
    self.contactButton.clipsToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)onContact:(UIButton *)sender {
    
}

@end
