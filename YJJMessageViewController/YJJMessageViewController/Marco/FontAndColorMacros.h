//
//  FontAndColorMacros.h
//  MiAiApp
//
//  Created by 徐阳 on 2017/5/18.
//  Copyright © 2017年 徐阳. All rights reserved.
//

//字体大小和颜色配置

#ifndef FontAndColorMacros_h
#define FontAndColorMacros_h
//状态栏高度
#define  statusBarHeight  [[UIApplication sharedApplication]statusBarFrame].size.height
#define StatusBarColor [UIColor colorWithRed:115/255.0 green:148/255.0 blue:240/255.0 alpha:1/1.0]

#define LRRGBAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(r)/255.0 blue:(r)/255.0 alpha:a]
//导航条颜色
#define kbartintColor [UIColor whiteColor]
//分割线颜色
#define separateColor [UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1/1.0]
//导航条标题颜色
#define NavBarTilteColor [UIColor whiteColor]
//导航左右标题颜色
#define NavLeftOrRightColor [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1/1.0]
#define CustomBlackColor [UIColor colorWithRed:3/255.0 green:3/255.0 blue:3/255.0 alpha:1/1.0]
#define CustomGrayColor  [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1/1.0]
#define CustomPurpleColor [UIColor colorWithRed:117/255.0 green:107/255.0 blue:255/255.0 alpha:1/1.0]

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 90000
#define contentLbFont [UIFont fontWithName:@"PingFangSC-Regular" size:15]
//导航条标题字体
#define NavBarTitleFont [UIFont fontWithName:@"PingFangSC-Medium" size:17]
//导航左右标题字体
#define NavLeftOrRightFont [UIFont fontWithName:@"PingFangSC-Regular" size:15]
#define pingFangSCR(X) [UIFont fontWithName:@"PingFangSC-Regular" size:X]
#define pingFangSCM(X) [UIFont fontWithName:@"PingFangSC-Medium" size:X]
#define pingFangSCL(X) [UIFont fontWithName:@"PingFangSC-Light" size:X]
#else
#define contentLbFont [UIFont systemFontOfSize:15]
//导航条标题字体
#define NavBarTitleFont [UIFont systemFontOfSize:17]
//导航左右标题字体
#define NavLeftOrRightFont [UIFont systemFontOfSize:15]
//导航左右标题颜色
#define pingFangSCR(X) [UIFont systemFontOfSize:X]
#define pingFangSCM(X) [UIFont systemFontOfSize:X]
#define pingFangSCL(X) [UIFont systemFontOfSize:X]
#endif
#endif /* FontAndColorMacros_h */
