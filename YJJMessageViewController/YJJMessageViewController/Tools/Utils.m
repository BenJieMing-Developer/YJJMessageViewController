//
//  Utils.m
//  BasicProjectFramework
//
//  Created by yjj on 2018/4/11.
//  Copyright © 2018年 Yunjie. All rights reserved.
//

#import "Utils.h"

@implementation Utils
+(NSString *)subStringByByteWithIndex:(NSInteger)index  WithString:(NSString*)Str{
    
    NSInteger sum = 0;
    
    NSString *subStr = [[NSString alloc] init];
    
    for(int i = 0; i<[Str length]; i++){
        unichar strChar = [Str characterAtIndex:i];
        
        if(strChar < 256){
            sum += 1;
        }
        else {
            sum += 2;
        }
        if (sum >= index) {
            
            subStr = [Str substringToIndex:i+1];
            return subStr;
        }
        
    }
    return subStr;
}

+(NSInteger)unicodeLengthOfString:(NSString *) text {
    NSUInteger asciiLength = 0;
    for (NSUInteger i = 0; i < text.length; i++) {
        unichar uc = [text characterAtIndex: i];
        asciiLength += isascii(uc) ? 1 : 2;
    }
    return asciiLength;
}
+(void)requestPhotoPermission:(photoStatus)result
{
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        dispatch_async(dispatch_get_main_queue(), ^{
            result(status);
        });
        
    }];
    
}

+(void)goToVoiceSetting
{
    
    NSURL *settingURL =[NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([[UIDevice currentDevice].systemVersion floatValue]<10.0) {
        if([[UIApplication sharedApplication] canOpenURL:settingURL])
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }
        
    }
    else
    {
        if([[UIApplication sharedApplication] canOpenURL:settingURL])
        {
            if (@available(iOS 10.0, *)) {
                [[UIApplication sharedApplication] openURL:settingURL options:@{} completionHandler:^(BOOL success) {
                    
                }];
            } else {
                // Fallback on earlier versions
            }
        }
        
        
    }
}
+(void)goToPhotoSeting
{
    
    NSURL *settingURL =[NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([[UIDevice currentDevice].systemVersion floatValue]<10.0) {
        if([[UIApplication sharedApplication] canOpenURL:settingURL])
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }
        
    }
    else
    {
        if([[UIApplication sharedApplication] canOpenURL:settingURL])
        {
            if (@available(iOS 10.0, *)) {
                [[UIApplication sharedApplication] openURL:settingURL options:@{} completionHandler:^(BOOL success) {
                    
                }];
            } else {
                // Fallback on earlier versions
            }
        }
        
        
    }
}
+(void)goToCameraSeting
{
    NSURL *settingURL =[NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([[UIDevice currentDevice].systemVersion floatValue]<10.0) {
        if([[UIApplication sharedApplication] canOpenURL:settingURL])
        {
            [[UIApplication sharedApplication] openURL:settingURL];
        }
        
    }
    else
    {
        if([[UIApplication sharedApplication] canOpenURL:settingURL])
        {
            if (@available(iOS 10.0, *)) {
                [[UIApplication sharedApplication] openURL:settingURL options:@{} completionHandler:^(BOOL success) {
                    
                }];
            } else {
                // Fallback on earlier versions
            }
        }
        
        
    }
    
}
+(BOOL)voicePermission
{
    NSString *mediaType = AVMediaTypeAudio;//读取媒体类型
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];//读取设备授权状态
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        return NO;
        
    }
    return YES;
}
+(BOOL)cameraPermission
{
    NSString *mediaType = AVMediaTypeVideo;//读取媒体类型
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];//读取设备授权状态
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        return NO;
        
    }
    return YES;
}
+(BOOL)photoPermission
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0) {
        ALAuthorizationStatus author =[ALAssetsLibrary authorizationStatus];
        if (author == kCLAuthorizationStatusRestricted || author == kCLAuthorizationStatusDenied) {
            //无权限
            return NO;
        }
    }
    else {
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        if (status == PHAuthorizationStatusRestricted ||
            status == PHAuthorizationStatusDenied) {
            //无权限
            return NO;
        }
    }
    return YES;
}
+(void)ConverToMp4:(NSURL *)URL ConverStatus:(VideoConversionStatus)status
{
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:URL options:nil];
    
    NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
    
    NSLog(@"%@",compatiblePresets);
    
    if ([compatiblePresets containsObject:AVAssetExportPresetHighestQuality]) {
        
        AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:avAsset presetName:AVAssetExportPresetHighestQuality];
        
        NSDateFormatter *formater = [[NSDateFormatter alloc] init];//用时间给文件全名，以免重复
        
        [formater setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
        
        NSString * resultPath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/output-%@.mp4", [formater stringFromDate:[NSDate date]]];
        
        NSLog(@"resultPath = %@",resultPath);
        
        exportSession.outputURL = [NSURL fileURLWithPath:resultPath];
        
        exportSession.outputFileType = AVFileTypeMPEG4;
        
        exportSession.shouldOptimizeForNetworkUse = YES;
        
        [exportSession exportAsynchronouslyWithCompletionHandler:^(void)
         
         {
             status(exportSession.status,exportSession.outputURL);
             
         }];
        
    }
}
+(NSURL*)requestForVideoURL:(NSURL *)videoURL
{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    return asset.URL;
}
+(NSDictionary *)getVideoInfoWithSourcePath:(NSURL *)videoURL{
    AVURLAsset * asset = [AVURLAsset assetWithURL:videoURL];
    CMTime   time = [asset duration];
    int seconds = ceil(time.value/time.timescale);
    NSInteger   fileSize = [[NSFileManager defaultManager] attributesOfItemAtPath:videoURL.absoluteString error:nil].fileSize;
    return @{@"size" : @(fileSize),
             @"duration" : @(seconds)};
}

