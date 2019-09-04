//
//  Utils.h
//  BasicProjectFramework
//
//  Created by yjj on 2018/4/11.
//  Copyright © 2018年 Yunjie. All rights reserved.
#import <UserNotifications/UserNotifications.h>
#import <CoreLocation/CoreLocation.h>
#import <Photos/Photos.h>
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>
typedef void (^photoStatus)(PHAuthorizationStatus status);
typedef void(^VideoConversionStatus)(AVAssetExportSessionStatus status,NSURL*pathURL);
@interface Utils : NSObject
//按自符来截取字符串
+ (NSString *)subStringByByteWithIndex:(NSInteger)index  WithString:(NSString*)Str;
//按照中文两个字符，英文数字一个字符计算字符数
+(NSInteger)unicodeLengthOfString:(NSString *) text;
//注册系统相册权限
+(void)requestPhotoPermission:(photoStatus)result;
//跳转到麦克风设置界面
+(void)goToVoiceSetting;
//跳到设置相机界面
+(void)goToCameraSeting;
//跳到设置相册界面
+(void)goToPhotoSeting;
//判断密码合法性
+(BOOL)judgePassWordLegal:(NSString *)pass;
//判断录音权限
+(BOOL)voicePermission;
//判断相机权限
+(BOOL)cameraPermission;
//判断相册权限
+(BOOL)photoPermission;
//获取视频截图
+(UIImage *)thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time;
//视频转换成mp4
+(void)ConverToMp4:(NSURL*)URL ConverStatus:(VideoConversionStatus)status;
//获取视频时长，大小
+(NSDictionary *)getVideoInfoWithSourcePath:(NSURL *)videoURL;
//获取视频路径
+(NSURL*)requestForVideoURL:(NSURL *)videoURL;
//ios系统设置相关
+(NSArray *)getInstalledMapAppWithEndLocation:(CLLocationCoordinate2D)endLocation;
+(void)getCurrentNotificationWithBlock:(nonReturnHasArguments)result;
+(NSString*)dateToStr:(NSDate*)date;
+(NSString*)dateCompareWithDay:(NSDate*)day;
+(NSDateComponents*)takeOutYearMonthDateHourMinSec:(NSDate*)date;
+ (NSDictionary *)paramsFromUrl:(NSString *)url;
//获取开始月份和结束月份
+ (NSArray *)getMonthBeginAndEndWith:(NSString *)dateStr;
+ (NSString *)stringFromDate:(NSDate *)date andFormatter:(NSString *)formatter;
//秒转换成hh:mm:ss格式
+(NSString*)timeWithSeconds:(NSInteger)seconds;
+ (NSDate *)dateFromString:(NSString *)dateString andFormatter:(NSString *)formatter;
//转换成微软CF时间
+(NSString*)strToWCF:(NSString*)str AndFormater:(NSString*)format;
//微软CF时间转换成NSDate
+(NSDate*)WCFToDate:(NSString*)WCFString;
//保留小数
+(NSString*)saveAsTwo:(NSString*)str;

+ (NSString *)URLEncodedString:(NSString *)string;

//+ (NSString*)URLDecodedString:(NSString *)string;

+ (float)systemVersion;

+ (BOOL)isValidateEmail:(NSString *)email;
+ (BOOL) isValidateMobile:(NSString *)mobile;
+ (BOOL) isValidateCode:(NSString *)code;
+ (BOOL) isValidatePassword:(NSString *)password;
+ (BOOL) isValidateTime:(NSString *)password;
+ (BOOL) isValidateNumber:(NSString *)code;

+ (NSString *) treeViews: (UIView *) aView;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;


+ (NSString *) wifiDecrypt:(NSString*)str;
+ (NSString *) wifiEncrypt:(NSString*)str;

+ (NSString *) uuid;
+ (NSString *) idfa;

+ (NSString *) decimalwithFormat:(NSString *)format  floatV:(float)floatV;

+ (CGFloat) heightForString:(NSString *)str withFont:(UIFont *)font withWidth:(CGFloat)width;

+ (UIImage *)imageFixOrientation:(UIImage *)aImage;

+ (NSMutableAttributedString *)tranformAttributedStringFromString:(NSString *)string WithRange:(NSRange)range AndAttribute:(NSString *)attributeName Value:(id)value;
+(NSInteger)orderAtLetter:(NSString*)letter;
//以下两个压缩系数不同
//用于头像上传压缩，发送消息
+(NSData *)imageProcessWithOldImage:(UIImage *)image;
//用于普通图片上传压缩,主要用于列表展示
+(NSData*)listImageWithOldImage:(UIImage*)image;
//根据尺寸重新绘制图片
+(UIImage*)drawImageWithImg:(UIImage*)image WithSize:(CGSize)size;
@end
