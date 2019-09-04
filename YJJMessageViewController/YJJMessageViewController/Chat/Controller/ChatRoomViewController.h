//
//  ChatRoomViewController.h
//  QuMa
//
//  Created by yjj on 2017/5/8.
//  Copyright © 2017年 HuaLaHuaLa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChatListModel.h"



@interface ChatRoomViewController : UIViewController
@property(nonatomic,strong)NSURL*OtherHeadPhotoURL;
@property(nonatomic,strong)NSURL*mineHeadPhotoURL;
@property(nonatomic,copy)NSString*chatRoomTitle;

-(void)recieveMessage:(ChatListModel*)Model;

@end