+(UIImage *)thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time{
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    NSParameterAssert(asset);
    AVAssetImageGenerator *assetImageGenerator =[[AVAssetImageGenerator alloc] initWithAsset:asset];
    assetImageGenerator.requestedTimeToleranceAfter = kCMTimeZero;
    assetImageGenerator.requestedTimeToleranceBefore = kCMTimeZero;
    assetImageGenerator.appliesPreferredTrackTransform = YES;
    assetImageGenerator.apertureMode =AVAssetImageGeneratorApertureModeEncodedPixels;
    CGImageRef thumbnailImageRef = NULL;
    CFTimeInterval thumbnailImageTime = time;
    NSError *thumbnailImageGenerationError = nil;
    thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 60)actualTime:NULL error:&thumbnailImageGenerationError];
    if(!thumbnailImageRef){
        NSLog(@"thumbnailImageGenerationError %@",thumbnailImageGenerationError);
    }
    UIImage *thumbnailImage = thumbnailImageRef ? [[UIImage alloc]initWithCGImage:thumbnailImageRef] : nil;
    return thumbnailImage;
}

#pragma mark - 获取可以跳转的地图
+ (NSArray *)getInstalledMapAppWithEndLocation:(CLLocationCoordinate2D)endLocation
{
    NSMutableArray *maps = [NSMutableArray array];
    
    //苹果地图
    NSMutableDictionary *iosMapDic = [NSMutableDictionary dictionary];
    iosMapDic[@"title"] = @"苹果地图";
    [maps addObject:iosMapDic];
    
    //百度地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]) {
        NSMutableDictionary *baiduMapDic = [NSMutableDictionary dictionary];
        baiduMapDic[@"title"] = @"百度地图";
        NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%f,%f|name=北京&mode=driving&coord_type=gcj02",endLocation.latitude,endLocation.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        baiduMapDic[@"url"] = urlString;
        [maps addObject:baiduMapDic];
    }
    
    //高德地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {
        NSMutableDictionary *gaodeMapDic = [NSMutableDictionary dictionary];
        gaodeMapDic[@"title"] = @"高德地图";
        NSString *urlString = [[NSString stringWithFormat:@"iosamap://navi?sourceApplication=%@&backScheme=%@&lat=%f&lon=%f&dev=0&style=2",@"导航功能",@"nav123456",endLocation.latitude,endLocation.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        gaodeMapDic[@"url"] = urlString;
        [maps addObject:gaodeMapDic];
    }
    
    //谷歌地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps://"]]) {
        NSMutableDictionary *googleMapDic = [NSMutableDictionary dictionary];
        googleMapDic[@"title"] = @"谷歌地图";
        NSString *urlString = [[NSString stringWithFormat:@"comgooglemaps://?x-source=%@&x-success=%@&saddr=&daddr=%f,%f&directionsmode=driving",@"导航测试",@"nav123456",endLocation.latitude, endLocation.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        googleMapDic[@"url"] = urlString;
        [maps addObject:googleMapDic];
    }
    
    //腾讯地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"qqmap://"]]) {
        NSMutableDictionary *qqMapDic = [NSMutableDictionary dictionary];
        qqMapDic[@"title"] = @"腾讯地图";
        NSString *urlString = [[NSString stringWithFormat:@"qqmap://map/routeplan?from=我的位置&type=drive&tocoord=%f,%f&to=终点&coord_type=1&policy=0",endLocation.latitude, endLocation.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        qqMapDic[@"url"] = urlString;
        [maps addObject:qqMapDic];
    }
    
    return maps;
    
}
+(void)getCurrentNotificationWithBlock:(nonReturnHasArguments)result;
{
    
    if (@available(iOS 10.0, *)) {
        [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            
            result(settings);
        }];
        
        
    } else {
        
        // Fallback on earlier versions
    }
    
    
    
}

+(NSString*)dateToStr:(NSDate*)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *strDate = [dateFormatter stringFromDate:date];
    return strDate;
}
+(NSDateComponents*)takeOutYearMonthDateHourMinSec:(NSDate*)date
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth|  NSCalendarUnitDay|NSCalendarUnitMinute|NSCalendarUnitHour|NSCalendarUnitCalendar;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:date];
    return comp1;
    
}
+(NSString*)dateCompareWithDay:(NSDate*)day
{
    
    NSString *dateContent;
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    NSDate *today=[[NSDate alloc] init];
    NSDate*tommorow= [[NSDate alloc] initWithTimeIntervalSinceNow:secondsPerDay];
    NSDate*houTian=[[NSDate alloc] initWithTimeIntervalSinceNow:secondsPerDay*2];
    //假设这是你要比较的date：NSDate *yourDate = ……
    //日历
    NSCalendar* calendar = [NSCalendar currentCalendar];
    unsigned unitFlags =NSCalendarUnitYear | NSCalendarUnitMonth|  NSCalendarUnitDay;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:day];
    NSDateComponents* comp4 = [calendar components:unitFlags fromDate:today];
    NSDateComponents*comp2= [calendar components:unitFlags fromDate:tommorow];
    NSDateComponents*comp3= [calendar components:unitFlags fromDate:houTian];
    if ( comp1.year == comp2.year && comp1.month == comp2.month && comp1.day == comp2.day) {
        dateContent = [NSString stringWithFormat:@"明天 %@",[[self dateToStr:day]substringWithRange:NSMakeRange(10,[self dateToStr:day].length-13)]];
    }
    else if (comp1.year == comp3.year && comp1.month == comp3.month && comp1.day == comp3.day)
    {
        dateContent = [NSString stringWithFormat:@"后天 %@",[[self dateToStr:day]substringWithRange:NSMakeRange(10,[self dateToStr:day].length-13)]];
    }
    else if (comp1.year == comp4.year && comp1.month == comp4.month && comp1.day == comp4.day)
    {
        
        dateContent =[NSString stringWithFormat:@"今天 %@",[[self dateToStr:day]substringWithRange:NSMakeRange(10,[self dateToStr:day].length-13)]];
        
    }
    else
    {
        //返回0说明该日期不是今天、昨天、前天
        dateContent = [[self dateToStr:day]substringWithRange:NSMakeRange(5,[self dateToStr:day].length-8)];
    }
    return dateContent;
    
    
}
+ (NSDictionary *)paramsFromUrl:(NSString *)url{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
    NSRange range = [url rangeOfString:@"?"];
    if (range.length != 1) {
        return dic;
    }
    NSString * query = [url substringFromIndex:[url rangeOfString:@"?"].location+1];
    
    NSArray * strings = [query componentsSeparatedByString:@"&"];
    
    for (NSString * tmp in strings) {
        NSArray * tmps = [tmp componentsSeparatedByString:@"="];
        
        NSString * key = [tmps objectAtIndex:0];
        
        NSString * value = [tmps objectAtIndex:1];
        
        if ([self isValidateInteger:value]) {
            [dic setValue:@(value.integerValue) forKey:key];
        }
        else if ([self isValidateFloat:value]) {
            [dic setValue:@(value.floatValue) forKey:key];
        }
        else{
            [dic setValue:value forKey:key];
        }
        
        
        
    }
    return dic;
}

