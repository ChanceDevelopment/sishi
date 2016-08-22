//
//  HeHomePageVC.h
//  sishi
//
//  Created by HeDongMing on 16/8/13.
//  Copyright © 2016年 Channce. All rights reserved.
//

#import "HeBaseViewController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Map/BMKMapView.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import "HeSlideMenuVC.h"

@interface HeHomePageVC : HeBaseViewController<BMKMapViewDelegate,BMKLocationServiceDelegate,UITableViewDelegate,UITableViewDataSource,SelectIndexPathProtocol>
{
    IBOutlet BMKMapView* _mapView;
    BMKLocationService* _locService;
}

@end
