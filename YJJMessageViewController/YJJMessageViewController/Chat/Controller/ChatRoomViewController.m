////
////  ChatRoomViewController.m
////  QuMa
////
////  Created by yjj on 2017/5/8.
////  Copyright © 2017年 HuaLaHuaLa. All rights reserved.
#import "ChatRoomViewController.h"
#import "RecordPopView.h"
#import "HMEmoticonTextView.h"
#import "HMEmoticonInputView.h"
#import <AVFoundation/AVFoundation.h>
#import "ChatListModel.h"
#import "TZImagePickerController.h"
#import "SKFCamera.h"
#import "TOCropViewController.h"
#import "IDMPhotoBrowser.h"
#import "EmojiKeyBoard.h"
#import "HMEmoticonAttachment.h"
#import "EmojiButton.h"
#import "TextMessageCell.h"
#import "TextMessageCellOther.h"
#import "PictureCell.h"
#import "PictureCellOther.h"
#import "ReCordCell.h"
#import "RecordCellOther.h"
#import "VoiceOrVideoTalkCellCellOther.h"
#import "VoiceOrVideoTalkCell.h"
#import "ArraySortModel.h"
#import "DropWaterButton.h"
#import "TopImgBottomTextButton.h"
#import "ChoosePictureSourceView.h"
#import "ChoosePictureSourceView.h"

typedef NS_OPTIONS(NSUInteger,hideInputViewType) {
    hideToolView=1<<1,//收起工具栏
    hideEmoji=1<<2,//收起表情键盘
};

typedef NS_OPTIONS(NSUInteger,jumpInputViewType)
{
    jumpToolView=1<<1,//弹起工具栏
    jumpEmoji=1<<2,//弹起表情键盘
    
};

@interface BottomToolView:UIView
@property(nonatomic,strong)NSMutableArray*photoArray;
@property(nonatomic,strong)NSMutableArray*imgNameArray;
@property(nonatomic,assign)BOOL firstResponser;
@property(nonatomic,copy)nonReturnHasArguments ClickBlock;
@end
@implementation BottomToolView


-(instancetype)init
{
    if (self=[super init]) {
        WEAKSELF
        for (NSInteger i=0;i<self.photoArray.count;i++) {
            TopImgBottomTextButton*button=[TopImgBottomTextButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:self.photoArray[i] forState:UIControlStateNormal];
            [button setTitleColor:RGB(34, 34, 34, 1) forState:UIControlStateNormal];
            button.titleLabel.font=pingFangSCL(11);
            [button setImage:[UIImage imageNamed:self.imgNameArray[i]] forState:UIControlStateNormal];
            button.tag=i;
            [self addSubview:button];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(weakSelf.mas_left).offset(SCREEN_WIDTH/4*(i%4));
                    make.top.equalTo(weakSelf.mas_top).offset(95*(i/4));
                    make.width.equalTo(@(SCREEN_WIDTH/4));
                    make.height.equalTo(@95);
                
                }];
            [button addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
            
           
        }
    }
    return self;
}

-(void)Click:(UIButton*)sender
{
    if (self.ClickBlock) {
        self.ClickBlock(sender);
    }
}

-(NSMutableArray*)photoArray
{
    
    if (!_photoArray) {
        _photoArray=[@[@"照片",@"私照",@"语音聊天",@"视频聊天"] mutableCopy];
    }
    return _photoArray;
}
-(NSMutableArray*)imgNameArray
{
    
    if (!_imgNameArray) {
        _imgNameArray=[@[@"xiangce",@"glasses",@"yuyingliaotian",@"shipinliaotian"] mutableCopy];
    }
    return _imgNameArray;
}

-(void)Click
{
    
}





@end

@interface ChatRoomViewController ()
<UITextViewDelegate,UITableViewDelegate,UITableViewDataSource,TZImagePickerControllerDelegate,EmojiKeyBoardDellegate,UIScrollViewDelegate>
{
    NSString*filePath;
    NSFileManager*FileMannager;

}
@property(strong, nonatomic) UITableView *chatTableView;
@property (strong, nonatomic)  EmojiKeyBoard *emojiKeyBoard;
@property(nonatomic,strong)BottomToolView*toolView;
@property(nonatomic,strong)ChoosePictureSourceView*choosePictureView;
@property(nonatomic,strong)UIView*contentView;
@property(nonatomic,strong)UIView*bottomBarView;
@property(nonatomic,strong)UIView*bottomBarLineView;
@property(nonatomic,strong)UIView*bottomBarTopLineView;
@property(strong,nonatomic)UIButton*addButton;
@property(strong,nonatomic)UIButton*getEmojiButton;
@property (strong, nonatomic)  UIButton *longPressButton;
@property (strong, nonatomic)  HMEmoticonTextView *talkTextFied;
@property (strong, nonatomic)  UIButton *recordButton;
//上拉未读消息按钮
@property (strong, nonatomic) UIButton *pullUnreadButton;
//下滑未读消息
@property (strong, nonatomic)  DropWaterButton *unReadButton;

@property(nonatomic,strong)RecordPopView*popView;
@property(nonatomic,strong)AlertHelper*alertHelper;
////录音
@property(nonatomic,strong)AVAudioSession*session;
@property(nonatomic,strong)AVAudioRecorder*recorder;
@property(nonatomic,strong)AVAudioPlayer*player;
////播放录音路径url
@property(nonatomic,strong)NSURL*recordUrl;
@property(nonatomic,strong) AVURLAsset* audioAsset;
////文本消息记录(包含表情)
@property(nonatomic,copy)NSString*inputText;
////存储消息数组
@property(nonatomic,strong)NSMutableArray*MessageContentArray;
////未读消息数
@property(nonatomic,assign)NSInteger unReadCount;
////记录数据未改变前最后一个模型
@property(nonatomic,strong)ChatListModel*lastModel;
////大图片预览图数组
@property(nonatomic,strong)NSMutableArray*bigImageContentArary;
//小图片数组
@property(nonatomic,strong)NSArray*smallImageArray;
////tableView偏移量
@property(nonatomic,assign)CGFloat offset;
//表情样式
@property(nonatomic,strong)NSDictionary*EmojiDic;
// 字体样式
@property(nonatomic,strong)NSDictionary*StrDic;
////记录第一次进入的偏移量,只要有上拉的未读消息并且偏移量小于此偏移量未读隐藏.
@property(nonatomic,assign)CGFloat initialOffset;
@end
@implementation ChatRoomViewController

#pragma lazyLoad

