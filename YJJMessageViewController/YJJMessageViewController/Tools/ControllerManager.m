//
//  ControllerManager.m
//  controllermanager
//
//  Created by zhanglei on 2/19/16.
//  Copyright © 2016 loftor. All rights reserved.
//

#import "ControllerManager.h"

#import <objc/runtime.h>

#import "AppDelegate.h"

@implementation ControllerManager

+ (UIViewController *)loadController:(NSString *)controllerName andStoryboard:(NSString *)storyboardName andParams:(NSDictionary *)params andDelegate:(UIViewController *)delegate{
    UIViewController * tmp = nil;
    if (storyboardName) {
        tmp = [[UIStoryboard storyboardWithName:storyboardName bundle:nil]instantiateViewControllerWithIdentifier:controllerName];
        
    }
    else{
        tmp = [[NSClassFromString(controllerName) alloc]initWithNibName:controllerName bundle:nil];
        
    }
    
    if (delegate) {
        [tmp setValue:delegate forKey:@"delegate"];
    }
    
    
    for (NSString * key in [params allKeys]) {
        [tmp setValue:params[key] forKey:key];
    }
    
    return tmp;
}
+ (UIViewController *)loadController:(NSString *)controllerName andXib:(NSString *)xibName andParams:(NSDictionary *)params andDelegate:(UIViewController *)delegate{
    
    UIViewController * tmp = nil;
    if (xibName) {

        tmp = [[NSClassFromString(controllerName) alloc]initWithNibName:xibName bundle:nil];
    }
    else{
        tmp = [[NSClassFromString(controllerName) alloc]init];
        
    }
    
    if (delegate) {
        [tmp setValue:delegate forKey:@"delegate"];
    }
    
    
    for (NSString * key in [params allKeys]) {
        [tmp setValue:params[key] forKey:key];
    }
    
    return tmp;
}



@end
