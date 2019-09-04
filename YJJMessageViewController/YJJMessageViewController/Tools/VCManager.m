//
//  VCManager.m
//  BasicProjectFramework
//
//  Created by yjj on 2018/4/11.
//  Copyright © 2018年 Yunjie. All rights reserved.
//

#import "VCManager.h"
@implementation VCManager
#pragma mark ----获取父视图
+(UIViewController *)getParentVCWithUIView:(id)current{
    id target = current;
    while (target) {
        target = ((UIResponder *)target).nextResponder;
        if ([target isKindOfClass:[UIViewController class]]) {
            break;
        }
    }
    return target;
}

#pragma mark ----跳转到目标显示器
+(void)pushToNextViewController:(UIViewController *)targetVC withSelf:(id)selfs{
    
    if ([selfs isKindOfClass:[UIView class]]) {
        UIViewController *vc = [VCManager getParentVCWithUIView:(UIView *)selfs];
        vc.hidesBottomBarWhenPushed = YES;
        [vc.navigationController pushViewController:targetVC animated:YES];
    }
    if ([selfs isKindOfClass:[UIViewController class]]) {
        
        UIViewController *_selfs = (UIViewController *)selfs;
        _selfs.hidesBottomBarWhenPushed = YES;
        [_selfs.navigationController pushViewController:targetVC animated:YES];
        
    }
    
}
+(UIViewController *)currentPresentedViewController;
{
    UIWindow *keyWindow  = [UIApplication sharedApplication].keyWindow;
    UIViewController *vc = keyWindow.rootViewController;
    vc = vc.presentedViewController;
    
    if ([vc isKindOfClass:[UINavigationController class]])
    {
        vc = [(UINavigationController *)vc visibleViewController];
    }
    else if ([vc isKindOfClass:[UITabBarController class]])
    {
        vc = [(UITabBarController *)vc selectedViewController];
    }
    
    return vc;
}
+ (UINavigationController *)currentNavigationController
{
    return [self currentPresentedViewController].navigationController;
}

@end
