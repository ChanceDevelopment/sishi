//
//  ApiUtils.m
//  sishi
//
//  Created by likeSo on 2016/12/21.
//  Copyright © 2016年 Channce. All rights reserved.
//

#import "ApiUtils.h"
#import "sishiDefine.h"

typedef void(^ApiUtilsRequestSuccess)(NSDictionary <NSString *,id> *responseInfo);

typedef void(^ApiUtilsRequestError)(NSError *error);

typedef void(^ApiUtilsResponseError)(NSString *errorInfo);

static AFHTTPSessionManager *sessionManager = nil;

@implementation ApiUtils

+ (NSString *)baseUrl {
    return @"http://118.178.131.215:8088/";
}

+ (AFHTTPSessionManager *)defaultSessionManager {
    if (!sessionManager) {
        sessionManager = [AFHTTPSessionManager manager];
        sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        
        sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/javascript",@"text/plain",@"application/json", nil];
    }
    return sessionManager;
}

+ (void)POST:(NSString *)apiString parameters:(NSDictionary <NSString *,id>*)parameters
                                                        onResponseSuccess:(ApiUtilsRequestSuccess)completeHandler
                                                        onResponseError:(ApiUtilsResponseError)responseError {
    [[ApiUtils defaultSessionManager] POST:apiString
                                parameters:parameters
                                   success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                                       NSLog(@"request api address %@ successed with responseInfo %@",apiString,responseObject);
                                       NSDictionary *responseInfo = (NSDictionary *)responseObject;
                                       NSInteger responseCode = [responseInfo[@"errorCode"] integerValue];//如果返回码是200则把responseObject回调出去,否则获取"data"字段的错误信息放入回调
                                       if (responseCode == 200) {
                                           if (completeHandler) {
                                               completeHandler(responseInfo);
                                           }
                                       } else if (responseError){
                                           NSString *errInfo = responseInfo[@"data"];
                                           responseError(errInfo);
                                       }
    } failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
        NSLog(@"request api address %@ failured with error %@",apiString,error);
        if (responseError) {
            responseError(error.localizedDescription);
        }
    }];
}

+ (void)userRegisterWithNickName:(NSString *)nickName
                           uName:(NSString *)userName
                             psw:(NSString *)psw
                      onResponse:(ApiUtilsSuccessWithVoidResponse)response
                  onRequestError:(ApiUtilsResponseError)errorHandler {
    NSString *registerApi = [NSString stringWithFormat:@"%@%@",[ApiUtils baseUrl],@"Sexton/user/createNewUser.action"];
    
    [ApiUtils POST:registerApi
            parameters:@{@"userNick":nickName,@"userName":userName,@"userPwd":psw}
            onResponseSuccess:^(NSDictionary<NSString *,id> *responseInfo) {
                if (response) {
                    response();
                }
    } onResponseError:^(NSString *errorInfo) {
        if (errorHandler) {
            errorHandler(errorInfo);
        }
    }];
}

+ (void)loginWithUserName:(NSString *)uName
                      psw:(NSString *)psw
                loginType:(NSString *)type
           onResponseInfo:(void(^)(LoginUserInfoModel *loginUserInfo))responseInfo
          onResponseError:(ApiUtilsResponseError)responseError {
    NSString *userLoginApi = [[NSString stringWithFormat:@"%@%@",[ApiUtils baseUrl],@"Sexton/user/userLogin.action"] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [ApiUtils POST:userLoginApi
        parameters:@{@"userName":uName,@"userPwd":psw,@"userJudge":type}
        onResponseSuccess:^(NSDictionary<NSString *,id> *responseObject) {
            NSDictionary *responseJSON = [responseObject objectForKey:@"json"];
            LoginUserInfoModel *loginUserInfo = [LoginUserInfoModel modelObjectWithDictionary:responseJSON];
            if (responseInfo) {
                responseInfo(loginUserInfo);
            }
    } onResponseError:^(NSString *errorInfo) {
        if (responseError) {
            responseError(errorInfo);
        }
    }];
}

+ (void)queryMoodListWithStartIndex:(NSInteger)startIndex
                          longitude:(NSString *)longitude
                           latitude:(NSString *)latitude
                     onResponseInfo:(ApiUtilsSuccessWithResponseList)responseInfo
                    onResponseError:(ApiUtilsResponseError)errorHandler {
    NSString *api = [NSString stringWithFormat:@"%@%@",[ApiUtils baseUrl],@""];
    NSString *uid = @"";
    [ApiUtils POST:api
                            parameters:@{@"userId":uid,@"longitude":longitude,@"latitude":latitude}
                            onResponseSuccess:^(NSDictionary<NSString *,id> *responseInfo) {
                                NSArray <NSDictionary <NSString *,id>*>* responseList = responseInfo[@"json"];
                                NSLog(@"response mood info list %@",responseList);
                                //TODO:获取请求返回内容
    } onResponseError:^(NSString *errorInfo) {
        if (errorHandler) {
            errorHandler(errorInfo);
        }
    }];
}
+ (void)queryMYFocusListWithResponseList:(void(^)(NSArray <UserFollowListModel *>*))successHandler
                                  onError:(ApiUtilsResponseError)responseErrorHandler {
    NSString *api = [NSString stringWithFormat:@"%@%@",[ApiUtils baseUrl],@"Sexton/follow/selFollowInfo.action"];
    NSString *uid = [[NSUserDefaults standardUserDefaults]stringForKey:USERTOKENKEY];
    if (!uid) {
        if (responseErrorHandler) {
            responseErrorHandler(@"当前用户未登录");
        }
        return;
    }
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:uid forKey:@"userId"];
    [ApiUtils POST:api
                parameters:parameters
                onResponseSuccess:^(NSDictionary<NSString *,id> *responseInfo) {
                    NSArray *responseArray = (NSArray *)responseInfo[@"json"];
                    NSMutableArray <UserFollowListModel *>* userFollowList = [NSMutableArray arrayWithCapacity:responseArray.count];
                    for (NSDictionary *dict in responseArray) {
                        UserFollowListModel *followListModel = [UserFollowListModel modelObjectWithDictionary:dict];
                        [userFollowList addObject:followListModel];
                    }
                    if (successHandler) {
                        successHandler(userFollowList);
                    }
    } onResponseError:^(NSString *errorInfo) {
        if (responseErrorHandler) {
            responseErrorHandler(errorInfo);
        }
    }];
}
@end
