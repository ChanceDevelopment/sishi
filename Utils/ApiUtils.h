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
#import "NearbyUserListModel.h"
#import "DynamicListModel.h"
#import "TripListModel.h"
#import "TripDetailModel.h"
#import "HobbyListModel.h"
#import "CommentLabelModel.h"
#import "CommentBetweenUsers.h"
#import "TripListModel.h"

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
/**
 *  网络请求BaseUrl
 */
@property(nonatomic,class,readonly)NSString *baseUrl;

///用户注册
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

///查询我关注的用户列表
+ (void)queryMYFocusListWithResponseList:(void(^)(NSArray <UserFollowListModel *>*))successHandler onError:(ApiUtilsResponseError)responseErrorHandler;



//配置个人信息更新接口的参数
+ (NSDictionary *)userInfoWithUserName:(NSString *)uNick userProvince:(NSString *)userProvince userCity:(NSString *)userCity userMonth:(NSString *)month userBirthDat:(NSString *)birthDaty userAge:(NSString *)age gender:(NSString *)gender userHeaderImage:(NSString *)userImage phoneNumber:(NSString *)phone sign:(NSString *)sign;

+ (void)updateUserInfoWith:(NSDictionary *)info onResponseSuccess:(ApiUtilsSuccessWithVoidResponse)compleheHandler onResponseError:(ApiUtilsResponseError)errorHandler;


///车辆认证接口
+ (void)userCarProveWithUserTrueName:(NSString *)trueName phone:(NSString *)phone carPhoto:(NSString *)photo carType:(NSString *)carType onComplete:(ApiUtilsSuccessWithVoidResponse)completeHandler onResponseError:(ApiUtilsResponseError)errorHandler;

+ (void)userProveWithTrueName:(NSString *)trueName idCard:(NSString *)idCard privatePhoto:(NSString *)userPrivatePhoto onCompleteHandler:(ApiUtilsSuccessWithVoidResponse)completeHandler errorHandler:(ApiUtilsResponseError)errorHandler;


///查询当前登录用户信息
+ (void)queryCurrentUserInfoWithCompleteHander:(void(^)(UserFollowListModel *userModel))completeHandler errorHandler:(ApiUtilsResponseError)errorHandler;

+ (void)queryUserInfoBy:(NSString *)userId onCompleteHandler:(void(^)(UserFollowListModel *userModel))completeHandler errorHandler:(ApiUtilsResponseError)errorHandler;

///切换用户身份
+ (void)switchUserStateWithCompleteHandler:(void(^)(NSInteger state))completeHandler errorHandler:(ApiUtilsResponseError)errorHandler;

///更新用户位置
+ (void)updateUserPositionWithLongitude:(CGFloat)longitude latitude:(CGFloat)latitude onUpdateComplete:(ApiUtilsSuccessWithVoidResponse)completeHandler errorHandler:(ApiUtilsResponseError)errorHandler;


///查询附近用户(如果是车主则查询用户,反之查车主)
+ (void)queryNearbyUserWithUserGender:(NSString *)gender longitude:(CGFloat)longitude latitude:(CGFloat)latitude startIndex:(NSInteger)startIndex onResponse:(void(^)(NSArray <NearbyUserListModel *>*nearby))completeHandler errorHandler:(ApiUtilsResponseError)errorHandler;


+ (void)sendAskingFor:(NSString *)uid tripId:(NSString *)tripId withCompleteHandler:(ApiUtilsSuccessWithVoidResponse)completeHandler errorHandler:(ApiUtilsResponseError)errorHandler;

+ (void)queryMyAskingListWithCompleteHandler:(void(^)(NSArray <NSObject *>* dataList))completeHandler errorHandler:(ApiUtilsResponseError)errorHandler;

//处理邀约(同意/拒绝)
+ (void)acceptAskingWithAskingId:(NSString *)askingId isAccept:(BOOL)isAccept completeHandler:(ApiUtilsSuccessWithVoidResponse)completeHandler errorHandler:(ApiUtilsResponseError)responseError;