+ (BOOL) isValidateInteger:(NSString *)string
{
    
    NSString *phoneRegex = @"^[1-9]\\d*$";
    NSPredicate *phonePre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phonePre evaluateWithObject:string];
}

+ (BOOL) isValidateFloat:(NSString *)string
{
    
    NSString *phoneRegex = @"^[1-9]\\d*\\.\\d*|0\\.\\d*[1-9]\\d*$";
    NSPredicate *phonePre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phonePre evaluateWithObject:string];
}

+ (NSArray *)getMonthBeginAndEndWith:(NSString *)dateStr{
    
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM"];
    NSDate *newDate=[format dateFromString:dateStr];
    double interval = 0;
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar setFirstWeekday:2];//设定周一为周首日
    BOOL ok = [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&beginDate interval:&interval forDate:newDate];
    //分别修改为 NSDayCalendarUnit NSWeekCalendarUnit NSYearCalendarUnit
    if (ok) {
        endDate = [beginDate dateByAddingTimeInterval:interval-1];
    }else {
        return @[];
    }
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"dd"];
    NSString *beginString = [myDateFormatter stringFromDate:beginDate];
    NSString *endString = [myDateFormatter stringFromDate:endDate];
    return @[beginString,endString];
}
+ (NSString *)stringFromDate:(NSDate *)date andFormatter:(NSString *)formatter{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    
    
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。yyyy-MM-dd HH:mm:ss
    
    [dateFormatter setDateFormat:formatter];
    
    
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    
    
    return destDateString;
    
}