-(NSDictionary*)EmojiDic
{
    if(!_EmojiDic)
    {
        NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
        paraStyle.lineSpacing =3;
        _EmojiDic=[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:18],NSFontAttributeName,[UIColor blackColor],NSForegroundColorAttributeName,paraStyle,NSParagraphStyleAttributeName, nil];
        
    }
    return _EmojiDic;
}
-(NSDictionary*)StrDic
{
    if(!_StrDic)
    {
        NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
        paraStyle.lineSpacing =3;
        _StrDic=[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"PingFangSC-Regular" size:13],NSFontAttributeName,[UIColor blackColor],NSForegroundColorAttributeName,paraStyle,NSParagraphStyleAttributeName, nil];
        
    }
    return _StrDic;
}
-(ChoosePictureSourceView*)choosePictureView
{
    if (!_choosePictureView) {
        _choosePictureView=[[ChoosePictureSourceView alloc]init];
        _choosePictureView.firstTitle=@"相册";
        _choosePictureView.secondTitle=@"拍照";
    }
    return _choosePictureView;
}
-(AlertHelper*)alertHelper
{
    if (!_alertHelper) {
        _alertHelper=[[AlertHelper alloc]init];
    }
    return _alertHelper;
}
-(RecordPopView*)popView
{
    if (!_popView) {
        _popView=[[RecordPopView alloc]init];
    }
    return _popView;
}

-(BottomToolView*)toolView
{
    if (!_toolView) {
        _toolView=[[BottomToolView alloc]init];
        _toolView.backgroundColor=RGB(241, 241, 244, 1);
    }
    return _toolView;
    
}

-(UIButton*)getEmojiButton
{
    if (!_getEmojiButton) {
        _getEmojiButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_getEmojiButton setImage:[UIImage imageNamed:@"emoji"] forState:UIControlStateNormal];
        [_getEmojiButton addTarget:self action:@selector(getEmoji:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _getEmojiButton;
}

-(UIButton*)addButton
{
    if (!_addButton) {
        _addButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_addButton setImage:[UIImage imageNamed:@"plus"] forState:UIControlStateNormal];
        [_addButton addTarget:self action:@selector(photoSend:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addButton;
}

-(UIButton*)longPressButton
{
    if (!_longPressButton) {
        _longPressButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _longPressButton.layer.borderWidth=1;
        _longPressButton.layer.borderColor=RGB(214, 214, 214, 1).CGColor;
       _longPressButton.layer.cornerRadius=17.5;
       _longPressButton.layer.masksToBounds=YES;
        _longPressButton.hidden=YES;
        [_longPressButton setTitleColor:CustomBlackColor forState:UIControlStateNormal];
        _longPressButton.titleLabel.font=pingFangSCL(15);
         [_longPressButton setTitle:@"按住说话" forState:UIControlStateNormal];
         [_longPressButton addTarget:self action:@selector(press:forEvent:) forControlEvents:UIControlEventAllTouchEvents];
    }
    return _longPressButton;
}

-(DropWaterButton*)unReadButton
{
    if (!_unReadButton) {
        _unReadButton=[DropWaterButton buttonWithType:UIButtonTypeCustom];
        _unReadButton.backgroundColor=RGB(109, 160, 243, 1);
        [_unReadButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _unReadButton.titleLabel.font=pingFangSCR(11);
        [_unReadButton setTitle:@"0" forState:UIControlStateNormal];
    }
    return _unReadButton;
}

-(UIButton*)recordButton
{
    if (!_recordButton) {
        _recordButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_recordButton setImage:[UIImage imageNamed:@"voice"] forState:UIControlStateNormal];
        [_recordButton setImage:[UIImage imageNamed:@"write"] forState:UIControlStateSelected];
        [_recordButton addTarget:self action:@selector(recordClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _recordButton;
}

-(UIView*)contentView
{
    if (!_contentView) {
        _contentView=[[UIView alloc]init];
        _contentView.layer.cornerRadius=17.5;
        _contentView.layer.masksToBounds=YES;
        _contentView.backgroundColor=[UIColor colorFromHexRGB:@"EEEEEE"];
    }
    return _contentView;
}
-(HMEmoticonTextView*)talkTextFied
{
    if (!_talkTextFied) {
        _talkTextFied=[[HMEmoticonTextView alloc]init];
        _talkTextFied.scrollEnabled=YES;
        _talkTextFied.showsVerticalScrollIndicator=NO;
        _talkTextFied.returnKeyType=UIReturnKeySend;
        _talkTextFied.font=pingFangSCR(15);
        _talkTextFied.backgroundColor=[UIColor colorFromHexRGB:@"EEEEEE"];
       _talkTextFied.maxInputLength = 0;
    }
    return _talkTextFied;
}

-(UIView*)bottomBarLineView
{
    if (!_bottomBarLineView) {
        _bottomBarLineView=[[UIView alloc]init];
        _bottomBarLineView.backgroundColor=RGB(214, 214, 214, 1);
    }
    return _bottomBarLineView;
}

-(UIView*)bottomBarTopLineView
{
    if (!_bottomBarTopLineView) {
        _bottomBarTopLineView=[[UIView alloc]init];
        _bottomBarTopLineView.backgroundColor=RGB(214, 214, 214, 1);
    }
    return _bottomBarTopLineView;
}
-(UIView*)bottomBarView
{
    if (!_bottomBarView) {
        _bottomBarView=[[UIView alloc]init];
        _bottomBarView.backgroundColor=[UIColor whiteColor];
    }
    return _bottomBarView;
}
-(EmojiKeyBoard*)emojiKeyBoard
{
    if (!_emojiKeyBoard) {
        _emojiKeyBoard=[[EmojiKeyBoard alloc]init];
    }
    return _emojiKeyBoard;
}
-(NSMutableArray*)MessageContentArray
{
    if (!_MessageContentArray) {
        _MessageContentArray=[NSMutableArray array];
    }
    return _MessageContentArray;
}

-(NSMutableArray*)bigImageContentArary
{
    if (!_bigImageContentArary) {
        _bigImageContentArary=[NSMutableArray array];
    }
    return _bigImageContentArary;
}

-(NSArray*)smallImageArray
{
    if (!_smallImageArray) {
        _smallImageArray=[NSArray array];
    }
    return _smallImageArray;
}
-(UITableView*)chatTableView
{
    if(!_chatTableView)
    {
        _chatTableView=[[UITableView alloc]init];
        _chatTableView.tableFooterView=[UIView new];
        _chatTableView.backgroundColor=RGB(245, 245, 245, 1);
        _chatTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _chatTableView.rowHeight=UITableViewAutomaticDimension;
        _chatTableView.estimatedRowHeight=44;
        _chatTableView.showsHorizontalScrollIndicator=NO;
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideInputView)];
        tapGestureRecognizer.cancelsTouchesInView = NO;//设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
        [_chatTableView addGestureRecognizer:tapGestureRecognizer];
        [_chatTableView registerClass:[TextMessageCell class] forCellReuseIdentifier:@"TextMessageCell"];
         [_chatTableView registerClass:[PictureCell class] forCellReuseIdentifier:@"PictureCell"];
         [_chatTableView registerClass:[ReCordCell class] forCellReuseIdentifier:@"ReCordCell"];
         [_chatTableView registerClass:[VoiceOrVideoTalkCell class] forCellReuseIdentifier:@"VoiceOrVideoTalkCell"];
         [_chatTableView registerClass:[TextMessageCellOther class] forCellReuseIdentifier:@"TextMessageCellOther"];
         [_chatTableView registerClass:[PictureCellOther class] forCellReuseIdentifier:@"PictureCellOther"];
         [_chatTableView registerClass:[RecordCellOther class] forCellReuseIdentifier:@"RecordCellOther"];
         [_chatTableView registerClass:[VoiceOrVideoTalkCellCellOther class] forCellReuseIdentifier:@"VoiceOrVideoTalkCellCellOther"];
        
    }
    return _chatTableView;
}

-(void)initView
{
    WEAKSELF
    self.navigationItem.title=self.chatRoomTitle;
    self.navigationController.navigationBar.translucent=NO;
    self.navigationController.navigationBar.barTintColor=[[UIColor grayColor]colorWithAlphaComponent:0.9];
self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.chatTableView];
    [self.view addSubview:self.bottomBarView];
    [self.chatTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.bottom.equalTo(self.bottomBarView.mas_top);
    }];
    [self.bottomBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.mas_bottomLayoutGuideTop);
    }];
    [self.view addSubview:self.unReadButton];
    [self.view addSubview:self.emojiKeyBoard];
    [self.view addSubview:self.toolView];
    [self.bottomBarView addSubview:self.getEmojiButton];
    [self.bottomBarView addSubview:self.bottomBarLineView];
    [self.bottomBarView addSubview:self.bottomBarTopLineView];
    [self.bottomBarView addSubview:self.addButton];
    [self.bottomBarView addSubview:self.contentView];
    [self.bottomBarView addSubview:self.talkTextFied];
    [self.bottomBarView addSubview:self.longPressButton];
    [self.bottomBarView addSubview:self.recordButton];
    [self.toolView mas_makeConstraints:^(MASConstraintMaker *make) {
          make.left.right.equalTo(weakSelf.view);
          make.top.equalTo(weakSelf.view.mas_bottom);
          make.height.equalTo(@190);
    }];
    [self.recordButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.bottomBarView.mas_bottom).offset(-7.5);
        make.left.equalTo(weakSelf.bottomBarView.mas_left).offset(10);
        make.width.height.equalTo(@35);
    }];
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.bottomBarView.mas_bottom).offset(-7.5);
        make.right.equalTo(weakSelf.bottomBarView.mas_right).offset(-10);
        make.width.equalTo(@35);
        make.height.equalTo(@35);
    }];
    [self.getEmojiButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.addButton.mas_left).offset(-9);
        make.bottom.equalTo(weakSelf.bottomBarView.mas_bottom).offset(-7.5);
        make.width.equalTo(@35);
        make.height.equalTo(@35);
    }];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.recordButton.mas_right).offset(9);
        make.right.equalTo(weakSelf.getEmojiButton.mas_left).offset(-9);
        make.bottom.equalTo(weakSelf.bottomBarView.mas_bottom).offset(-7.5);
        make.top.equalTo(weakSelf.bottomBarView.mas_top).offset(7.5);
        make.height.equalTo(@35);
    }];
    [self.talkTextFied mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView.mas_left).offset(18);
        make.right.equalTo(weakSelf.contentView.mas_right).offset(-18);
        make.top.bottom.equalTo(weakSelf.contentView);
    }];
    [self.longPressButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(weakSelf.contentView);
        make.height.equalTo(@(35));
    }];
    [self.emojiKeyBoard mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view.mas_bottom);
        make.height.equalTo(@223);
    }];
    self.unReadButton.hidden=YES;
    [self.bottomBarLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(weakSelf.bottomBarView);
        make.height.equalTo(@(0.7));
    }];
    [self.bottomBarTopLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(weakSelf.bottomBarView);
        make.height.equalTo(@(0.7));
    }];
    [self.unReadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.bottomBarView.mas_top).offset(-10);
        make.right.equalTo(weakSelf.view.mas_right).offset(-10);
        make.width.equalTo(@24);
        make.height.equalTo(@30);
    }];


   
}