+ (void)publishNewDynamicWithContent:(NSString *)content position_x:(CGFloat)position_x position_y:(CGFloat)position_y tripid:(NSString *)tripid wallurl:(NSString *)wallurl onCompleteHandler:(ApiUtilsSuccessWithVoidResponse)completeHandler errorHandler:(ApiUtilsResponseError)errorHandler;


+ (void)queryAllDynamicAtLongitude:(CGFloat)longitude latitude:(CGFloat)latitude startIndex:(NSInteger)startIndex onCompleteHandler:(void(^)(NSArray <DynamicListModel *>*dynamicList))completeHandler errorHandler:(ApiUtilsResponseError)errorHandler;

///查看行程列表
+ (void)queryTripListWithUser:(NSString *)uid carOwnerIsend:(NSString *)carOwnerIsend onComplete:(void(^)(NSArray <TripListModel *>*))completeHandler errorHandler:(ApiUtilsResponseError)errorHandler;




+ (void)endTripWithTripId:(NSString *)ownerId isEnd:(NSString *)isEnd onComplete:(ApiUtilsSuccessWithVoidResponse)completeHandler onError:(ApiUtilsResponseError)errorHandler;

+ (void)changeTripStateWithTripId:(NSString *)tripId state:(NSString *)state carAccess:(NSString *)carAccess onComplete:(ApiUtilsSuccessWithVoidResponse)completeHandler errorHandler:(ApiUtilsResponseError)errorHandler;

+ (void)updateTripLocationWithLongitude:(CGFloat)longitude latitude:(CGFloat)latitude withTripId:(NSString *)tripId completeHandler:(ApiUtilsSuccessWithVoidResponse)completeHandler errorHandler:(ApiUtilsResponseError)errorHandler;

+ (NSDictionary *)tripInfoWithUserGoTime:(NSString *)gotime wishTarget:(NSString *)wish ownerImage:(NSString *)image startPlace:(NSString *)startPlace stopPlace:(NSString *)stopPlace tripNote:(NSString *)note tripType:(NSString *)tripType tripState:(NSString *)tripState receiverId:(NSString *)receivedId longitude:(CGFloat)longitude latitude:(CGFloat)latitude carOwnerState:(NSString *)ownerState;
+ (void)publishNewTripWithTripInfo:(NSDictionary *)info completeHandler:(ApiUtilsSuccessWithVoidResponse)completeHandler errorHandler:(ApiUtilsResponseError)errorHandler;

+ (void)viewAskedPeopleWithCarOwnerId:(NSString *)ownerId onCompleteHandler:(void(^)(UserFollowListModel *userInfo))completeHandler errorHandler:(ApiUtilsResponseError)errorHandler;

+ (void)filterUserWithTripId:(NSString *)tripId carUserLike:(NSString *)carUserLike  gender:(NSString *)gender userJudge:(NSString *)judge longitude:(CGFloat)longitude latitude:(CGFloat)latitude  startIndex:(NSInteger)startIndex onResponseList:(void(^)(NSArray *))responseList errorHandler:(ApiUtilsResponseError)errorHandler;


+ (void)queryAllTripCanTakeWithFilterType:(NSString *)filterRule identity:(NSString *)identity onResponseInfo:(void(^)(NSArray <TripListModel *>*))completeHandler errorHandler:(ApiUtilsResponseError)errorHandler;

+ (void)queryRealtimeTripInfoWithCompleteHandler:(void(^)(NSArray <TripListModel *>*))completeHandler errorHandler:(ApiUtilsResponseError)errorHandler;



+ (void)acceptTripWithTripId:(NSString *)tripId onCompleteHandler:(ApiUtilsSuccessWithVoidResponse)completeHandler errorHandler:(ApiUtilsResponseError)errorHandler;