+ (NSDate *)dateFromString:(NSString *)dateString andFormatter:(NSString *)formatter{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:formatter];
    
    
    
    
    
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    
    
    return destDate;
    
}
+(NSDate*)WCFToDate:(NSString*)WCFString
{
    return [NSDate dateWithTimeIntervalSince1970:[[[WCFString  substringWithRange:NSMakeRange(6, WCFString.length-8)]componentsSeparatedByString:@"+"][0] doubleValue]/1000.000];
}
+(NSString*)strToWCF:(NSString*)str AndFormater:(NSString*)format
{
    NSString*str1=[NSString stringWithFormat:@"%f",[[Utils dateFromString:str andFormatter:format] timeIntervalSince1970]*1000.00 ];
    NSInteger interval=[str1 integerValue];
    NSString*Str2=[NSString stringWithFormat:@"/Date(%ld+0800)/",interval];
    return Str2;
}

+ (NSString *)URLEncodedString:(NSString *)string
{
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)string,NULL,CFSTR("!*'();:@&=+$,/?%#[]"),kCFStringEncodingUTF8));
    
    return result;
}

-(NSString *)URLDecodedString:(NSString *)str
{
    NSString *decodedString=(__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)str, CFSTR(""), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    
    return decodedString;
}
+ (float)systemVersion{
    return [[UIDevice currentDevice].systemVersion floatValue];
}

+ (BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailPre evaluateWithObject:email];
}

+ (BOOL) isValidateMobile:(NSString *)mobile
{
    
    NSString *phoneRegex = @"^[1][3,4,5,7,8][0-9]{9}$";
    NSPredicate *phonePre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phonePre evaluateWithObject:mobile];
}

+ (BOOL) isValidateCode:(NSString *)code{
    NSString *codeRegex = @"^[0-9]{4}$";
    NSPredicate *codePre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",codeRegex];
    return [codePre evaluateWithObject:code];
}