-(void)hideInputView
{

    [self.talkTextFied isFirstResponder]? [self.talkTextFied resignFirstResponder]:  [self hideInputViewWithType:hideEmoji|hideToolView isScrollToBottom:YES];

}
-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
     //移除消息监听
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].enable=NO;
    [IQKeyboardManager sharedManager].enableAutoToolbar=NO;
}

#pragma ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    WEAKSELF
    [self initView];
    self.toolView.ClickBlock = ^(UIButton* sender) {
     if([sender.currentTitle isEqualToString:@"照片"])
     {
         [weakSelf hideInputViewWithType:hideToolView isScrollToBottom:YES];
         weakSelf.choosePictureView.choosePicture = ^{
             [weakSelf.choosePictureView dissmiss];
             TZImagePickerController*pickerController=[[TZImagePickerController alloc]initWithMaxImagesCount:1 delegate:weakSelf];
             pickerController.showSelectBtn=YES;
             pickerController.sortAscendingByModificationDate=NO;
             pickerController.allowTakePicture=NO;
             pickerController.allowPickingVideo=NO;
             pickerController.allowPickingGif=NO;
             [pickerController setDidFinishPickingPhotosHandle:^(NSArray *photos, NSArray *assets,BOOL isSelectOriginalPhoto) {
                 UIImage*image=photos[0];
                 UIImage*newImage=[UIImage imageWithData:[Utils imageProcessWithOldImage:image]];
                 ChatListModel*model=[[ChatListModel alloc]init];
                 model.isMeSend=YES;
                 model.isImgData=YES;
                 model.date=[NSDate date];
                 model.width=newImage.size.width;
                 model.scale=newImage.size.height/newImage.size.width;
                 model.imgData=[Utils imageProcessWithOldImage:image];
                 model.bigImgData=UIImagePNGRepresentation(image);
                 ArraySortModel*sortModel=[[ArraySortModel alloc]init];
                 sortModel.image=image;
                 sortModel.tag=weakSelf.MessageContentArray.count;
                 [weakSelf.bigImageContentArary addObject:sortModel];
                 [weakSelf.MessageContentArray addObject:model];
                 [weakSelf layoutInputContentView:0 layoutTableView:YES reloadData:YES isScrollToBottom:YES];
              
             }];
             [weakSelf presentViewController:pickerController animated:YES completion:nil];
             
         };
         weakSelf.choosePictureView.takePhoto = ^{
             [weakSelf.choosePictureView dissmiss];
             if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                 if(![Utils cameraPermission])
                 {
                     
                     AlertHelper*helper=[[AlertHelper alloc]init];
                     [helper showWithTitle:@"" message:@"请在设备的\"设置-隐私-相机\"中允许访问相机" Title1:@"取消" Title2:@"确定" style:styleAlert superController:weakSelf Block:^{
                         
                         
                     } Block1:^{
                         
                         [Utils goToCameraSeting];
                         
                     }];
                     
                 }
                 else if (![Utils voicePermission])
                 {
                     AlertHelper*helper=[[AlertHelper alloc]init];
                     [helper showWithTitle:@"" message:@"请在设备的\"设置-隐私-麦克风\"中允许访问麦克风" Title1:@"取消" Title2:@"确定" style:styleAlert superController:weakSelf Block:^{
                         
                         
                     } Block1:^{
                         
                         [Utils goToVoiceSetting];
                         
                     }];
                 }
                 else
                 {
                     
                     
                     SKFCamera *homec = [[SKFCamera alloc] init];
                     homec.fininshcapture = ^(UIImage *image) {
                         if (image) {
                             if(![Utils cameraPermission])
                             {
                                 AlertHelper*helper=[[AlertHelper alloc]init];
                                 [helper showWithTitle:@"" message:@"请在设备的\"设置-隐私-相机\"中允许访问相机" Title1:@"取消" Title2:@"确定" style:styleAlert superController:weakSelf Block:^{
                                     
                                     
                                 } Block1:^{
                                     
                                     [Utils goToCameraSeting];
                                     
                                 }];
                                 
                                 
                             }
                             else
                             {
                                 
                                 LRLog(@"照片存在");
                                 //此处获得图片发送出去
                                 UIImage*newImage=[UIImage imageWithData:[Utils imageProcessWithOldImage:image]];
                                 ChatListModel*model=[[ChatListModel alloc]init];
                                 model.isMeSend=YES;
                                 model.isImgData=YES;
                                 model.date=[NSDate date];
                                 model.width=newImage.size.width;
                                 model.scale=newImage.size.height/newImage.size.width;
                                 model.imgData=[Utils imageProcessWithOldImage:image];
                                 model.bigImgData=UIImagePNGRepresentation(image);
                                 ArraySortModel*sortModel=[[ArraySortModel alloc]init];
                                 sortModel.image=image;
                                 sortModel.tag=weakSelf.MessageContentArray.count;
                                 [weakSelf.bigImageContentArary addObject:sortModel];
                                 [weakSelf.MessageContentArray addObject:model];
                                 [weakSelf layoutInputContentView:0 layoutTableView:YES reloadData:YES isScrollToBottom:YES];
                              
                             }
                             
                         }
                     };
                     [weakSelf presentViewController:homec
                                            animated:NO
                                          completion:^{
                                          }];
                 }
                 
             }
             else {
                 LRLog(@"相机调用失败");
             }
             
             
         };
         [weakSelf.choosePictureView showInView:kWindow];
         
       
        
     }
    if([sender.currentTitle isEqualToString:@"私照"])
    {
       [weakSelf hideInputViewWithType:hideToolView isScrollToBottom:YES];
       

    }
    if(sender.tag==2)
    {
      
    }
    if (sender.tag==3) {
            
    }
    if ([sender.currentTitle isEqualToString:@"语音聊天"]) {
    
            [weakSelf talkToOther];
    }
    if ([sender.currentTitle isEqualToString:@"视频聊天"]) {
            [weakSelf faceToOther];
      
    }
    };

    // Do any additional setup after loading the view.
    self.chatTableView.dataSource=self;
    self.chatTableView.delegate=self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(enterBackGround) name:@"willEnterBackGround" object:nil];
      [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(enterForeGround) name:@"willEnterForeGround" object:nil];
    self.talkTextFied.delegate=self;
    self.emojiKeyBoard.delegate=self;
    FileMannager=[NSFileManager defaultManager];
  
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if(self.MessageContentArray.count>0)
    {
       [self.chatTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.MessageContentArray.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
    }
   
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.talkTextFied resignFirstResponder];
    [IQKeyboardManager sharedManager].enable=YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar=YES;
    //标记已读
}
-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"willEnterBackGround" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"inputChange" object:nil];
    
}




