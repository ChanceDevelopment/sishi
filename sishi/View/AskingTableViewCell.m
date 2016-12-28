//
//  AskingTableViewCell.m
//  sishi
//
//  Created by likeSo on 2016/12/28.
//  Copyright © 2016年 Channce. All rights reserved.
//

#import "AskingTableViewCell.h"
#import "ApiUtils.h"
#import "UIButton+EMWebCache.h"


@interface AskingTableViewCell ()
@property (weak, nonatomic) IBOutlet UIButton *headerBtn;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *contactBtn;
@property (weak, nonatomic) IBOutlet UILabel *askingLabel;
@property (weak, nonatomic) IBOutlet UILabel *destinationLabel;
@property (weak, nonatomic) IBOutlet UILabel *goTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *originLabel;
@property (weak, nonatomic) IBOutlet UILabel *wishLabel;
@property (weak, nonatomic) IBOutlet UILabel *noteLabel;
@end

@implementation AskingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.headerBtn.layer.cornerRadius = 22.25;
    self.headerBtn.clipsToBounds = YES;
    self.headerBtn.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contactBtn addTarget:self action:@selector(onContact:) forControlEvents:UIControlEventTouchUpInside];
    self.contactBtn.layer.cornerRadius = 3;
    self.contactBtn.layer.borderWidth = 1.0;
    self.contactBtn.layer.borderColor = UIColorFromRGB(0xff585b).CGColor;
    
}

- (void)setTripModel:(TripListModel *)tripModel {
    _tripModel = tripModel;
    self.nameLabel.text = tripModel.userNick;
    self.askingLabel.text = [NSString stringWithFormat:@"%@发起一条邀约",tripModel.userNick];
    self.destinationLabel.text = [NSString stringWithFormat:@"目的地 : %@",tripModel.carOwnerStopplace];
    
    self.goTimeLabel.text = [NSString stringWithFormat:@"时间 : %@",tripModel.goTimeDescription];
    self.originLabel.text = [NSString stringWithFormat:@"出发地 : %@",tripModel.carOwnerStartplace
                             ];
    self.wishLabel.text = [NSString stringWithFormat:@"期待邀约的Ta : %@",tripModel.carUserLike];
    self.noteLabel.text = [NSString stringWithFormat:@"备注 : %@",tripModel. carOwnerNote];
    NSString *imageLink = [NSString stringWithFormat:@"%@%@",[ApiUtils baseUrl],tripModel.userHeader];
    [self.headerBtn sd_setImageWithURL:[NSURL URLWithString:imageLink] forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)onContact:(UIButton *)btn {
    if (self.onContact) {
        self.onContact(self.tripModel);
    }
}

@end