+ (BOOL) isValidateNumber:(NSString *)code{
    NSString *codeRegex = @"^[0-9]*$";
    NSPredicate *codePre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",codeRegex];
    return [codePre evaluateWithObject:code];
}
/*
 *  判断用户输入的密码是否符合规范，符合规范的密码要求：
 1. 长度大于8位
 2. 密码中必须同时包含数字和字母
 */
+(BOOL)judgePassWordLegal:(NSString *)pass{
    BOOL result = false;
    // 判断长度大于8位后再接着判断是否同时包含数字和字符
    NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    result = [pred evaluateWithObject:pass];
    return result;
}

+ (BOOL) isValidatePassword:(NSString *)password{
    NSString *passwordRegex = @"^[\\w.]{6,20}$";
    NSPredicate *passwordPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passwordRegex];
    return [passwordPre evaluateWithObject:password];
}

+ (NSString *) treeViews: (UIView *) aView{
    NSMutableString *outstring = [[NSMutableString alloc] init];
    [self dumpView: aView atIndent:0 into:outstring];
    return outstring ;
}

+ (void)dumpView:(UIView *)aView atIndent:(int)indent into:(NSMutableString *)outstring
{
    for (int i = 0; i < indent; i++) [outstring appendString:@"--"];
    [outstring appendFormat:@"[%2d] %@ %@\n", indent, [[aView class] description],[aView description]];
    for (UIView *view in [aView subviews])
        [self dumpView:view atIndent:indent + 1 into:outstring];
}


+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (NSString *) wifiEncrypt:(NSString*)str{
    
    
    NSString * encryptStr = @"";
    
    encryptStr = [self stringByReversed:str];
    
    
    encryptStr = [self stringBySwap:encryptStr position1:1 position2:3];
    encryptStr = [self stringBySwap:encryptStr position1:4 position2:6];
    
    encryptStr = [self stringByChange:encryptStr];
    
    
    
    return encryptStr;
}

+ (NSString *) wifiDecrypt:(NSString*)str{
    
    
    NSString * decryptStr = @"";
    
    
    
    decryptStr = [self stringByChange:str];
    
    decryptStr = [self stringBySwap:decryptStr position1:1 position2:3];
    decryptStr = [self stringBySwap:decryptStr position1:4 position2:6];
    
    decryptStr = [self stringByReversed:decryptStr];
    
    return decryptStr;
}

+(NSString *)stringByReversed:(NSString *) str{
    NSUInteger i = 0;
    NSUInteger j = str.length - 1;
    unichar characters[str.length];
    while (i < j) {
        characters[j] = [str characterAtIndex:i];
        characters[i] = [str characterAtIndex:j];
        i ++;
        j --;
    }
    if(i == j)
        characters[i] = [str characterAtIndex:i];
    return [NSString stringWithCharacters:characters length:str.length];
}

+(NSString *)stringBySwap:(NSString *) str position1:(NSInteger)position1 position2:(NSInteger)position2{
    
    NSString * position1Char = [str substringWithRange:NSMakeRange(position1-1, 1)];
    NSString * position2Char = [str substringWithRange:NSMakeRange(position2-1, 1)];
    
    NSString* swapStr = [str stringByReplacingCharactersInRange:NSMakeRange(position1-1, 1) withString:position2Char];
    swapStr = [swapStr stringByReplacingCharactersInRange:NSMakeRange(position2-1, 1) withString:position1Char];
    
    return swapStr;
}

