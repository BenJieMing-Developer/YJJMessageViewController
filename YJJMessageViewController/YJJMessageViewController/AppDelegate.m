//
//  AppDelegate.m
//  YJJMessageViewController
//
//  Created by Mark on 2019/9/4.
//  Copyright © 2019 Mark. All rights reserved.
//

#import "ChatRoomViewController.h"
#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window=[[UIWindow alloc]init];
    self.window.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    ChatRoomViewController*VC=[[ChatRoomViewController alloc]init];
   VC.chatRoomTitle=@"聊天室";
    VC.mineHeadPhotoURL=[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1567590030347&di=f99eb8572bbe8b6c860b215a85a3dec8&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F01a27656f79f3d6ac7257948dc6bc7.jpg"];
    UINavigationController*nav=[[UINavigationController alloc]
                                initWithRootViewController:VC];
    self.window.rootViewController=nav;
    [self performSelector:@selector(recieveMessage) withObject:nil afterDelay:3];
    [self.window makeKeyAndVisible];
    
    
    return YES;
}


-(void)recieveMessage
{
    if ([[self.window rootViewController]respondsToSelector:@selector(topViewController)]) {
        UINavigationController*nav=[self.window rootViewController] ;
        ChatRoomViewController*vc=[nav topViewController];
        ChatListModel*model=[[ChatListModel alloc]init];
              model.isMeSend=NO;
              model.istextSend=YES;
              model.textSend=@"你好啊，小兄弟";
              model.date=[NSDate date];
        [vc recieveMessage:model];
    }
}









- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}




@end