-(void)enterBackGround
{
     self.offset=self.chatTableView.contentSize.height-self.chatTableView.bounds.size.height+10;

}
-(void)enterForeGround
{
    self.offset=self.chatTableView.contentSize.height-self.chatTableView.bounds.size.height-60;
    
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self hideInputView];

}

-(void)talkToOther
{
   
  
   
}
-(void)faceToOther
{
 
    
}

- (void)press:(UIButton*)sender forEvent:(UIEvent *)event{
    
      if(![Utils voicePermission])
      {
          
          AlertHelper*helper=[[AlertHelper alloc]init];
          [helper showWithTitle:@"" message:@"请在设备的\"设置-隐私-相机\"中允许访问麦克风" Title1:@"取消" Title2:@"确定" style:styleAlert superController:self Block:^{
              
              
          } Block1:^{
              
              [Utils goToVoiceSetting];
              
          }];
      }
     else
     {
         UITouchPhase phase = event.allTouches.anyObject.phase;
         UITouch*touch=event.allTouches.anyObject;
         CGPoint point=[touch locationInView:sender];
         if (phase == UITouchPhaseBegan) {
             LRLog(@"press");
             [self.popView showInCenter:self.view];
             [self beginRecord];
         }
         if(phase == UITouchPhaseEnded){
             LRLog(@"release");
             [self stopRecord];
             //判断释放点位置，在按钮内就发送，在按钮外就取消发送。
             if(point.y<sender.frame.origin.y)
             {
                 if ([FileMannager fileExistsAtPath:filePath]) {
                     [FileMannager removeItemAtPath:filePath error:nil];
                 }
                 [self popViewRemove];
             }
             else
             {
                 self.audioAsset =[AVURLAsset URLAssetWithURL:self.recordUrl options:nil];
                 CMTime audioDuration = self.audioAsset.duration;
                 CGFloat audioDurationSeconds =CMTimeGetSeconds(audioDuration);
                 //录音时间小于两秒
                 if (audioDurationSeconds<1) {
                     self.popView.tishiLabel.text=@"录音时间太短";
                     [self performSelector:@selector(popViewRemove) withObject:nil afterDelay:0.5];
                 }
                 else
                 {
                     
                     LRLog(@"%@",self.MessageContentArray);
                     NSData*wavData=[NSData dataWithContentsOfFile:filePath];
                     //在此处发送声音到接口。在单元格展示。
                     ChatListModel*model=[[ChatListModel alloc]init];
                     model.isMeSend=YES;
                     model.iswavData=YES;
                     model.date=[NSDate date];
                     model.wavData=wavData;
                     model.interval=[[NSString stringWithFormat:@"%.0lf",audioDurationSeconds]floatValue];
                     model.isSendLocalNow=YES;
                     [self.MessageContentArray addObject:model];
                     [self layoutInputContentView:0 layoutTableView:YES reloadData:YES isScrollToBottom:YES];
                     [self popViewRemove];
                     
                 }
                 if ([FileMannager fileExistsAtPath:filePath]) {
                     [FileMannager removeItemAtPath:filePath error:nil];
                 }
             }
         }
         
         //发送后删除文件。
         if(phase==UITouchPhaseCancelled)
         {
             LRLog(@"cancel");
             if ([FileMannager fileExistsAtPath:filePath]) {
                 [FileMannager removeItemAtPath:filePath error:nil];
             }
             [self popViewRemove];
         }
         if (phase==UITouchPhaseMoved)
         {
             if(point.y<sender.frame.origin.y)
             {
                 LRLog(@"%f",point.y);
                 LRLog(@"上划");
                 self.popView.tishiLabel.text=@"松开手指,取消发送";
                 self.popView.tishiLabel.backgroundColor=[UIColor redColor];
                 
                 
             }
             else
             {
                 self.popView.tishiLabel.text=@"手指上划,取消发送";
                 self.popView.tishiLabel.backgroundColor=[UIColor clearColor];
             }
         }
         
     }
    

}
-(void)popViewRemove
{
    [self.popView dissmiss];
}