+(NSString *)stringByChange:(NSString *) str {
    NSDictionary * dic = @{@"0":@"5",
                           @"1":@"8",
                           @"2":@"4",
                           @"3":@"7",
                           @"4":@"2",
                           @"5":@"0",
                           @"6":@"9",
                           @"7":@"3",
                           @"8":@"1",
                           @"9":@"6",
                           
                           // 大写字母
                           @"A":@"j",
                           @"B":@"m",
                           @"C":@"h",
                           @"D":@"i",
                           @"E":@"l",
                           @"F":@"k",
                           @"G":@"n",
                           
                           @"H":@"c",
                           @"I":@"b",
                           @"J":@"e",
                           @"K":@"g",
                           @"L":@"f",
                           @"M":@"a",
                           @"N":@"d",
                           
                           @"O":@"v",
                           @"P":@"u",
                           @"Q":@"y",
                           @"R":@"w",
                           @"S":@"x",
                           @"T":@"z",
                           
                           @"U":@"o",
                           @"V":@"q",
                           @"W":@"s",
                           @"X":@"r",
                           @"Y":@"p",
                           @"Z":@"t",
                           
                           // 小写字母
                           @"a":@"M",
                           @"b":@"I",
                           @"c":@"H",
                           @"d":@"N",
                           @"e":@"J",
                           @"f":@"L",
                           @"g":@"K",
                           
                           @"h":@"C",
                           @"i":@"D",
                           @"j":@"A",
                           @"k":@"F",
                           @"l":@"E",
                           @"m":@"B",
                           @"n":@"G",
                           
                           @"o":@"U",
                           @"p":@"Y",
                           @"q":@"V",
                           @"r":@"X",
                           @"s":@"W",
                           @"t":@"Z",
                           
                           @"u":@"P",
                           @"v":@"O",
                           @"w":@"R",
                           @"x":@"S",
                           @"y":@"Q",
                           @"z":@"T"};
    NSString * changeStr = @"";
    for (int i = 0; i<str.length; ++i) {
        NSString * ch = [str substringWithRange:NSMakeRange(i, 1)];
        NSString * dicCh = [dic objectForKey:ch];
        if (dicCh!= nil) {
            changeStr = [changeStr stringByAppendingString:dicCh];
        }
        else{
            changeStr = [changeStr stringByAppendingString:ch];
        }
    }
    
    return changeStr;
}


+ (NSString *) uuid {
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    CFRelease(puuid);
    CFRelease(uuidString);
    return result;
}

+ (NSString *) idfa{
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

+ (BOOL) isValidateTime:(NSString *)string{
    NSString *codeRegex = @"\\d{2}:\\d{2}";
    NSPredicate *codePre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",codeRegex];
    return [codePre evaluateWithObject:string];
}

+ (NSString *) decimalwithFormat:(NSString *)format  floatV:(float)floatV
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    
    [numberFormatter setPositiveFormat:format];
    
    return  [numberFormatter stringFromNumber:[NSNumber numberWithFloat:floatV]];
}
+ (CGFloat) heightForString:(NSString *)str withFont:(UIFont *)font withWidth:(CGFloat)width{
    CGFloat height = 0.0;
    
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    CGSize size = [str boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin| NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSParagraphStyleAttributeName: paragraph} context:nil].size;
    
    height += ceil(size.height);
    
    return height;
}
//获取正确方向图片
+ (UIImage *)imageFixOrientation:(UIImage *)aImage {
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}
+(NSString*)timeWithSeconds:(NSInteger)seconds
{
    int minutes = floor(seconds/60);
    int sec = trunc(seconds - minutes * 60);
    int hours1 = floor(seconds / (60 * 60));
    return [NSString stringWithFormat:@"%.2d:%.2d:%.2d",hours1,minutes,sec];
}
+ (NSMutableAttributedString *)tranformAttributedStringFromString:(NSString *)string WithRange:(NSRange)range AndAttribute:(NSString *)attributeName Value:(id)value{
    //    NSString * string =[NSString stringWithFormat:@"商品合计 共%lu件",(unsigned long)_carts.count];
    NSMutableAttributedString * attrString = [[NSMutableAttributedString alloc]initWithString:string];
    //    NSRange range =[string rangeOfString:[@(_carts.count) stringValue]];
    [attrString addAttribute:attributeName value:value range:range];
    //    [attrString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:14] range:range];
    return attrString;
    
}

