//
//  ChatListModel.h
//  QuMa
//
//  Created by yjj on 2017/5/10.
//  Copyright © 2017年 HuaLaHuaLa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CallKit/CallKit.h>
@interface ChatListModel : NSObject

@property(nonatomic,assign)BOOL isMeSend;
//自己发送消息的数据,存在本地的直接根据是否存在来判断消息类型
@property(nonatomic,strong)NSString*textSend;
@property(nonatomic,strong)NSData*wavData;
@property(nonatomic,copy)NSString*imgURL;
@property(nonatomic,strong)NSData*imgData;
@property(nonatomic,strong)NSData*bigImgData;
//原图url
@property(nonatomic,copy)NSString*imgURl;
//自己发送的消息服务器拉取历史记录来判断消息类型
@property(nonatomic,assign)BOOL istextSend;
@property(nonatomic,assign)BOOL iswavData;
@property(nonatomic,assign)BOOL isImgData;
@property(nonatomic,assign)BOOL isfaceTime;
@property(nonatomic,assign)BOOL isVoiceTalk;
@property(nonatomic,copy)NSString* hangUpStatus;
//记录现在发送的date
@property(nonatomic,strong)NSDate* date;
//文本图片自适应后的高度
//高/宽
@property(nonatomic,assign)CGFloat scale;
@property(nonatomic,assign)CGFloat width;
//录音时间
@property(nonatomic,assign)CGFloat interval;
//录音是自己本地发的，而不是自己拉取历史记录后获得到的自己发的
@property(nonatomic,assign)BOOL isSendLocalNow;
//录音本地发的是否发送完成
@property(nonatomic,assign)BOOL isSendSucceSS;
@end
