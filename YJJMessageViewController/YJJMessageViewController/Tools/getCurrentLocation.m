

//
//  getCurrentLocation.m
//  QuMa
//
//  Created by yjj on 2017/6/16.
//  Copyright © 2017年 HuaLaHuaLa. All rights reserved.
//

#import "getCurrentLocation.h"

@implementation getCurrentLocation

SingleM(locationShareMannager)

-(void)beginLocation
{
         self.locationMannager = [[CLLocationManager alloc] init];
         self.locationMannager.delegate =self;
         self.locationMannager.desiredAccuracy = kCLLocationAccuracyBest;
         self.locationMannager.distanceFilter = 10.0;
        if ([Utils systemVersion]>=8.0) {
            [self.locationMannager requestWhenInUseAuthorization];
            
        }
        //开始定位，不断调用其代理方法
        [self.locationMannager startUpdatingLocation];
}
/**
 *  当用户授权状态发生变化时调用
 */
-(void)locationManager:(nonnull CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
            // 用户还未决定
        case kCLAuthorizationStatusNotDetermined:
        {

        }
            // 问受限(苹果预留选项,暂时没用)
        case kCLAuthorizationStatusRestricted:
        {
            LRLog(@"访问受限");
            break;
        }
            // 定位关闭时和对此APP授权为never时调用
        case kCLAuthorizationStatusDenied:
        {
            // 定位是否可用（是否支持定位或者定位是否开启）
            if([CLLocationManager locationServicesEnabled])
            {
                LRLog(@"定位开启，但被拒");
                UIWindow*window=[UIApplication sharedApplication].delegate.window;
                AlertHelper*helper=[[AlertHelper alloc]init];
                [helper showWithTitle:@"" message:@"请在设备的\"设置-隐私-相机\"中允许访问相机" Title1:@"取消" Title2:@"确定" style:styleAlert superController:window.rootViewController Block:^{
                    
                    
                } Block1:^{
                NSURL *settingURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if([[UIApplication sharedApplication] canOpenURL:settingURL])
                {
                   [[UIApplication sharedApplication] openURL:settingURL];
                }
                    
                }];

            }
            else
            {
                
                LRLog(@"定位关闭，不可用");
                NSURL *settingURL = [NSURL URLWithString:@"App-Prefs:root=Privacy&path=LOCATION_SERVICES"];
                    if([[UIApplication sharedApplication] canOpenURL:settingURL])
                    {
                        if (@available(iOS 10.0, *)) {
                            [[UIApplication sharedApplication] openURL:settingURL options:@{} completionHandler:^(BOOL success) {
                                
                            }];
                        } else {
                            if([[UIApplication sharedApplication] canOpenURL:settingURL])
                            {
                                [[UIApplication sharedApplication] openURL:settingURL];
                            }
                            // Fallback on earlier versions
                        }
                    }
                
            }
        }
        break;
        
            // 获取前后台定位授权
        case kCLAuthorizationStatusAuthorizedAlways:
            //        case kCLAuthorizationStatusAuthorized: // 失效，不建议使用
        {
            LRLog(@"获取前后台定位授权");
            break;
        }
            // 获得前台定位授权
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        {
            LRLog(@"获得前台定位授权");
            break;
        }
        default:
            break;
    }
    
}
//会调用多次这个方法
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    // 1.获取用户位置的对象
    if (self.getLocationBlock) {
        self.getLocationBlock([locations lastObject]);
        self.getLocationBlock = nil;
    }
      [manager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if (error.code == kCLErrorDenied) {
        // 提示用户出错原因，可按住Option键点击 KCLErrorDenied的查看更多出错信息，可打印error.code值查找原因所在
    }
}


@end
