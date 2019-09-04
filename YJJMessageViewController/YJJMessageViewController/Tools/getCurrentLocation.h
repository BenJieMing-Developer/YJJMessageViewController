//
//  getCurrentLocation.h
//  BasicProjectFramework
//
//  Created by yjj on 2017/6/16.
//  Copyright © 2017年 HuaLaHuaLa. All rights reserved.
#import <CoreLocation/CoreLocation.h>
#import "AlertHelper.h"
#import "Single.h"
@interface getCurrentLocation : NSObject<CLLocationManagerDelegate>
@property(nonatomic,strong)CLLocationManager*locationMannager;
@property(nonatomic,strong)NSArray*locationArray;
@property(nonatomic,strong)nonReturnHasArguments getLocationBlock;
SingleH(locationShareMannager)
-(void)beginLocation;
@end
