//
//  SearchResultController.h
//  sishi
//
//  Created by likeSo on 2016/12/19.
//  Copyright © 2016年 Channce. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 搜索结果展示页面
 */
@interface SearchResultController : UITableViewController
/**
 *  上车地点
 */
@property(nonatomic,strong)NSString *getinCarAddress;

/**
 *  标签列表
 */
@property(nonatomic,strong)NSString *hobbyList;




@end
