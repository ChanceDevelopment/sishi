//
//  MapUserAnnotationModel.m
//  sishi
//
//  Created by likeSo on 2017/1/5.
//  Copyright © 2017年 Channce. All rights reserved.
//

#import "MapUserAnnotationModel.h"

@implementation MapUserAnnotationModel
@synthesize coordinate = _coordinate;
@synthesize title = _title;
@synthesize subtitle = _subtitle;
@synthesize userImage = _userImage;

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate {
    _coordinate = newCoordinate;
}

- (CLLocationCoordinate2D)coordinate {
    return _coordinate;
}

- (void)setTitle:(NSString *)title {
    _title = title;
}

- (NSString *)title {
    return _title;
}

- (void)setSubtitle:(NSString *)subtitle {
    _subtitle = subtitle;
}



- (NSString *)subtitle {
    return _subtitle;
}
@end
