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

//typedef void(^ApiUtilsRequestError)(NSError *error);

typedef void(^ApiUtilsResponseError)(NSString *errorInfo);

static AFHTTPSessionManager *sessionManager = nil;

@implementation ApiUtils

+ (NSString *)baseUrl {
    return @"http://118.178.131.215:8088/";
//    return @"http://192.168.0.119:8080/";
}

+ (AFHTTPSessionManager *)defaultSessionManager {
    if (!sessionManager) {
        sessionManager = [AFHTTPSessionManager manager];
        sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        sessionManager.requestSerializer.timeoutInterval = 10;
        sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
        sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/javascript",@"text/plain",@"application/json", nil];
    }
    return sessionManager;
}

+ (void)POST:(NSString *)apiString parameters:(NSDictionary <NSString *,id>*)parameters
                                                        onResponseSuccess:(ApiUtilsRequestSuccess)completeHandler
                                                        onResponseError:(ApiUtilsResponseError)responseError {
//    NSLog(@"start request api address %@ with parameters %@",apiString,parameters.description);
    [[ApiUtils defaultSessionManager] POST:apiString
                                parameters:parameters
                                   success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                                       NSDictionary *responseInfo = (NSDictionary *)responseObject;
                                       NSInteger responseCode = [responseInfo[@"errorCode"] integerValue];//如果返回码是200则把responseObject回调出去,否则获取"data"字段的错误信息放入回调
                                       if (responseCode == 200) {
                                           NSLog(@"request api address %@ successed with responseInfo %@",apiString,responseObject);
                                           if (completeHandler) {
                                               completeHandler(responseInfo);
                                           }
                                       } else if (responseError){
                                           NSString *errInfo = responseInfo[@"data"];
                                           if (!errInfo || [errInfo isEqual:[NSNull null]]) {
                                               errInfo = @"未知错误";
                                           }
                                           NSLog(@"request api address %@ failured with response error %@",apiString,errInfo);
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
    NSString *uid = [Tool uid];
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
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setObject:[Tool uid] forKey:@"userId"];
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





+ (NSDictionary *)userInfoWithUserName:(NSString *)uNick userProvince:(NSString *)userProvince userCity:(NSString *)userCity userMonth:(NSString *)month userBirthDat:(NSString *)birthDaty userAge:(NSString *)age gender:(NSString *)gender userHeaderImage:(NSString *)userImage phoneNumber:(NSString *)phone sign:(NSString *)sign {
    NSMutableDictionary *infoDict = [NSMutableDictionary dictionary];
    NSString *userId = [[NSUserDefaults standardUserDefaults]stringForKey:USERIDKEY];
    infoDict[@"userId"] = userId;
    infoDict[@"userNick"] = uNick ? uNick : @"";
    infoDict[@"userProvince"] = userProvince;
    infoDict[@"userCity"] = userCity ? userCity : @"";
    infoDict[@"userMouth"] = month ? month : @"";
    infoDict[@"userDaty"] = birthDaty ? birthDaty : @"";
    infoDict[@"userAge"] = age ? age : @"";
    infoDict[@"userSex"] = gender ? gender : @"";
    infoDict[@"userHeader"] = userImage ? userImage : @"";
    infoDict[@"userPhone"] = phone ? phone : @"";
    infoDict[@"userSign"] = sign ? sign : @"";
    return [NSDictionary dictionaryWithDictionary:infoDict];
}

+ (void)updateUserInfoWith:(NSDictionary *)info onResponseSuccess:(ApiUtilsSuccessWithVoidResponse)compleheHandler onResponseError:(ApiUtilsResponseError)errorHandler {
    
    NSString *api = [NSString stringWithFormat:@"%@%@",[ApiUtils baseUrl],@"Sexton/user/updateUserByUserinfo.action"];
    [ApiUtils POST:api parameters:info onResponseSuccess:^(NSDictionary<NSString *,id> *responseInfo) {
        if (compleheHandler) {
            compleheHandler();
        }
    } onResponseError:^(NSString *errorInfo) {
        if (errorHandler) {
            errorHandler(errorInfo);
        }
    }];
}


+ (void)userCarProveWithUserTrueName:(NSString *)trueName phone:(NSString *)phone carPhoto:(NSString *)photo carType:(NSString *)carType onComplete:(ApiUtilsSuccessWithVoidResponse)completeHandler onResponseError:(ApiUtilsResponseError)errorHandler {
    NSString *api = [NSString stringWithFormat:@"%@%@",[ApiUtils baseUrl],@"Sexton/user/ carProve.action"];
    
    NSDictionary *parameters = @{@"userId":[Tool uid],@"userTrueName":trueName,@"userPhone":phone,@"userCarphoto":photo,@"userDriverphoet":carType};
    [ApiUtils POST:api parameters:parameters onResponseSuccess:^(NSDictionary<NSString *,id> *responseInfo) {
        if (completeHandler) {
            completeHandler();
        }
    } onResponseError:^(NSString *errorInfo) {
        if (errorHandler) {
            errorHandler(errorInfo);
        }
    }];
}

+ (void)userProveWithTrueName:(NSString *)trueName idCard:(NSString *)idCard privatePhoto:(NSString *)userPrivatePhoto onCompleteHandler:(ApiUtilsSuccessWithVoidResponse)completeHandler errorHandler:(ApiUtilsResponseError)errorHandler {
    
    NSString *api = [NSString stringWithFormat:@"%@%@",[ApiUtils baseUrl],@"Sexton/user/userProve.action"];
    NSString *uid = [[NSUserDefaults standardUserDefaults] stringForKey:USERIDKEY];
    NSDictionary *parameters = @{@"userId":uid,@"userTrueName":trueName,@"userCard":idCard,@"userPrivatephoto":userPrivatePhoto};
    [ApiUtils POST:api parameters:parameters onResponseSuccess:^(NSDictionary<NSString *,id> *responseInfo) {
        if (completeHandler) {
            completeHandler();
        }
    } onResponseError:^(NSString *errorInfo) {
        if (errorHandler) {
            errorHandler(errorInfo);
        }
    }];
}

+ (void)queryCurrentUserInfoWithCompleteHander:(void(^)(UserFollowListModel *userModel))completeHandler errorHandler:(ApiUtilsResponseError)errorHandler {
    [ApiUtils queryUserInfoBy:[Tool uid] onCompleteHandler:completeHandler errorHandler:errorHandler];
}

+ (void)queryUserInfoBy:(NSString *)userId onCompleteHandler:(void (^)(UserFollowListModel *))completeHandler errorHandler:(ApiUtilsResponseError)errorHandler {
    NSString *api = [NSString stringWithFormat:@"%@Sexton/user/selectUserInfo.action",[ApiUtils baseUrl]];
    
    [ApiUtils POST:api parameters:@{@"userId":userId} onResponseSuccess:^(NSDictionary<NSString *,id> *responseInfo) {
        NSDictionary *responseJson = (NSDictionary *)[responseInfo objectForKey:@"json"];
        UserFollowListModel *userModel = [UserFollowListModel modelObjectWithDictionary:responseJson];
        if (completeHandler) {
            completeHandler(userModel);
        }
    } onResponseError:^(NSString *errorInfo) {
        if (errorHandler) {
            errorHandler(errorInfo);
        }
    }];
}


+ (void)switchUserStateWithCompleteHandler:(void (^)(NSInteger))completeHandler errorHandler:(ApiUtilsResponseError)errorHandler {
    NSString *api = [NSString stringWithFormat:@"%@Sexton/user/UserSwitch.action",[ApiUtils baseUrl]];
    NSString *uid = [Tool uid];
    [ApiUtils POST:api parameters:@{@"userId":uid} onResponseSuccess:^(NSDictionary<NSString *,id> *responseInfo) {
        NSInteger userState = [[responseInfo objectForKey:@"json"] integerValue];
        
        if (completeHandler) {
            completeHandler(userState);
        }
    } onResponseError:^(NSString *errorInfo) {
        if (errorHandler) {
            errorHandler(errorInfo);
        }
    }];
}

+ (void)updateUserPositionWithLongitude:(CGFloat)longitude latitude:(CGFloat)latitude onUpdateComplete:(ApiUtilsSuccessWithVoidResponse)completeHandler errorHandler:(ApiUtilsResponseError)errorHandler {
    
}

+ (void)queryNearbyUserWithUserGender:(NSString *)gender longitude:(CGFloat)longitude latitude:(CGFloat)latitude startIndex:(NSInteger)startIndex onResponse:(void(^)(NSArray <NearbyUserListModel *>*nearby))completeHandler errorHandler:(ApiUtilsResponseError)errorHandler {
    NSString *api = [NSString stringWithFormat:@"%@Sexton/dynamic/sortUserNearby.action",[ApiUtils baseUrl]];
    NSString *judge = [[Tool judge] isEqualToString:@"0"] ? @"1" : @"0";
    NSDictionary *parameters = @{@"userId":[Tool uid],@"userSex":gender ? @"1" : @"0",@"userJudge":judge,@"longitude":@(longitude),@"latitude":@(latitude),@"number":@(startIndex)};
    [ApiUtils POST:api parameters:parameters onResponseSuccess:^(NSDictionary<NSString *,id> *responseInfo) {
        NSLog(@"回调-------------%@",responseInfo);
        NSArray *nearbyUserList = responseInfo[@"json"];
        if ([nearbyUserList isEqual:[NSNull null]] || nearbyUserList == nil) {
            nearbyUserList = [NSArray array];
        }
        
        NSMutableArray *userList = [NSMutableArray arrayWithCapacity:nearbyUserList.count];
        for (NSDictionary *mapper in nearbyUserList) {
            NearbyUserListModel *userModel = [NearbyUserListModel modelObjectWithDictionary:mapper];
            [userList addObject:userModel];
        }
        if (completeHandler) {
            completeHandler([NSArray arrayWithArray:userList]);
        }
    } onResponseError:^(NSString *errorInfo) {
        if (errorHandler) {
            errorHandler(errorInfo);
        }
    }];
}

+ (void)sendAskingFor:(NSString *)uid tripId:(NSString *)tripId withCompleteHandler:(ApiUtilsSuccessWithVoidResponse)completeHandler errorHandler:(ApiUtilsResponseError)errorHandler {
    NSString *api = [NSString stringWithFormat:@"%@Sexton/ask/setAskingforPeople.action",[ApiUtils baseUrl]];
    NSDictionary *parameters = @{@"userId":[Tool uid],@"askingUserId":uid,@"asktripId":tripId};
    [ApiUtils POST:api
                parameters:parameters
                onResponseSuccess:^(NSDictionary<NSString *,id> *responseInfo) {
                    if (completeHandler) {
                        completeHandler();
                    }
    } onResponseError:^(NSString *errorInfo) {
        if (errorHandler) {
            errorHandler(errorInfo);
        }
    }];
}

+ (void)queryTripListWithUser:(NSString *)uid carOwnerIsend:(NSString *)carOwnerIsend onComplete:(void (^)(NSArray <TripListModel *>*))completeHandler errorHandler:(ApiUtilsResponseError)errorHandler {
    NSString *api = [NSString stringWithFormat:@"%@%@",[ApiUtils baseUrl],@"Sexton/view.action"];
    [ApiUtils POST:api parameters:@{@"carUserid":uid,@"carOwnerIsend":carOwnerIsend} onResponseSuccess:^(NSDictionary<NSString *,id> *responseInfo) {
        NSArray *responseJSONArray = responseInfo[@"json"];
        if (!responseJSONArray || [responseJSONArray isEqual:[NSNull null ]]) {
            responseJSONArray = [NSArray array];
        }
        NSMutableArray *tripModelList = [NSMutableArray arrayWithCapacity:responseJSONArray.count];
        for (NSDictionary *mapper in responseJSONArray) {
            TripListModel *tripModel = [TripListModel modelObjectWithDictionary:mapper];
            [tripModelList addObject:tripModel];
        }
        if (completeHandler) {
            completeHandler([NSArray arrayWithArray:tripModelList]);
        }
    } onResponseError:^(NSString *errorInfo) {
        if (errorHandler) {
            errorHandler(errorInfo);
        }
    }];
}

+ (void)queryMyAskingListWithCompleteHandler:(void (^)(NSArray<NSObject *> *))completeHandler errorHandler:(ApiUtilsResponseError)errorHandler {
    NSString *api = [NSString stringWithFormat:@"%@Sexton/ask/getMeAskingNow.action",[ApiUtils baseUrl]];
    [ApiUtils POST:api
                                    parameters:@{@"userId":[Tool uid]}
                                    onResponseSuccess:^(NSDictionary<NSString *,id> *responseInfo) {
                                        NSArray *responseJSON = (NSArray *)responseInfo[@"userId"];
                                        
    } onResponseError:^(NSString *errorInfo) {
        if (errorHandler) {
            errorHandler(errorInfo);
        }
    }];
}

+ (void)acceptAskingWithAskingId:(NSString *)askingId isAccept:(BOOL)isAccept completeHandler:(ApiUtilsSuccessWithVoidResponse)completeHandler errorHandler:(ApiUtilsResponseError)responseError {
    NSString *api = [NSString stringWithFormat:@"%@Sexton/ask/ acceptTheinvitation.action",[ApiUtils baseUrl]];
    NSDictionary *parameters = @{@"userId":[Tool uid],@"askId":askingId,@"agree":isAccept ? @"1":@"2"};
    [ApiUtils POST:api parameters:parameters onResponseSuccess:^(NSDictionary<NSString *,id> *responseInfo) {
        if (completeHandler) {
            completeHandler();
        }
    } onResponseError:^(NSString *errorInfo) {
        if (responseError) {
            responseError(errorInfo);
        }
    }];
}


+ (void)publishNewDynamicWithContent:(NSString *)content position_x:(CGFloat)position_x position_y:(CGFloat)position_y tripid:(NSString *)tripid wallurl:(NSString *)wallurl onCompleteHandler:(ApiUtilsSuccessWithVoidResponse)completeHandler errorHandler:(ApiUtilsResponseError)errorHandler {
    NSString *api = [NSString stringWithFormat:@"%@Sexton/dynamic/createNewdynamic.action",[ApiUtils baseUrl]];
    NSDictionary *parameters = @{@"userid":[Tool uid],@"content":content,@"position_x":@(position_x),@"position_y":@(position_y),@"tripid":tripid,@"wallurl":wallurl};
    [ApiUtils POST:api parameters:parameters onResponseSuccess:^(NSDictionary<NSString *,id> *responseInfo) {
        if (completeHandler) {
            completeHandler();
        }
    } onResponseError:^(NSString *errorInfo) {
        if (errorHandler) {
            errorHandler(errorInfo);
        }
    }];
}

+ (void)queryAllDynamicAtLongitude:(CGFloat)longitude latitude:(CGFloat)latitude startIndex:(NSInteger)startIndex onCompleteHandler:(void (^)(NSArray<DynamicListModel *> *))completeHandler errorHandler:(ApiUtilsResponseError)errorHandler {
    NSString *api = [NSString stringWithFormat:@"%@Sexton/dynamic/allDynamic.action",[ApiUtils baseUrl]];
    NSDictionary *parameters = @{@"userId":[Tool uid],@"longitude":@(longitude),@"latitude":@(latitude),@"pageNum":@(startIndex)};
    [ApiUtils POST:api parameters:parameters onResponseSuccess:^(NSDictionary<NSString *,id> *responseInfo) {
        NSArray *responseJSON = responseInfo[@"json"];
        if (!responseJSON || [responseJSON isEqual:[NSNull null]]) {
            responseJSON = [NSArray array];
        }
        NSMutableArray <DynamicListModel *>*modelList = [NSMutableArray arrayWithCapacity:responseJSON.count];
        for (NSDictionary *mapper in responseJSON) {
            DynamicListModel *dyModel = [DynamicListModel modelObjectWithDictionary:mapper];
            [modelList addObject:dyModel];
        }
        if (completeHandler) {
            completeHandler(modelList);
        }
    } onResponseError:^(NSString *errorInfo) {
        if (errorHandler) {
            errorHandler(errorInfo);
        }
    }];
}

+ (void)endTripWithTripId:(NSString *)ownerId isEnd:(NSString *)isEnd onComplete:(ApiUtilsSuccessWithVoidResponse)completeHandler onError:(ApiUtilsResponseError)errorHandler {
    NSString *api = [NSString stringWithFormat:@"%@Sexton/isend.action",[ApiUtils baseUrl]];
    NSDictionary *parameters = @{@"carOwnerId":ownerId,@"isend":isEnd,@"userid":[Tool uid]};
    [ApiUtils POST:api parameters:parameters onResponseSuccess:^(NSDictionary<NSString *,id> *responseInfo) {
        if (completeHandler) {
            completeHandler();
        }
    } onResponseError:^(NSString *errorInfo) {
        if (errorHandler) {
            errorHandler(errorInfo);
        }
    }];
}

+ (void)changeTripStateWithTripId:(NSString *)tripId state:(NSString *)state carAccess:(NSString *)carAccess onComplete:(ApiUtilsSuccessWithVoidResponse)completeHandler errorHandler:(ApiUtilsResponseError)errorHandler {
    NSString *api = [NSString stringWithFormat:@"%@Sexton/state.action",[ApiUtils baseUrl]];
    NSDictionary *parameters = @{@"carOwnerId":tripId,@"isstate":state,@"carAccess":carAccess};
    [ApiUtils POST:api parameters:parameters onResponseSuccess:^(NSDictionary<NSString *,id> *responseInfo) {
        if (completeHandler) {
            completeHandler();
        }
    } onResponseError:^(NSString *errorInfo) {
        if (errorHandler) {
            errorHandler(errorInfo);
        }
    }];
}

+ (void)updateTripLocationWithLongitude:(CGFloat)longitude latitude:(CGFloat)latitude withTripId:(NSString *)tripId completeHandler:(ApiUtilsSuccessWithVoidResponse)completeHandler errorHandler:(ApiUtilsResponseError)errorHandler {
    NSString *api = [NSString stringWithFormat:@"%@Sexton/tude.action",[ApiUtils baseUrl]];
    NSDictionary *parameters = @{@"carOwnerId":tripId,@"carOwnerPositionX":@(longitude),@"carOwnerPositionY":@(latitude)};
    [ApiUtils POST:api parameters:parameters onResponseSuccess:^(NSDictionary<NSString *,id> *responseInfo) {
        if (completeHandler) {
            completeHandler();
        }
    } onResponseError:^(NSString *errorInfo) {
        if (errorHandler) {
            errorHandler(errorInfo);
        }
    }];
}

+ (NSDictionary *)tripInfoWithUserGoTime:(NSString *)gotime wishTarget:(NSString *)wish ownerImage:(NSString *)image startPlace:(NSString *)startPlace stopPlace:(NSString *)stopPlace tripNote:(NSString *)note tripType:(NSString *)tripType tripState:(NSString *)tripState receiverId:(NSString *)receivedId longitude:(CGFloat)longitude latitude:(CGFloat)latitude carOwnerState:(NSString *)ownerState {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"carUserid"] = [Tool uid];
    parameters[@"carUserGotime"] = gotime;
    parameters[@"carUserLike"] = wish;
    parameters[@"carOwnerImg"] = image;
    parameters[@"carOwnerStartplace"] = startPlace;
    parameters[@"carOwnerStopplace"] = stopPlace;
    parameters[@"carOwnerNote"] = note;
    parameters[@"carOwnerType"] = tripState;
    parameters[@"carOwnerState"] = ownerState;
    parameters[@"carAccess"] = receivedId;
    parameters[@"carOwnerPositionX"] = @(longitude);
    parameters[@"carOwnerPositionY"] = @(latitude);
    return [NSDictionary dictionaryWithDictionary:parameters];
}

+ (void)publishNewTripWithTripInfo:(NSDictionary *)info completeHandler:(ApiUtilsSuccessWithVoidResponse)completeHandler errorHandler:(ApiUtilsResponseError)errorHandler {
    NSString *api = [NSString stringWithFormat:@"%@%@",[ApiUtils baseUrl],@"Sexton/release.action"];
    [ApiUtils POST:api
                parameters:info
                onResponseSuccess:^(NSDictionary<NSString *,id> *responseInfo) {
                    if (completeHandler) {
                        completeHandler();
                    }
    } onResponseError:^(NSString *errorInfo) {
        if (errorHandler) {
            errorHandler(errorInfo);
        }
    }];
}


+ (void)viewAskedPeopleWithCarOwnerId:(NSString *)ownerId onCompleteHandler:(void(^)(UserFollowListModel *userInfo))completeHandler errorHandler:(ApiUtilsResponseError)errorHandler {
    NSString *api = [NSString stringWithFormat:@"%@Sexton/viewaskedpeople.action",[ApiUtils baseUrl]];
    [ApiUtils POST:api parameters:@{@"carOwnerId":ownerId,@"userId":[Tool uid]} onResponseSuccess:^(NSDictionary<NSString *,id> *responseInfo) {
        NSDictionary *responseJSON = responseInfo[@"json"];
        UserFollowListModel *userModel = [UserFollowListModel modelObjectWithDictionary:responseJSON];
        if (completeHandler) {
            completeHandler(userModel);
        }
    } onResponseError:^(NSString *errorInfo) {
        if (errorHandler) {
            errorHandler(errorInfo);
        }
    }];
}

+ (void)filterUserWithTripId:(NSString *)tripId carUserLike:(NSString *)carUserLike gender:(NSString *)gender userJudge:(NSString *)judge longitude:(CGFloat)longitude latitude:(CGFloat)latitude startIndex:(NSInteger)startIndex onResponseList:(void (^)(NSArray <UserFollowListModel *>*))responseList errorHandler:(ApiUtilsResponseError)errorHandler {
    NSString *api = [NSString stringWithFormat:@"%@Sexton/caruserlike.action",[ApiUtils baseUrl]];
    NSDictionary *parameters = @{@"userId":[Tool uid],@"carOwnerId":tripId,@"carUserLike":carUserLike,@"sex":gender,@"userJudge":judge,@"userPositionX":@(longitude),@"userPositionY":@(latitude),@"number":@(startIndex)};
    [ApiUtils POST:api parameters:parameters onResponseSuccess:^(NSDictionary<NSString *,id> *responseInfo) {
        NSArray *responseJSON = responseInfo[@"json"];
        if (!responseJSON || [responseJSON isEqual:[NSNull null]]) {
            responseJSON = [NSArray array];
        }
        NSMutableArray <UserFollowListModel *>*userModelList = [NSMutableArray arrayWithCapacity:responseJSON.count];
        for (NSDictionary *mapper in responseJSON) {
            UserFollowListModel *userModel = [UserFollowListModel modelObjectWithDictionary:mapper];
            [userModelList addObject:userModel];
        }
        if (responseList) {
            responseList([NSArray arrayWithArray:userModelList]);
        }
    } onResponseError:^(NSString *errorInfo) {
        if (errorHandler) {
            errorHandler(errorInfo);
        }
    }];
}


+ (void)queryAllTripCanTakeWithFilterType:(NSString *)filterRule identity:(NSString *)identity onResponseInfo:(void (^)(NSArray<TripListModel *> *))completeHandler errorHandler:(ApiUtilsResponseError)errorHandler {
    NSString *api = [NSString stringWithFormat:@"%@Sexton/CaruserInfo.action",[ApiUtils baseUrl]];
    NSDictionary *parameters = @{@"carUserSort":filterRule,@"identity":identity,@"carUserid":[Tool uid]};
    [ApiUtils POST:api parameters:parameters onResponseSuccess:^(NSDictionary<NSString *,id> *responseInfo) {
        NSArray *responseJSON = responseInfo[@"json"];
        NSMutableArray *userlist = [NSMutableArray arrayWithCapacity:responseJSON.count];
        for (NSDictionary *mapper in responseJSON) {
            TripListModel *tripUserModel = [TripListModel modelObjectWithDictionary:mapper];
            tripUserModel.isWaitOtherTake = YES;
            [userlist addObject:tripUserModel];
        }
        if (completeHandler) {
            completeHandler([NSArray arrayWithArray:userlist]);
        }
    } onResponseError:^(NSString *errorInfo) {
        if (errorHandler) {
            errorHandler(errorInfo);
        }
    }];
}

+ (void)queryRealtimeTripInfoWithCompleteHandler:(void (^)(NSArray <TripListModel *>*))completeHandler errorHandler:(ApiUtilsResponseError)errorHandler {
    NSString *api = [NSString stringWithFormat:@"%@Sexton/CaruserInfoNow.action",[ApiUtils baseUrl]];
    [ApiUtils POST:api parameters:@{@"carUserid":[Tool uid]} onResponseSuccess:^(NSDictionary<NSString *,id> *responseInfo) {
        NSArray *responseJSON = responseInfo[@"json"];
        NSMutableArray *tripList = [NSMutableArray arrayWithCapacity:responseJSON.count];
        for (NSDictionary *mapper in responseJSON) {
            TripListModel *tripModel = [TripListModel modelObjectWithDictionary:mapper];
            [tripList addObject:tripModel];
        }
        if (completeHandler) {
            completeHandler([NSArray arrayWithArray:tripList]);
        }
    } onResponseError:^(NSString *errorInfo) {
        if (errorHandler) {
            errorHandler(errorInfo);
        }
    }];
}


+ (void)acceptTripWithTripId:(NSString *)tripId onCompleteHandler:(ApiUtilsSuccessWithVoidResponse)completeHandler errorHandler:(ApiUtilsResponseError)errorHandler {
    NSString *api = [NSString stringWithFormat:@"%@Sexton/AccessCaruser.action",[ApiUtils baseUrl]];
    [ApiUtils POST:api parameters:@{@"userId":[Tool uid],@"carownerId":tripId} onResponseSuccess:^(NSDictionary<NSString *,id> *responseInfo) {
        if (completeHandler) {
            completeHandler();
        }
    } onResponseError:^(NSString *errorInfo) {
        if (errorHandler) {
            errorHandler(errorInfo);
        }
    }];
}



+ (void)viewTripInfoWithTripId:(NSString *)tripId completeHandler:(void(^)(TripDetailModel *detailModel))completeHandler errorHandler:(ApiUtilsResponseError)errorHandler {
    NSString *api = [NSString stringWithFormat:@"%@Sexton/CaruserInfoByUser.action",[ApiUtils baseUrl]];
    [ApiUtils POST:api parameters:@{@"carOwnerId":tripId} onResponseSuccess:^(NSDictionary<NSString *,id> *responseInfo) {
        NSDictionary *responseJSON = responseInfo[@"json"];
        TripDetailModel *tripDetailModel = [TripDetailModel modelObjectWithDictionary:responseJSON];
        if (completeHandler) {
            completeHandler(tripDetailModel);
        }
    } onResponseError:^(NSString *errorInfo) {
        if (errorHandler) {
            errorHandler(errorInfo);
        }
    }];
}

+ (void)startTripWithTripId:(NSString *)tripId onCompleteHandler:(ApiUtilsSuccessWithVoidResponse)completeHandler errorHandler:(ApiUtilsResponseError)errorHandler {
    NSString *api = [NSString stringWithFormat:@"%@Sexton/OpenCaruser.action",[ApiUtils baseUrl]];
    [ApiUtils POST:api parameters:@{@"carownerId":tripId} onResponseSuccess:^(NSDictionary<NSString *,id> *responseInfo) {
        if (completeHandler) {
            completeHandler();
        }
    } onResponseError:^(NSString *errorInfo) {
        if (errorHandler) {
            errorHandler(errorInfo);
        }
    }];
}


+ (void)updateTripInfoWithTripId:(NSString *)tripid userGoTime:(NSString *)goTime startPlace:(NSString *)startPlace carUserLike:(NSString *)userLike ownernote:(NSString *)ownernote completeHandler:(ApiUtilsSuccessWithVoidResponse)completeHandler errorHandler:(ApiUtilsResponseError)errorHandler {
    NSString *api = [NSString stringWithFormat:@"%@Sexton/UpdateCaruserInfoByUser.action",[ApiUtils baseUrl]];
    NSDictionary *parameters = @{@"carUserid":[Tool uid],@"carOwnerId":tripid,@"carUserGotime":goTime,@"carOwnerStartplace":startPlace,@"carUserLike":userLike,@"carOwnerNote":ownernote};
    [ApiUtils POST:api parameters:parameters onResponseSuccess:^(NSDictionary<NSString *,id> *responseInfo) {
        if (completeHandler) {
            completeHandler();
        }
    } onResponseError:^(NSString *errorInfo) {
        if (errorHandler) {
            errorHandler(errorInfo);
        }
    }];
}


+ (void)getTripImageWithTripId:(NSString *)tripId onComleteHandler:(void (^)(NSString *))completeHandler errorHandler:(ApiUtilsResponseError)errorHandler {
    NSString *api = [NSString stringWithFormat:@"%@Sexton/GetCarUserPic.action",[ApiUtils baseUrl]];
    [ApiUtils POST:api parameters:@{@"carOwnerId":tripId} onResponseSuccess:^(NSDictionary<NSString *,id> *responseInfo) {
        NSString *responseimagelink = responseInfo[@"json"];
        if (completeHandler) {
            completeHandler(responseimagelink);
        }
    } onResponseError:^(NSString *errorInfo) {
        if (errorHandler) {
            errorHandler(errorInfo);
        }
    }];
}

+ (void)uploadTripImage:(NSString *)image withTripId:(NSString *)tripId completeHandler:(ApiUtilsSuccessWithVoidResponse)completeHandler errorHandler:(ApiUtilsResponseError)errorHandler {
    NSString *api = [NSString stringWithFormat:@"%@Sexton/uploadOederPic.action",[ApiUtils baseUrl]];
    [ApiUtils POST:api parameters:@{@"carOwnerId":tripId,@"uploadPic":image} onResponseSuccess:^(NSDictionary<NSString *,id> *responseInfo) {
        if (completeHandler) {
            completeHandler();
        }
    } onResponseError:^(NSString *errorInfo) {
        if (errorHandler) {
            errorHandler(errorInfo);
        }
    }];
}

+ (void)removeTripImageWithImageName:(NSString *)image inTrip:(NSString *)tripId onCompleteHandler:(ApiUtilsSuccessWithVoidResponse)completeHandler errorHandler:(ApiUtilsResponseError)errorHandler {
    NSString *api = [NSString stringWithFormat:@"%@Sexton/delCarUserPic.action",[ApiUtils baseUrl]];
    [ApiUtils POST:api parameters:@{@"carOwnerId":tripId,@"delPic":image} onResponseSuccess:^(NSDictionary<NSString *,id> *responseInfo) {
        if (completeHandler) {
            completeHandler();
        }
    } onResponseError:^(NSString *errorInfo) {
        if (errorHandler) {
            errorHandler(errorInfo);
        }
    }];
}

+ (void)queryAllHobbyListWithCompleteHandler:(void (^)(NSArray<HobbyListModel *> *))completeHandler errorHandler:(ApiUtilsResponseError)errorHandler {
    NSString *api = [NSString stringWithFormat:@"%@Sexton/love/loveinfo.action",[ApiUtils baseUrl]];
    [ApiUtils POST:api parameters:nil onResponseSuccess:^(NSDictionary<NSString *,id> *responseInfo) {
        NSArray *responseJSON = responseInfo[@"json"];
        NSMutableArray *hobbyList = [NSMutableArray arrayWithCapacity:responseJSON.count];
        for (NSDictionary *mapper in responseJSON) {
            HobbyListModel *hobbyModel = [HobbyListModel modelObjectWithDictionary:mapper];
            [hobbyList addObject:hobbyModel];
        }
        if (completeHandler) {
            completeHandler([NSArray arrayWithArray:hobbyList]);
        }
    } onResponseError:^(NSString *errorInfo) {
        if (errorHandler) {
            errorHandler(errorInfo);
        }
    }];
}

+ (void)userAddHobbyLabelWithLabelName:(NSString *)labelName onComplete:(ApiUtilsSuccessWithVoidResponse)completeHandler errorHandler:(ApiUtilsResponseError)errorHandler {
    NSString *api = [NSString stringWithFormat:@"%@Sexton/love/AddMyloveinfo.action",[ApiUtils baseUrl]];
    [ApiUtils POST:api parameters:@{@"userId":[Tool uid],@"userCarlable":labelName} onResponseSuccess:^(NSDictionary<NSString *,id> *responseInfo) {
        if (completeHandler) {
            completeHandler();
        }
    } onResponseError:^(NSString *errorInfo) {
        if (errorHandler) {
            errorHandler(errorInfo);
        }
    }];
}

+ (void)userFocusWithUserId:(NSString *)userId onComplete:(ApiUtilsSuccessWithVoidResponse)completeHandler onError:(ApiUtilsResponseError)errorHandler {
    NSString *api = [NSString stringWithFormat:@"%@Sexton/follow/AddFollowUser.action",[ApiUtils baseUrl]];
    [ApiUtils POST:api parameters:@{@"userId":[Tool uid],@"followUserId":userId} onResponseSuccess:^(NSDictionary<NSString *,id> *responseInfo) {
        if (completeHandler) {
            completeHandler();
        }
    } onResponseError:^(NSString *errorInfo) {
        if (errorHandler) {
            errorHandler(errorInfo);
        }
    }];
}



+ (void)removeFocusOnUser:(NSString *)uid onComplete:(ApiUtilsSuccessWithVoidResponse)completeHandler errorHandler:(ApiUtilsResponseError)errorHandler {
    NSString *api = [NSString stringWithFormat:@"%@Sexton/follow/DelFollowUser.action",[ApiUtils baseUrl]];
    [ApiUtils POST:api parameters:@{@"userId":[Tool uid],@"followUserId":uid} onResponseSuccess:^(NSDictionary<NSString *,id> *responseInfo) {
        if (completeHandler) {
            completeHandler();
        }
    } onResponseError:^(NSString *errorInfo) {
        if (errorHandler) {
            errorHandler(errorInfo);
        }
    }];
}


+ (void)submitEvaluateUser:(NSString *)targetUserId tripId:(NSString *)tripId labels:(NSString *)labels onComplete:(ApiUtilsSuccessWithVoidResponse)comleteHandler errorHandler:(ApiUtilsResponseError)errorHandler {
    NSString *api = [NSString stringWithFormat:@"%@Sexton/user/SubmitEvaluate.action",[ApiUtils baseUrl]];
    NSDictionary *parameters = @{@"evaluateUser":[Tool uid],@"tripId":tripId,@"evaluateUserCar":targetUserId,@"evaluateLabelid":labels,@"evaluateMark":@""};
    [ApiUtils POST:api parameters:parameters onResponseSuccess:^(NSDictionary<NSString *,id> *responseInfo) {
        if (comleteHandler) {
            comleteHandler();
        }
    } onResponseError:^(NSString *errorInfo) {
        if (errorHandler) {
            errorHandler(errorInfo);
        }
    }];
}

+ (void)queryAllLabelInfoWithCompleteHandler:(void(^)(NSArray <CommentLabelModel *>*))compleheHandler errorHandler:(ApiUtilsResponseError)errorHandler {
    NSString *api = [NSString stringWithFormat:@"%@%@",[ApiUtils baseUrl],@"Sexton/love/lableinfo.action"];
    [ApiUtils POST:api parameters:nil onResponseSuccess:^(NSDictionary<NSString *,id> *responseInfo) {
        NSArray *responseJSONList = responseInfo[@"json"];
        NSMutableArray <CommentLabelModel *>*modellist = [NSMutableArray arrayWithCapacity:responseJSONList.count];
        for (NSDictionary *mapper in responseJSONList) {
            CommentLabelModel *labelModel = [CommentLabelModel modelObjectWithDictionary:mapper];
            [modellist addObject:labelModel];
        }
        if (compleheHandler) {
            compleheHandler([NSArray arrayWithArray:modellist]);
        }
    } onResponseError:^(NSString *errorInfo) {
        if (errorHandler) {
            errorHandler(errorInfo);
        }
    }];
}

//相互之间的评价
+ (void)queryLabelsInfoBetweenMeAnd:(NSString *)otherGuyId inTripId:(NSString *)tripId completeHandler:(void (^)(CommentBetweenUsers *))completeHandler errorHandler:(ApiUtilsResponseError)errorHandler{
    NSString *api = [NSString stringWithFormat:@"%@%@",[ApiUtils baseUrl],@"Sexton/user/selectEvaluateInfoMeTo.action"];
    [ApiUtils POST:api parameters:@{@"userId":[Tool uid],@"otherUserId":otherGuyId,@"tripId":tripId} onResponseSuccess:^(NSDictionary<NSString *,id> *responseInfo) {
        NSDictionary *responseJSONModel = responseInfo[@"json"];
        CommentBetweenUsers *commentModel = [CommentBetweenUsers modelObjectWithDictionary:responseJSONModel];
        if (completeHandler) {
            completeHandler(commentModel);
        }
    } onResponseError:^(NSString *errorInfo) {
        if (errorHandler) {
            errorHandler(errorInfo);
        }
    }];
}

+ (void)complaintsFor:(NSString *)targetUserId content:(NSString *)content complain:(NSInteger)complain completeHandler:(ApiUtilsSuccessWithVoidResponse)completeHandler errorHandler:(ApiUtilsResponseError)errorHandler {
    NSString *api = [NSString stringWithFormat:@"%@%@",[ApiUtils baseUrl],@"Sexton/user/SubmitComplain.action"];
    NSDictionary *parameters = @{@"userId":[Tool uid],@"beUserId":targetUserId,@"complainNote":content,@"complainStar":@(complain)};
    [ApiUtils POST:api parameters:parameters onResponseSuccess:^(NSDictionary<NSString *,id> *responseInfo) {
        if (completeHandler) {
            completeHandler();
        }
    } onResponseError:^(NSString *errorInfo) {
        if (errorHandler) {
            errorHandler(errorInfo);
        }
    }];
}


+ (void)queryWallPicsForUser:(NSString *)uid withCompleteHandler:(void (^)(NSArray<NSString *> *))completeHandler errorHandler:(ApiUtilsResponseError)errorHandler {
    NSString *api = [NSString stringWithFormat:@"%@%@",[ApiUtils baseUrl],@"Sexton/user/GetPaperWallPic.action"];
    [ApiUtils POST:api parameters:@{@"userId":uid} onResponseSuccess:^(NSDictionary<NSString *,id> *responseInfo) {
        NSString *responseImageNames = responseInfo[@"json"];
        NSArray *imageNames = [responseImageNames componentsSeparatedByString:@","];
        NSMutableArray *imageLinks = [NSMutableArray arrayWithCapacity:imageNames.count];
        for (NSString *imageName in imageNames) {
            [imageLinks addObject:[NSString stringWithFormat:@"%@%@",[ApiUtils baseUrl],imageName]];
        }
        if (completeHandler) {
            completeHandler([NSArray arrayWithArray:imageLinks]);
        }
    } onResponseError:^(NSString *errorInfo) {
        if (errorHandler) {
            errorHandler(errorInfo);
        }
    }];
}

+ (void)getMyWallPicsWithCompleteHandler:(void(^)(NSArray <NSString *>*responseImages))completeHandler errorHandler:(ApiUtilsResponseError)errorHandler {
    [ApiUtils queryWallPicsForUser:[Tool uid] withCompleteHandler:completeHandler errorHandler:errorHandler];
}

+ (void)uploadWallPaperWithImageName:(NSString *)imageName onComplete:(ApiUtilsSuccessWithVoidResponse)completeHandler errorHandler:(ApiUtilsResponseError)errorHandler {
    NSString *api = [NSString stringWithFormat:@"%@%@",[ApiUtils baseUrl],@"Sexton/user/uploadPaperWallPic.action"];
    [ApiUtils POST:api parameters:@{@"userId":[Tool uid],@"uploadPic":imageName} onResponseSuccess:^(NSDictionary<NSString *,id> *responseInfo) {
        if (completeHandler) {
            completeHandler();
        }
    } onResponseError:^(NSString *errorInfo) {
        if (errorHandler) {
            errorHandler(errorInfo);
        }
    }];
}

+ (void)deleteWallImageWithImageName:(NSString *)imageName onComplete:(ApiUtilsSuccessWithVoidResponse)completeHandler errorHandler:(ApiUtilsResponseError)errorHandler {
    NSString *api = [NSString stringWithFormat:@"%@%@",[ApiUtils baseUrl],@"Sexton/user/delPaperWallPic.action"];
    [ApiUtils POST:api parameters:@{@"userId":[Tool uid],@"delPic":imageName} onResponseSuccess:^(NSDictionary<NSString *,id> *responseInfo) {
        if (completeHandler) {
            completeHandler();
        }
    } onResponseError:^(NSString *errorInfo) {
        if (errorHandler) {
            errorHandler(errorInfo);
        }
    }];
}

+ (void)queryCommentLabelsForUser:(NSString *)uid withCompleteHandler:(void (^)(NSArray <UserCommentLabelModel *>*))completeHandler errorHandler:(ApiUtilsResponseError)errorHandler {
    NSString *api = [NSString stringWithFormat:@"%@%@",[ApiUtils baseUrl],@"Sexton/user/QueryEvaluateInfo.action"];
    [ApiUtils POST:api parameters:@{@"evaluateUserCar":uid} onResponseSuccess:^(NSDictionary<NSString *,id> *responseInfo) {
        NSDictionary *responseJSONObject = responseInfo[@"json"];
        NSString *jsonString = responseJSONObject[@"evaluateLabelid"];
        NSDictionary *evaluateLabelid = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        NSMutableArray <UserCommentLabelModel *>*labelModels = [NSMutableArray arrayWithCapacity:evaluateLabelid.count];
        for (NSString *key in evaluateLabelid) {//key就是评价的内容
            NSInteger commentCount = [evaluateLabelid[key] integerValue];//评价数量
            UserCommentLabelModel *labelModel = [UserCommentLabelModel new];
            labelModel.labelName = key;
            labelModel.count = commentCount;
            [labelModels addObject:labelModel];
        }
        if (completeHandler) {
            completeHandler([NSArray arrayWithArray:labelModels]);
        }
    } onResponseError:^(NSString *errorInfo) {
        if (errorHandler) {
            errorHandler(errorInfo);
        }
    }];
}


@end
