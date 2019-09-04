//
//  VCManager.h
//  BasicProjectFramework
//
//  Created by yjj on 2018/4/11.
//  Copyright © 2018年 Yunjie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VCManager : NSObject
+(UIViewController *)getParentVCWithUIView:(id)current;
+(void)pushToNextViewController:(UIViewController *)targetVC withSelf:(id)selfs;
+(UIViewController *)currentPresentedViewController;
+ (UINavigationController *)currentNavigationController;
@end