-(void)beginRecord
{
    AVAudioSession*session=[AVAudioSession sharedInstance];
    NSError*sessionError;
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
    if (sessionError==nil) {
        LRLog(@"%@",[sessionError description]);
    }
    else
    {
        [session setActive:YES error:nil];
    }
    self.session=session;
    NSString*path=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    filePath=[path stringByAppendingPathComponent:[NSString stringWithFormat:@"%ld.wav",self.MessageContentArray.count]];
    self.recordUrl=[NSURL fileURLWithPath:filePath];
      //设置参数
    NSDictionary *recordSetting = @{AVFormatIDKey: @(kAudioFormatLinearPCM),
                               AVSampleRateKey: @8000.00f,
                               AVNumberOfChannelsKey: @1,
                               AVLinearPCMBitDepthKey: @16,
                               AVLinearPCMIsNonInterleaved: @NO,
                               AVLinearPCMIsFloatKey: @NO,
                               AVLinearPCMIsBigEndianKey: @NO};
    self.recorder = [[AVAudioRecorder alloc] initWithURL:self.recordUrl settings:recordSetting error:nil];
    if (self.recorder) {
        self.recorder.meteringEnabled = YES;
        [self.recorder prepareToRecord];
        [self.recorder record];


    }else{
        LRLog(@"音频格式和文件存储格式不匹配,无法初始化Recorder");

    }

}
-(void)stopRecord
{
    LRLog(@"停止录音");
    if ([self.recorder isRecording]) {
        [self.recorder stop];
        LRLog(@"%.2fkb",  [[FileMannager attributesOfItemAtPath:filePath error:nil] fileSize]/1024.0);
        LRLog(@"333");

      }
}
- (void)PlayRecordWithWavData:(NSData*)data{
    LRLog(@"播放录音");
    if ([self.player isPlaying])return;
    self.player = [[AVAudioPlayer alloc] initWithData:data error:nil];
    [self.session setCategory:AVAudioSessionCategoryPlayback error:nil];
    [self.player play];
}

-(void)textViewDidChange:(HMEmoticonTextView *)textView
{
   //表情记得转换字符串
    if([textView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length>0){
        [self.emojiKeyBoard.sendButton setBackgroundColor:RGB(10, 96, 254, 1)];
        [self.emojiKeyBoard.sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    }
    else
    {

        [self.emojiKeyBoard.sendButton setBackgroundColor:RGB(250, 250, 250, 1)];
        [self.emojiKeyBoard.sendButton setTitleColor:RGB(128, 128, 128, 1) forState:UIControlStateNormal];
    }
    CGSize size=[textView sizeThatFits:CGSizeMake(SCREEN_WIDTH-152, MAXFLOAT)];
    [self layoutInputContentView:size.height+1 layoutTableView:YES reloadData:NO isScrollToBottom:YES];
    self.inputText= textView.emoticonText;
 
}

-(void)textViewDidEndEditing:(HMEmoticonTextView *)textField
{
    if ([textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length==0) {
        self.recordButton.hidden=NO;
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        [self sendMessage:nil];
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }

        return YES;



}
//textView适配高度
-(void)emojiSelectAtItem:(EmojiButton *)sender
{
    switch (sender.tag) {
        case 0:
        {

            HMEmoticon*emotion=[HMEmoticon emoticonWithDict:@{@"png":sender.backGroundImgName,@"type":@(0),@"chs":sender.chs,@"directory":@""}];
            [self.talkTextFied insertEmoticon:emotion isRemoved:NO];

        }
        break;
        case 1:
        {
            [self.talkTextFied insertEmoticon:nil isRemoved:YES];
        }
        default:
            break;
     }
}

-(void)emojiSend:(UIButton *)sender
{
    [self sendMessage:sender];
}


- (void)getEmoji:(UIButton *)sender {
    self.emojiKeyBoard.firstResponser=YES;
    [self.talkTextFied isFirstResponder]?[self.talkTextFied resignFirstResponder]:[self hideInputViewWithType:hideToolView isScrollToBottom:NO];
    [self jumpInputViewWithType:jumpEmoji];
}
////文本框发送消息
- (void)sendMessage:(UIButton *)sender {
    //这个地方加入
    if([self.talkTextFied.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length>0){
        
        ChatListModel*model=[[ChatListModel alloc]init];
        model.isMeSend=YES;
        model.istextSend=YES;
        model.textSend=self.inputText;
        model.date=[NSDate date];
        [self.MessageContentArray addObject:model];
        self.talkTextFied.attributedText=[[NSAttributedString alloc]initWithString:@""];
        self.inputText=@"";
        [self.emojiKeyBoard.sendButton setTitleColor:RGB(128, 128, 128, 1) forState:UIControlStateNormal];
        [self.emojiKeyBoard.sendButton setBackgroundColor:RGB(250, 250, 250, 1)];
        [self layoutInputContentView:35 layoutTableView:YES reloadData:YES isScrollToBottom:YES];

   }





}
//收到消息
-(void)recieveMessage:(ChatListModel *)Model
{
    [self.MessageContentArray addObject:Model];
    [self layoutInputContentView:0 layoutTableView:YES reloadData:YES isScrollToBottom:YES];

}

- (void)photoSend:(UIButton *)sender {
    self.toolView.firstResponser=YES;
    [self.talkTextFied isFirstResponder]?[self.talkTextFied resignFirstResponder]:[self hideInputViewWithType:hideEmoji isScrollToBottom:NO];
    [self jumpInputViewWithType:jumpToolView];
    
    
}
- (void)recordClick:(UIButton *)sender {
    if (sender.selected) {
        [self.talkTextFied becomeFirstResponder];
        self.longPressButton.hidden=YES;
        self.talkTextFied.hidden=NO;
    }
    else
    {
     
        [self hideInputView];
        self.longPressButton.hidden=NO;
        self.talkTextFied.hidden=YES;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@(35));
            }];
            
            
        });
    }
    sender.selected=!sender.selected;

}