+(NSInteger)orderAtLetter:(NSString*)letter
{
    NSArray*array=@[@"a",@"b",@"c",@"d" ,@"e",@"f",@"g",@"h", @"i",@"j",@"k",@"l",@"m",@"n",@"o",@"p",@"q",@"r", @"s" ,@"t",@"u",@"v",@"w",@"x",@"y",@"z",@"#"];
    __block  NSInteger Index;
    
    if ([letter isEqualToString:@"#"]) {
        
        Index=0;
    }
    
    else
    {
        [ array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([obj isEqualToString:[letter lowercaseString]]) {
                
                Index=idx+1;
                *stop=YES;
            }
            
            
            
        }];
        
    }
    
    
    
    
    return Index;
    
}
+(NSData*)listImageWithOldImage:(UIImage *)image
{
    UIImage *newImage = [self ListScaleFromImage: image];
    NSData  *imageData=UIImageJPEGRepresentation(newImage, 1.f);
    CGFloat size = 500.f;// kb
    CGFloat scale = size/(imageData.length/1024);
    NSData *newData=UIImageJPEGRepresentation(newImage, scale);
    return newData;
}
+(UIImage *)ListScaleFromImage:(UIImage *)image
{
    if (!image)
    {
        return nil;
    }
    NSData *data =UIImagePNGRepresentation(image);
    CGFloat dataSize = data.length/1024;
    CGFloat width  = image.size.width;
    CGFloat height = image.size.height;
    CGSize size;
    
    if (dataSize<=2000)
    {
        return image;
    }
    else//大于2M
    {
        size = CGSizeMake(width/2.f, height/2.f);
    }
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0,0, size.width, size.height)];
    UIImage *newImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    if (!newImage)
    {
        return image;
    }
    return newImage;
}
+(NSData *)imageProcessWithOldImage:(UIImage *)image{
    
    UIImage *newImage = [self scaleFromImage: image];
    NSData  *imageData=UIImageJPEGRepresentation(newImage, 1.f);
    CGFloat size = 50.f;// kb
    CGFloat scale = size/(imageData.length/1024);
    NSData *newData=UIImageJPEGRepresentation(newImage, scale);
    return newData;
}
+(UIImage *)scaleFromImage:(UIImage *)image
{
    if (!image)
    {
        return nil;
    }
    NSData *data =UIImagePNGRepresentation(image);
    CGFloat dataSize = data.length/1024;
    CGFloat width  = image.size.width;
    CGFloat height = image.size.height;
    CGSize size;
    
    if (dataSize<=50)//小于50k
    {
        return image;
    }
    else if (dataSize<=100)//小于100k
    {
        size = CGSizeMake(width/1.f, height/1.f);
    }
    else if (dataSize<=200)//小于200k
    {
        size = CGSizeMake(width/2.f, height/2.f);
    }
    else if (dataSize<=500)//小于500k
    {
        size = CGSizeMake(width/2.f, height/2.f);
    }
    else if (dataSize<=1000)//小于1M
    {
        size = CGSizeMake(width/2.f, height/2.f);
    }
    else if (dataSize<=2000)//小于2M
    {
        size = CGSizeMake(width/2.f, height/2.f);
    }
    else//大于2M
    {
        size = CGSizeMake(width/2.f, height/2.f);
    }
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0,0, size.width, size.height)];
    UIImage *newImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    if (!newImage)
    {
        return image;
    }
    return newImage;
}
+(UIImage*)drawImageWithImg:(UIImage*)image WithSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0,0, size.width, size.height)];
    UIImage *newImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    if (!newImage)
    {
        return image;
    }
    return newImage;
}
+(NSString*)saveAsTwo:(NSString*)str
{
    NSString*str1=[NSString stringWithFormat:@"%.2f",[str floatValue]/100.00000];
    NSString*str2=[str1 substringWithRange:NSMakeRange(str1.length-1, 1)];
    NSString*str3= [str1 substringWithRange:NSMakeRange(str1.length-2, 1)];
    NSString*str4;
    if ([str2 isEqualToString:@"0"]&&[str3 isEqualToString:@"0"]) {
        str4=[NSString stringWithFormat:@"%.0f",[str1 floatValue]];
    }
    if ([str2 isEqualToString:@"0"]&&![str3 isEqualToString:@"0"]) {
        str4=[NSString stringWithFormat:@"%.1f",[str1 floatValue]];
    }
    if (![str2 isEqualToString:@"0"]) {
        str4=[NSString stringWithFormat:@"%.2f",[str1 floatValue]];
    }
    if (![str2 isEqualToString:@"0"]) {
        str4=[NSString stringWithFormat:@"%.2f",[str1 floatValue]];
    }
    return str4;
    
}
@end
