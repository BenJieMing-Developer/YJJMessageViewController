//
//  RecordPopView.h
//  QuMa
//
//  Created by yjj on 2017/5/8.
//  Copyright © 2017年 HuaLaHuaLa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecordPopView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *recordImageView;
@property (weak, nonatomic) IBOutlet UILabel *tishiLabel;

-(void)showInCenter:(UIView*)View;

-(void)dissmiss;
@end