//调整所有View
-(void)layoutInputContentView:(CGFloat)InputContentViewHeight  layoutTableView:(BOOL)isLayoutTableView  reloadData:(BOOL)isReloadData isScrollToBottom:(BOOL)scrollToBottom
{
    
    if (InputContentViewHeight>0&&isLayoutTableView) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.equalTo(@(InputContentViewHeight));
                }];
                [self.chatTableView layoutIfNeeded];
                if (isReloadData) {
                    [self.chatTableView reloadData];
                }
                NSIndexPath*indexPath=[NSIndexPath indexPathForRow:[self.chatTableView numberOfRowsInSection:0]-1 inSection:0];
                if (scrollToBottom) {
                     [self.chatTableView numberOfRowsInSection:0]>0?[self.chatTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES]:nil;
                }
                  
               
                
                
            });
    }
    if (InputContentViewHeight==0&&isLayoutTableView) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.chatTableView layoutIfNeeded];
            if (isReloadData) {
                [self.chatTableView reloadData];
            }
            NSIndexPath*indexPath=[NSIndexPath indexPathForRow:[self.chatTableView numberOfRowsInSection:0]-1 inSection:0];
            if (scrollToBottom) {
                 [self.chatTableView numberOfRowsInSection:0]>0?[self.chatTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES]:nil;
            }
               
          
            
            
        });
    }
    
   
    
}
#pragma tableView

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.MessageContentArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WEAKSELF
    ChatListModel*Model=self.MessageContentArray[indexPath.row];
    if (!Model.isMeSend) {
        if (Model.istextSend) {
            TextMessageCellOther*Cell=[tableView dequeueReusableCellWithIdentifier:@"TextMessageCellOther" forIndexPath:indexPath];
            [Cell.headImage sd_setImageWithURL:[self OtherHeadPhotoURL] placeholderImage:[UIImage imageNamed:@"headPhoto"] options:SDWebImageAllowInvalidSSLCertificates];
            Cell.sendContent.attributedText=[[HMEmoticonManager sharedManager]emoticonStringWithString:Model.textSend WithEmojiDic:self.EmojiDic StrDic:self.StrDic];
            Cell.tapBlock = ^(id any) {
              
            };
            return Cell;
        }
        if (Model.isImgData) {
              PictureCellOther*Cell=[tableView dequeueReusableCellWithIdentifier:@"PictureCellOther" forIndexPath:indexPath];
             [Cell.headImage sd_setImageWithURL:[self OtherHeadPhotoURL] placeholderImage:[UIImage imageNamed:@"headPhoto"] options:SDWebImageAllowInvalidSSLCertificates];
            Cell.tapBlock = ^(id any) {
               
            };
             [Cell.picture setImage:nil forState:UIControlStateNormal];
             Cell.picture.tag=indexPath.row;
             Cell.photoWidth=Model.width;
             Cell.scale=Model.scale;
            if (Model.imgData) {
                [Cell.picture setImage:[UIImage imageWithData:Model.imgData] forState:UIControlStateNormal];
            }
            else
            {
     //   sdwebimage加载的是原图，所以消耗内存，需要压缩后用于显示预览图
                [Cell.picture sd_setImageWithURL:[NSURL URLWithString:Model.imgURl] forState:UIControlStateNormal placeholderImage:nil options:SDWebImageAvoidAutoSetImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"tag=%ld",indexPath.row];
                    NSArray *array2= [weakSelf.bigImageContentArary filteredArrayUsingPredicate:predicate];
                    ArraySortModel*model=array2[0];
                    if (!error) {
                        Model.imgData=[Utils imageProcessWithOldImage:image];
                        [Cell.picture setImage:[UIImage imageWithData:Model.imgData] forState:UIControlStateNormal];
                        model.image=[UIImage imageWithData:Model.imgData];
                    }
                    else
                    {
                       
                        
                            [Cell.picture setImage:[UIImage imageNamed:@"timeout"] forState:UIControlStateNormal];
                            Model.imgData=UIImagePNGRepresentation([UIImage imageNamed:@"timeout"] ) ;
                             model.image=[UIImage imageWithData:Model.imgData];
                        

                    }

                }];

               
                
            }
           [Cell.picture addTarget:self action:@selector(preViewPhoto:) forControlEvents:UIControlEventTouchUpInside];
            return Cell;
            
        }
        if (Model.iswavData) {
          RecordCellOther*Cell=[tableView dequeueReusableCellWithIdentifier:@"RecordCellOther" forIndexPath:indexPath];
             [Cell.headImage sd_setImageWithURL:[self OtherHeadPhotoURL] placeholderImage:[UIImage imageNamed:@"headPhoto"] options:SDWebImageAllowInvalidSSLCertificates];
            Cell.tapBlock = ^(id any) {
            
            };
            Cell.playRecordButton.tag=indexPath.row;
            if (Model.wavData) {
                Cell.playRecordButton.enabled=YES;
            }
            else
            {
                Cell.playRecordButton.enabled=NO;
            }
            Cell.playRecordBlock = ^{
                [weakSelf PlayRecordWithWavData:Model.wavData];
            };
            Cell.recordSecond=Model.interval;
            return Cell;
        }
        if (Model.isVoiceTalk) {
            VoiceOrVideoTalkCellCellOther*Cell=[tableView dequeueReusableCellWithIdentifier:@"VoiceOrVideoTalkCellCellOther" forIndexPath:indexPath];
              [Cell.headImage sd_setImageWithURL:[self OtherHeadPhotoURL] placeholderImage:[UIImage imageNamed:@"headPhoto"] options:SDWebImageAllowInvalidSSLCertificates];
            Cell.tapBlock = ^(id any) {
               
            };
            [Cell.callButton setImage:[UIImage imageNamed:@"talkVoice"] forState:UIControlStateNormal];
            Cell.status=Model.hangUpStatus;
            Cell.callBlock = ^{
                
            };
            return Cell;
        }
        if (Model.isfaceTime) {
            VoiceOrVideoTalkCellCellOther*Cell=[tableView dequeueReusableCellWithIdentifier:@"VoiceOrVideoTalkCellCellOther" forIndexPath:indexPath];
             [Cell.headImage sd_setImageWithURL:[self OtherHeadPhotoURL] placeholderImage:[UIImage imageNamed:@"headPhoto"] options:SDWebImageAllowInvalidSSLCertificates];
            Cell.tapBlock = ^(id any) {
               
            };
            [Cell.callButton setImage:[UIImage imageNamed:@"talkVideo"] forState:UIControlStateNormal];
            Cell.status=Model.hangUpStatus;
            Cell.callBlock = ^{
                
            };
            return Cell;
        }
        return nil;
        
    }
    else
    {
        if (Model.istextSend) {
            TextMessageCell*Cell=[tableView dequeueReusableCellWithIdentifier:@"TextMessageCell" forIndexPath:indexPath];
            [Cell.headImage sd_setImageWithURL:[self mineHeadPhotoURL] placeholderImage:[UIImage imageNamed:@"headPhoto"] options:SDWebImageAllowInvalidSSLCertificates];
               Cell.sendContent.attributedText=[[HMEmoticonManager sharedManager]emoticonStringWithString:Model.textSend WithEmojiDic:self.EmojiDic StrDic:self.StrDic];
            return Cell;
        }
        if (Model.isImgData) {
            PictureCell*Cell=[tableView dequeueReusableCellWithIdentifier:@"PictureCell" forIndexPath:indexPath];
            [Cell.headImage sd_setImageWithURL:[self mineHeadPhotoURL] placeholderImage:[UIImage imageNamed:@"headPhoto"] options:SDWebImageAllowInvalidSSLCertificates];
            [Cell.picture setImage:nil forState:UIControlStateNormal];
            Cell.picture.tag=indexPath.row;
            Cell.photoWidth=Model.width;
            Cell.scale=Model.scale;
            if (Model.imgData) {
                [Cell.picture setImage:[UIImage imageWithData:Model.imgData] forState:UIControlStateNormal];
            }
            else
            {
                [Cell.picture sd_setImageWithURL:[NSURL URLWithString:Model.imgURl] forState:UIControlStateNormal placeholderImage:nil options:SDWebImageAvoidAutoSetImage completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"tag=%ld",indexPath.row];
                    NSArray *array2= [weakSelf.bigImageContentArary filteredArrayUsingPredicate:predicate];
                    ArraySortModel*model=array2[0];
                    if (!error) {
                        Model.imgData=[Utils imageProcessWithOldImage:image];
                        [Cell.picture setImage:[UIImage imageWithData:Model.imgData] forState:UIControlStateNormal];
                        model.image=[UIImage imageWithData:Model.imgData];
                    }
                    else
                    {
                      
                            [Cell.picture setImage:[UIImage imageNamed:@"timeout"] forState:UIControlStateNormal];
                            Model.imgData=UIImagePNGRepresentation([UIImage imageNamed:@"timeout"] ) ;
                            model.image=[UIImage imageWithData:Model.imgData];
                        

                    }
                }];
                
            }
            [Cell.picture addTarget:self action:@selector(preViewPhoto:) forControlEvents:UIControlEventTouchUpInside];
            return Cell;
        }
        if (Model.iswavData) {
       __weak ReCordCell*Cell=[tableView dequeueReusableCellWithIdentifier:@"ReCordCell" forIndexPath:indexPath];
           [Cell.headImage sd_setImageWithURL:[self mineHeadPhotoURL] placeholderImage:[UIImage imageNamed:@"headPhoto"] options:SDWebImageAllowInvalidSSLCertificates];
            Cell.playRecordButton.tag=indexPath.row;
            if (Model.wavData) {
                Cell.playRecordButton.enabled=YES;
            }
            else
            {
                Cell.playRecordButton.enabled=NO;
            }
            Cell.playRecordBlock = ^{
                [weakSelf PlayRecordWithWavData:Model.wavData];
            };
            Cell.recordSecond=Model.interval;
            return Cell;
        }
        if (Model.isVoiceTalk) {
            VoiceOrVideoTalkCell*Cell=[tableView dequeueReusableCellWithIdentifier:@"VoiceOrVideoTalkCell" forIndexPath:indexPath];
              [Cell.headImage sd_setImageWithURL:[self mineHeadPhotoURL] placeholderImage:[UIImage imageNamed:@"headPhoto"] options:SDWebImageAllowInvalidSSLCertificates];
            [Cell.callButton setImage:[UIImage imageNamed:@"talkVoice"] forState:UIControlStateNormal];
             Cell.status=Model.hangUpStatus;
            Cell.callBlock = ^{
                
            };
            return Cell;
        }
        if (Model.isfaceTime) {
            VoiceOrVideoTalkCell*Cell=[tableView dequeueReusableCellWithIdentifier:@"VoiceOrVideoTalkCell" forIndexPath:indexPath];
               [Cell.headImage sd_setImageWithURL:[self mineHeadPhotoURL] placeholderImage:[UIImage imageNamed:@"headPhoto"] options:SDWebImageAllowInvalidSSLCertificates];
            [Cell.callButton setImage:[UIImage imageNamed:@"talkVideo"] forState:UIControlStateNormal];
            Cell.status=Model.hangUpStatus;
            Cell.callBlock = ^{
                
            };
            return Cell;
        }
        return nil;
    }
}


