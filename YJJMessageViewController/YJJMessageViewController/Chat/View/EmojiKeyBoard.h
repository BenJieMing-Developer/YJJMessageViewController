//
//  EmojiKeyBoard.h
//  QuMa
//
//  Created by yjj on 2017/6/9.
//  Copyright © 2017年 HuaLaHuaLa. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EmoJiCollectionViewCell;
@protocol EmojiKeyBoardDellegate <NSObject>
-(void)emojiSelectAtItem:(UIButton*)sender;
-(void)emojiSend:(UIButton*)sender;
@end

@interface EmojiKeyBoard : UIView
@property(nonatomic,assign)BOOL firstResponser;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property(nonatomic,weak)id <EmojiKeyBoardDellegate> delegate;
@end
