//
//  AlertHelper.h
//  QuMa
//
//  Created by yjj on 2017/5/12.
//  Copyright © 2017年 HuaLaHuaLa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef void(^alertBlock)(void);
@interface AlertHelper : NSObject
@property(nonatomic,copy)alertBlock alertBlock;
@property(nonatomic,copy)alertBlock alertBlock1;
@property(nonatomic,copy)alertBlock alertBlock3;
@property(nonatomic,copy)alertBlock CancelBlock;
@property(nonatomic,strong)UITextField*textField;
-(void)showWithTitle:(NSString*)title message:(NSString*)message Title1:(NSString*)title1
                            Title2:(NSString*)title2 style:(style)mystyle superController:(UIViewController *)controller Block:(alertBlock)block Block1:(alertBlock)block1;
-(void)showWithTitle:(NSString*)title message:(NSString*)message Title1:(NSString*)title1
              Title2:(NSString*)title2 Title3:(NSString*)title3 style:(style)mystyle superController:(UIViewController *)controller Block:(alertBlock)block Block1:(alertBlock)block1 Block2:(alertBlock)block2;
-(void)showWithTitle:(NSString*)title message:(NSString*)message Title1:(NSString*)title1
               style:(style)mystyle superController:(UIViewController *)controller Block:(alertBlock)block;
-(void)showWithTitleWithTextField:(NSString*)title message:(NSString*)message placeHolder:(NSString*)holder
                            style:(style)mystyle superController:(UIViewController *)controller Block:(nonReturnHasArguments)block;
@end