-(void)preViewPhoto:(UIButton*)button
{
    
    
    NSArray*array=[[self.bigImageContentArary sortedArrayUsingComparator:^NSComparisonResult(ArraySortModel* obj1,ArraySortModel* obj2) {
        return [@(obj1.tag) compare:@(obj2.tag)];
    }] mutableCopy];
    NSMutableArray*array1=[NSMutableArray array];
    [array enumerateObjectsUsingBlock:^(ArraySortModel*obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.image) {
            IDMPhoto*photo=[IDMPhoto photoWithImage:obj.image];
            [array1 addObject:photo];
        }
        else
        {
            if (!obj.originalUrl) {
                obj.originalUrl=@"222";
            }
            IDMPhoto*photo1=[IDMPhoto photoWithURL:[NSURL URLWithString:obj.originalUrl]];
              [array1 addObject:photo1];
           
            
        }
    }];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"tag=%ld",button.tag];
    NSArray *array2= [array filteredArrayUsingPredicate:predicate];
    UITableViewCell*Cell=[self.chatTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:button.tag inSection:0]];
   IDMPhotoBrowser*browser=[[IDMPhotoBrowser alloc]initWithPhotos:array1 animatedFromView:[Cell valueForKeyPath:@"picture.imageView"]];
    browser.displayActionButton = true;
    browser.displayToolbar=true;
    browser.displayArrowButton = true;
    browser.displayCounterLabel = true;
    browser.usePopAnimation = true;
    [browser setInitialPageIndex:[array indexOfObject:array2[0]]];
    browser.autoHideInterface=false;
    browser.scaleImage=button.currentImage;
    browser.dismissOnTouch = true;
    [self presentViewController:browser animated:YES completion:nil];
}





