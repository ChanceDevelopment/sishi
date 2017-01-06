//
//  MapUserAnnotationModel.h
//  sishi
//
//  Created by likeSo on 2017/1/5.
//  Copyright © 2017年 Channce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BaiduMapAPI_Base/BMKMapManager.h>



@interface MapUserAnnotationModel : NSObject <BMKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;


/**
 *  标题
 */
@property(nonatomic,strong)NSString *title;

/**
 *  副标题
 */
@property(nonatomic,strong)NSString *subtitle;


/**
 *  用户头像
 */
@property(nonatomic,strong)NSString *userImage;


@end
