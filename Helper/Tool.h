//
//  Tool.h
//  iGangGan
//
//  Created by HeDongMing on 15/12/9.
//  Copyright © 2015年 iMac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sys/utsname.h"
#import "User.h"

@interface Tool : NSObject

+ (void)setExtraCellLineHidden: (UITableView *)tableView;

+ (CGSize)sizeWithString:(NSString *)str font:(UIFont *)font maxSize:(CGSize)maxSize;

//获取openUUID
+ (NSString *)getDeviceUUid;

+ (NSString *)getVersion;
+ (NSString *)getPlatformInfo;
+ (NSString *)getCurrentTime;
+ (int)addFileSkipBackupAttribute: (NSString*) filePath;
+ (void)canceliClouldBackup;
//IOS5或者以上的版本处理不备份都iCloud的方法
+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL;
+ (NSString *) checkRegisterAccount:(NSString *)userNameVal;
+ (NSString *) checkRegisterPassword:(NSString *)userPwdVal;
+ (NSDictionary *)getUserDict;
+ (void)initUserWithDict:(NSDictionary *)dict;

+ (int)getUpValueWithValue:(int)value1 otherValue:(int)value2;
+ (int)getColumnNumWithTotalNum:(NSInteger)totalCount;
+ (int)getRowNumWithTotalNum:(NSInteger)totalCount;
+ (int)getRowNumWithTotalNum:(NSInteger)totalCount withMaxRow:(NSInteger)maxrow MaxColumn:(NSInteger)maxcolumn;
+ (int)getColumnNumWithTotalNum:(NSInteger)totalCount withMaxColumn:(NSInteger)maxcolumn;

+ (NSString *)compareCurrentTime:(NSString *)comparedateline;

+ (User *)getUserWithDict:(NSDictionary *)dict;
+ (NSString *)getUserHeadImageURLWithiconAddress:(NSString *)iconAddress;
+ (NSString *)getUserDataPath;
//还没上传到服务器的图片数据的路径
+ (NSString *)getUn_UploadPath;

+ (NSString *)convertTimespToString:(long long)timesp;
+ (long long)convertStringToTimesp:(NSString *)timeString;
+ (NSDate *)convertTimespToDate:(long long)timesp;

+ (NSString *)convertTimespToString:(long long)timesp dateFormate:(NSString *)dateFormate;
+ (long long)convertStringToTimesp:(NSString *)timeString dateFormate:(NSString *)dateFormate;
+ (NSDate *)convertTimespToDate:(long long)timesp dateFormate:(NSString *)dateFormate;

+ (NSDate *)convertTimesToDate:(NSString *)time dateFormate:(NSString *)dateFormate;

+ (NSString *)getAppID;

+ (NSData *)convertHexStrToData:(NSString *)str ;
+ (NSString *)convertDataToHexStr:(NSData *)data;

+ (NSData *)stringToHexData:(NSString *)string;
+ (BOOL)isUserHaveLogin;

+ (UIImage *) buttonImageFromColor:(UIColor *)color withImageSize:(CGSize)imageSize;

//获取app的版本号
+ (NSString *)getAppVersion;
+ (NSString *)getAppBuildVersion;
//获取系统的版本号
+ (NSString *)getSysVersion;
//获取app的协议头
+ (NSString *)getAppScheme;
//判断字符串是否手机号码
+ (BOOL)isMobileNumber:(NSString *)mobileNum;

+ (BOOL)isIDCardNumber:(NSString *)cardNumber;


+ (NSData *)deleteErrorStringInData:(NSData *)inputData;
+ (NSString *)replaceUnicode:(NSString *)unicodeStr;
+ (UIImage *)snapshot:(UIView *)view;


+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate;

//判断当前系统版本是否高于或等于传入的版本号
+ (BOOL)isSystemAvailableOnVersion:(CGFloat)version;

///传入距离米数,比如 1000,返回 一公里
+ (NSString *)distanceFormatWithDistance:(long)distance;



#pragma mark :- User Login State Utils
/**
 *  当前登录的用户Id
 */
@property(nonatomic,class,readonly)NSString *uid;

/**
 *  当前登录用户的性别,男/女
 */
@property(nonatomic,class,readonly)NSString *uGender;


/**
 *  当前登录用户的年龄
 */
@property(nonatomic,class,readonly)NSInteger uAge;

/**
 *  当前登录用户的出生日期
 */
@property(nonatomic,class,readonly)NSString *uBirthday;

/**
 *  当前登录用户的出生月份
 */
@property(nonatomic,class,readonly)NSString *uBirthMonth;


/**
 *  当前用户是否已认证
 */
@property(nonatomic,class,readonly)BOOL isCertificationed;

/**
 *  当前车主是否已认证
 */
@property(nonatomic,assign)BOOL isOwnerCertificationed;


/**
 *   当前登录用户类型  0车主1用户
 */
@property(nonatomic,class,readonly)NSString *judge;

+ (NSString *)defaultsForKey:(NSString *)key;



+ (UIImage *)UIImageFromBase64String:(NSString *)base64;

+ (NSString *)Base64StringFromUIImage:(UIImage *)image;

@end
