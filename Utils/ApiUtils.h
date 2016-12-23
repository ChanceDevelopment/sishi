//
//  ApiUtils.h
//  sishi
//
//  Created by likeSo on 2016/12/21.
//  Copyright © 2016年 Channce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "LoginUserInfoModel.h"
#import "UserFollowListModel.h"


typedef void(^ApiUtilsSuccessWithVoidResponse)(void);

/**
 当返回内容只包含一个布尔时,回调此block

 @param BOOL 内容响应成功或失败
 */
typedef void(^ApiUtilsSuccessWithResponseBool)(BOOL success);

//typedef void(^ApiUtilsErrorWithRequestError)(NSError *error);

typedef void(^ApiUtilsResponseError)(NSString *responseErrorInfo);

typedef void(^ApiUtilsSuccessWithResponseDict)(NSDictionary <NSString *,id>* responseInfo);

typedef void(^ApiUtilsSuccessWithResponseList)(NSArray *responseList);
/**
 
 */
@interface ApiUtils : NSObject

/// 网络请求BaseUrl
//#define kApiBaseUrl @"http://localhost:8080/"

/**
 *  网络请求BaseUrl
 */
@property(nonatomic,strong,class,readonly)NSString *baseUrl;


+ (void)userRegisterWithNickName:(NSString *)nickName
                           uName:(NSString *)userName
                             psw:(NSString *)psw
                      onResponse:(ApiUtilsSuccessWithVoidResponse)response
                     onRequestError:(ApiUtilsResponseError)errorHandler;


/**
 用户登录接口

 @param uName 用户名(手机号)
 @param psw 密码
 @param type 登录类型0车主,1用户
 */
+ (void)loginWithUserName:(NSString *)uName psw:(NSString *)psw loginType:(NSString *)type onResponseInfo:(void(^)(LoginUserInfoModel *loginUserInfo))responseInfo onResponseError:(ApiUtilsResponseError)responseError;

/// 查询 心情(附近动态)列表
+ (void)queryMoodListWithStartIndex:(NSInteger)startIndex longitude:(NSString *)longitude  latitude:(NSString *)latitude onResponseInfo:(ApiUtilsSuccessWithResponseList)responseInfo onResponseError:(ApiUtilsResponseError)errorHandler;


+ (void)queryMYFocusListWithResponseList:(void(^)(NSArray <UserFollowListModel *>*))successHandler onError:(ApiUtilsResponseError)responseErrorHandler;



//配置个人信息更新接口的参数
+ (NSDictionary *)userInfoWithUserName:(NSString *)uNick userProvince:(NSString *)userProvince userCity:(NSString *)userCity userMonth:(NSString *)month userBirthDat:(NSString *)birthDaty userAge:(NSString *)age gender:(NSString *)gender userHeaderImage:(NSString *)userImage phoneNumber:(NSString *)phone sign:(NSString *)sign;

+ (void)updateUserInfoWith:(NSDictionary *)info onResponseSuccess:(ApiUtilsSuccessWithVoidResponse)compleheHandler onResponseError:(ApiUtilsResponseError)errorHandler;




@end
