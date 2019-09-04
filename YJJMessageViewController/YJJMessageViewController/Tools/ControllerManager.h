//
//  ControllerManager.h
//  controllermanager
//
//  Created by zhanglei on 2/19/16.
//  Copyright © 2016 loftor. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface ControllerManager : NSObject

+ (UIViewController *)loadController:(NSString *)controllerName andStoryboard:(NSString *)storyboardName andParams:(NSDictionary *)params andDelegate:(UIViewController *)delegate;

+ (UIViewController *)loadController:(NSString *)controllerName andXib:(NSString *)xibName andParams:(NSDictionary *)params andDelegate:(UIViewController *)delegate;

@end