+ (void)viewTripInfoWithTripId:(NSString *)tripId completeHandler:(void(^)(TripDetailModel *detailModel))completeHandler errorHandler:(ApiUtilsResponseError)errorHandler;

+ (void)startTripWithTripId:(NSString *)tripId onCompleteHandler:(ApiUtilsSuccessWithVoidResponse)completeHandler errorHandler:(ApiUtilsResponseError)errorHandler;

+ (void)updateTripInfoWithTripId:(NSString *)tripid userGoTime:(NSString *)goTime startPlace:(NSString *)startPlace carUserLike:(NSString *)userLike ownernote:(NSString *)ownernote completeHandler:(ApiUtilsSuccessWithVoidResponse)completeHandler errorHandler:(ApiUtilsResponseError)errorHandler;


+ (void)getTripImageWithTripId:(NSString *)tripId onComleteHandler:(void(^)(NSString *image))completeHandler errorHandler:(ApiUtilsResponseError)errorHandler;

+ (void)uploadTripImage:(NSString *)image withTripId:(NSString *)tripId completeHandler:(ApiUtilsSuccessWithVoidResponse)completeHandler errorHandler:(ApiUtilsResponseError)errorHandler;

+ (void)removeTripImageWithImageName:(NSString *)image inTrip:(NSString *)tripId onCompleteHandler:(ApiUtilsSuccessWithVoidResponse)completeHandler errorHandler:(ApiUtilsResponseError)errorHandler;



+ (void)queryAllHobbyListWithCompleteHandler:(void(^)(NSArray <HobbyListModel *>*))completeHandler errorHandler:(ApiUtilsResponseError)errorHandler;

+ (void)userAddHobbyLabelWithLabelName:(NSString *)labelName onComplete:(ApiUtilsSuccessWithVoidResponse)completeHandler errorHandler:(ApiUtilsResponseError)errorHandler;

+ (void)userFocusWithUserId:(NSString *)userId onComplete:(ApiUtilsSuccessWithVoidResponse)completeHandler onError:(ApiUtilsResponseError)errorHandler;

+ (void)removeFocusOnUser:(NSString *)uid onComplete:(ApiUtilsSuccessWithVoidResponse)completeHandler errorHandler:(ApiUtilsResponseError)errorHandler;


+ (void)submitEvaluateUser:(NSString *)targetUserId tripId:(NSString *)tripId labels:(NSString *)labels onComplete:(ApiUtilsSuccessWithVoidResponse)comleteHandler errorHandler:(ApiUtilsResponseError)errorHandler;

//--
+ (void)queryAllLabelInfoWithCompleteHandler:(void(^)(NSArray <CommentLabelModel *>*))compleheHandler errorHandler:(ApiUtilsResponseError)errorHandler;

//相互之间的评价
+ (void)queryLabelsInfoBetweenMeAnd:(NSString *)otherGuyId inTripId:(NSString *)tripId completeHandler:(void(^)(CommentBetweenUsers *))completeHandler errorHandler:(ApiUtilsResponseError)errorHandler;

+ (void)complaintsFor:(NSString *)targetUserId content:(NSString *)content complain:(NSInteger)complain completeHandler:(ApiUtilsSuccessWithVoidResponse)completeHandler errorHandler:(ApiUtilsResponseError)errorHandler;


+ (void)getMyWallPicsWithCompleteHandler:(void(^)(NSArray <NSString *>*responseImages))completeHandler errorHandler:(ApiUtilsResponseError)errorHandler;

+ (void)uploadWallPaperWithImageName:(NSString *)imageName onComplete:(ApiUtilsSuccessWithVoidResponse)completeHandler errorHandler:(ApiUtilsResponseError)errorHandler;

+ (void)deleteWallImageWithImageName:(NSString *)imageName onComplete:(ApiUtilsSuccessWithVoidResponse)completeHandler errorHandler:(ApiUtilsResponseError)errorHandler;
@end
