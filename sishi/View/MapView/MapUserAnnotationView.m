//
//  MapUserAnnotationView.m
//  sishi
//
//  Created by likeSo on 2017/1/5.
//  Copyright © 2017年 Channce. All rights reserved.
//

#import "MapUserAnnotationView.h"
#import "MapUserAnnotationModel.h"
#import "ApiUtils.h"
#import "UIButton+EMWebCache.h"

@implementation MapUserAnnotationView


- (id)initWithAnnotation:(id<BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier]) {
        self.headerImage = [UIButton buttonWithType:UIButtonTypeCustom];
        self.headerImage.frame = CGRectMake(0, 0, 55, 55);
        self.headerImage.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.headerImage.layer.cornerRadius = 27.5;
        self.headerImage.layer.borderWidth = 1;
        self.headerImage.layer.borderColor = [UIColor whiteColor].CGColor;
        self.headerImage.clipsToBounds = YES;
        [self addSubview:self.headerImage];
    }
    return self;
}


- (void)setAnnotation:(MapUserAnnotationModel *)annotation {
    [super setAnnotation:annotation];
    NSURL *imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[ApiUtils baseUrl],annotation.userImage]];
    [self.headerImage sd_setImageWithURL:imageUrl forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:DEFAULTERRORIMAGE]];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