#pragma keyBoardChange
-(void)KeyboardWillChangeFrame:(NSNotification*)notification
{
    NSDictionary *info = [notification userInfo];
    UIViewAnimationCurve curve=[[info objectForKey:UIKeyboardAnimationCurveUserInfoKey] intValue];
    NSInteger animationOption=curve<<16;
    CGRect keyBoardEndFrame=[[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval animationDuration=[[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    if (CGRectIsNull(keyBoardEndFrame)) {
        return;
    }
    CGSize size=[self.talkTextFied sizeThatFits:CGSizeMake(SCREEN_WIDTH-152, MAXFLOAT)];
    CGFloat space;
    if (@available(iOS 11.0, *)) {
      space=keyBoardEndFrame.origin.y==[UIScreen mainScreen].bounds.size.height?0:self.view.safeAreaInsets.bottom>0?CGRectGetHeight(keyBoardEndFrame)-self.view.safeAreaInsets.bottom:CGRectGetHeight(keyBoardEndFrame);
    } else {
        space=keyBoardEndFrame.origin.y==[UIScreen mainScreen].bounds.size.height?0:CGRectGetHeight(keyBoardEndFrame);
    }
    keyBoardEndFrame.origin.y!=[UIScreen mainScreen].bounds.size.height?[self hideInputViewWithType:hideToolView|hideEmoji isScrollToBottom:NO]:nil;
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:animationDuration delay:0.0 options:animationOption animations:^{
        if (![self.toolView firstResponser]&&(![self.emojiKeyBoard firstResponser])) {
          [self.bottomBarView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottomLayoutGuideTop).offset(-space);
          }];
          [self layoutInputContentView:size.height layoutTableView:YES reloadData:NO isScrollToBottom:YES];
          [self.view layoutIfNeeded];
        }
 
        
    } completion:^(BOOL finished) {
        
       
    }];

}

#pragma hideOtherInputView

-(void)hideInputViewWithType:(hideInputViewType)type isScrollToBottom:(BOOL)scrollToBottom
{
  
    CGFloat bottomBarViewMaxY=CGRectGetMaxY(self.bottomBarView.frame);
    if (@available(iOS 11.0, *)) {
        if(bottomBarViewMaxY==self.view.bounds.size.height-self.view.safeAreaInsets.bottom) {
            return;
        }

    } else {
       if(bottomBarViewMaxY==self.view.bounds.size.height)
       {
           return;
       }
    }
    UIViewAnimationCurve curve=7;
    NSInteger animationOption=curve<<16;
    NSTimeInterval animationDuration=0.25;
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:animationDuration delay:0.0 options:animationOption animations:^{
        if (type&hideEmoji) {
            [self.emojiKeyBoard mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.view.mas_bottom).offset(0);
            }];
            self.emojiKeyBoard.firstResponser=NO;
        }
        if (type&hideToolView) {
            [self.toolView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.view.mas_bottom).offset(0);
            }];
            self.toolView.firstResponser=NO;
        }
        if (scrollToBottom) {
            [self.bottomBarView mas_updateConstraints:^(MASConstraintMaker *make) {
                       make.bottom.equalTo(self.mas_bottomLayoutGuideTop);
            }];
            [self layoutInputContentView:0 layoutTableView:YES reloadData:NO isScrollToBottom:YES];

        }
        [self.view layoutIfNeeded];
    }completion:^(BOOL finished) {

    }];
    
}

#pragma jumInputView

-(void)jumpInputViewWithType:(jumpInputViewType)type
{
    self.talkTextFied.hidden=NO;
    self.longPressButton.hidden=YES;
    id View=[UIView new];
    if (type&jumpEmoji) {
        View=self.emojiKeyBoard;
    }
    if (type&jumpToolView) {
        View=self.toolView;
    }
    CGFloat Height=CGRectGetHeight([View frame]);
    CGFloat space;
    if (@available(iOS 11.0, *)) {
        space=self.view.safeAreaInsets.bottom+Height;
    } else {
        space=Height;
        // Fallback on earlier versions
    }
    UIViewAnimationCurve curve=7;
    NSInteger animationOption=curve<<16;
    NSTimeInterval animationDuration=0.25;
    CGSize size=[self.talkTextFied sizeThatFits:CGSizeMake(SCREEN_WIDTH-152, MAXFLOAT)];
    [self.view layoutIfNeeded];
    [UIView animateWithDuration:animationDuration delay:0.0 options:animationOption animations:^{
        [View mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_bottom).offset(-space);
        }];
        [self.bottomBarView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottomLayoutGuide).offset(-Height);
        }];
        
        [self layoutInputContentView:size.height layoutTableView:YES reloadData:NO isScrollToBottom:YES];
        [self.view layoutIfNeeded];
    }completion:^(BOOL finished) {

    }];
    
}



@end


