//
//  MapUserAnnotationView.h
//  sishi
//
//  Created by likeSo on 2017/1/5.
//  Copyright © 2017年 Channce. All rights reserved.
//

#import <BaiduMapAPI_Map/BMKMapView.h>



/**
 用户大头针View
 */
@interface MapUserAnnotationView : BMKAnnotationView
/**
 *  头像显示View
 */
@property(nonatomic,strong)UIButton *headerImage;

@end
