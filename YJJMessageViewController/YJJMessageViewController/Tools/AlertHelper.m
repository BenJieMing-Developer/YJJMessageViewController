//
//  AlertHelper.m
//  QuMa
//
//  Created by yjj on 2017/5/12.
//  Copyright © 2017年 HuaLaHuaLa. All rights reserved.
//

#import "AlertHelper.h"

@interface AlertHelper()
<UIAlertViewDelegate,UIActionSheetDelegate>
@end

@implementation AlertHelper
-(void)showWithTitle:(NSString*)title message:(NSString*)message Title1:(NSString*)title1
                            Title2:(NSString*)title2 style:(style)mystyle superController:(UIViewController *)controller Block:(alertBlock)block Block1:(alertBlock)block1
{
    if ([[UIDevice currentDevice].systemVersion floatValue]>=8.0) {
        
        UIAlertController*alert;
        UIAlertAction*Action1=[UIAlertAction actionWithTitle:title1 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            block();
            
        }];
        UIAlertAction*Action2=[UIAlertAction actionWithTitle:title2 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            block1();
        }];
          NSString*cancelString=@"取消";
         UIAlertAction*Action3=[UIAlertAction actionWithTitle:cancelString style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
          
        }];

        if (mystyle==styleSheet) {
          alert=[UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
            [alert addAction:Action1];
            [alert addAction:Action2];
            [alert addAction:Action3];
            UIPopoverPresentationController*con=alert.popoverPresentationController;
            if (con) {
                con.sourceView=controller.view;
                con.sourceRect=CGRectMake(controller.view.bounds.size.width/2.0-con.containerView.bounds.size.width/2.0, controller.view.bounds.size.height,con.containerView.bounds.size.width , con.containerView.bounds.size.height);
                con.permittedArrowDirections=UIPopoverArrowDirectionDown;

            }
           
            
            }
        
       else
           {
                NSString*conFirmString=@"确定";
               if (title1&&[title1 stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length>0) {
                   cancelString=title1;
               }
               if (title1&&[title1 stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length>0) {
                   conFirmString=title2;
               }
               Action3=[UIAlertAction actionWithTitle:cancelString style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                   block();
               }];
              UIAlertAction*Action4=[UIAlertAction actionWithTitle:conFirmString style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                   block1();
               }];
        alert=[UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
               [alert addAction:Action3];
               [alert addAction:Action4];
           
          }
        [controller presentViewController:alert animated:YES completion:nil];
        
    }
    
    else
    {
        
        if (mystyle==styleSheet) {
            
            UIActionSheet*sheet=[[UIActionSheet alloc]initWithTitle:title delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:title1,title2, nil];
            [sheet showInView:controller.view];
            
            
        }
        else
        {
            
        }
        
    }
    
 
   
   

}
-(void)showWithTitle:(NSString*)title message:(NSString*)message Title1:(NSString*)title1
              Title2:(NSString*)title2 Title3:(NSString*)title3 style:(style)mystyle superController:(UIViewController *)controller Block:(alertBlock)block Block1:(alertBlock)block1 Block2:(alertBlock)block2
{
    if ([[UIDevice currentDevice].systemVersion floatValue]>=8.0) {
        
        UIAlertController*alert;
        UIAlertAction*Action1=[UIAlertAction actionWithTitle:title1 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            block();
            
        }];
        UIAlertAction*Action2=[UIAlertAction actionWithTitle:title2 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            block1();
        }];
        UIAlertAction*Action3=[UIAlertAction actionWithTitle:title3 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            block2();
        }];

        UIAlertAction*Action4=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        
        if (mystyle==styleSheet) {
            alert=[UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
            UIPopoverPresentationController*con=alert.popoverPresentationController;
            if (con) {
                con.sourceView=controller.view;
                con.sourceRect=CGRectMake(controller.view.bounds.size.width/2.0-con.containerView.bounds.size.width/2.0, controller.view.bounds.size.height,con.containerView.bounds.size.width , con.containerView.bounds.size.height);
                con.permittedArrowDirections=UIPopoverArrowDirectionDown;
                
            }
            
            
        }
        
        else
        {
            alert=[UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        }
        [alert addAction:Action1];
        [alert addAction:Action2];
        [alert addAction:Action3];
        [alert addAction:Action4];
        [controller presentViewController:alert animated:YES completion:nil];
        
    }
    
    else
    {
        
        if (mystyle==styleSheet) {
            
            UIActionSheet*sheet=[[UIActionSheet alloc]initWithTitle:title delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:title1,title2,title3,nil];
            [sheet showInView:controller.view];
            
            
        }
        else
        {
            
        }
        
    }
    
}
//UIAlert一个确定选择框，UACtionSheet一个取消，一个其他选择框。
-(void)showWithTitle:(NSString*)title message:(NSString*)message Title1:(NSString*)title1
               style:(style)mystyle superController:(UIViewController *)controller Block:(alertBlock)block
{
    WEAKSELF
    if ([[UIDevice currentDevice].systemVersion floatValue]>=8.0) {
        
        UIAlertController*alert;
        UIAlertAction*Action1=[UIAlertAction actionWithTitle:title1 style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            
            block();
            
        }];
        UIAlertAction*Action2=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
          
            if (weakSelf.CancelBlock) {
                weakSelf.CancelBlock();
            }
        }];
        UIAlertAction*Action3=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            block();
            
        }];
        if (mystyle==styleSheet) {
            alert=[UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
            [alert addAction:Action1];
            [alert addAction:Action2];
            UIPopoverPresentationController*con=alert.popoverPresentationController;
            if (con) {
                con.sourceView=controller.view;
                con.sourceRect=CGRectMake(controller.view.bounds.size.width/2.0-con.containerView.bounds.size.width/2.0, controller.view.bounds.size.height,con.containerView.bounds.size.width , con.containerView.bounds.size.height);
                con.permittedArrowDirections=UIPopoverArrowDirectionDown;
                
            }

            
            
        }
        
        else
        {
            alert=[UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:Action3];
        }
      
        [controller presentViewController:alert animated:YES completion:nil];
        
    }
    
    else
    {
        
        if (mystyle==styleSheet) {
            
            UIActionSheet*sheet=[[UIActionSheet alloc]initWithTitle:title delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:title1, nil];
            sheet.tag=0;
            [sheet showInView:controller.view];
            
            
        }
        else
        {
            UIAlertView*alert=[[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:@"取消"otherButtonTitles:nil];
            alert.tag=0;
            [alert show];
        }
        
    }
    
 
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==0) {
        
    }
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
}
-(void)showWithTitleWithTextField:(NSString*)title message:(NSString*)message placeHolder:(NSString*)holder
                            style:(style)mystyle superController:(UIViewController *)controller Block:(nonReturnHasArguments)block
{
    WEAKSELF
    if (mystyle==styleAlert) {
      
        
       UIAlertController*alert=[UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder=holder;
            
        }];
        UIAlertAction*Action=[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
           
            
        }];
        UIAlertAction*Action1=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            weakSelf.textField=alert.textFields.firstObject;
            block(weakSelf.textField.text);
        }];
        
    
        [alert addAction:Action];
        [alert addAction:Action1];
        [controller presentViewController:alert animated:YES completion:nil];


    }
    
    
    
}

@end

