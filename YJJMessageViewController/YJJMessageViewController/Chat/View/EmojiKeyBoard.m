//
//  EmojiKeyBoard.m
//  QuMa
//
//  Created by yjj on 2017/6/9.
//  Copyright © 2017年 HuaLaHuaLa. All rights reserved.
//

#import "EmojiKeyBoard.h"
#import "EmojiButton.h"
@interface EmoJiCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet EmojiButton *button;


@end
@implementation EmoJiCollectionViewCell

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    
}


@end

@interface EmojiKeyBoard()
<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *emojiCollectionView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *emojiTypeChooseArray;
@property(strong,nonatomic)NSArray*dataSourceArray;


@end

@implementation EmojiKeyBoard
    
-(void)awakeFromNib
{
    [super awakeFromNib];
   self.sendButton.layer.shadowColor = RGB(209, 209, 209, 1).CGColor;//shadowColor阴影颜色
   self.sendButton.layer.shadowOffset = CGSizeMake(-5,0);//shadowOffset阴影偏移，默认(0, -3),这个跟shadowRadius配合使用
   self.sendButton.layer.shadowOpacity = 1;//阴影透明度，默认0
   self.sendButton.layer.shadowRadius = 3;//阴影半径，默认3
    
    //路径阴影
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    float width =self.sendButton.bounds.size.width;
    float height =self.sendButton.bounds.size.height;
    float x =self.sendButton.bounds.origin.x;
    float y =self.sendButton.bounds.origin.y;
    float addWH = 10;
    
    CGPoint topLeft      =self.sendButton.bounds.origin;
    CGPoint topMiddle = CGPointMake(x+(width/2),y-addWH);
    CGPoint topRight     = CGPointMake(x+width,y);
    
    CGPoint rightMiddle = CGPointMake(x+width+addWH,y+(height/2));
    
    CGPoint bottomRight  = CGPointMake(x+width,y+height);
    CGPoint bottomMiddle = CGPointMake(x+(width/2),y+height+addWH);
    CGPoint bottomLeft   = CGPointMake(x,y+height);
    
    
    CGPoint leftMiddle = CGPointMake(x-addWH,y+(height/2));
    
    [path moveToPoint:topLeft];
    //添加四个二元曲线
    [path addQuadCurveToPoint:topRight
                 controlPoint:topMiddle];
    [path addQuadCurveToPoint:bottomRight
                 controlPoint:rightMiddle];
    [path addQuadCurveToPoint:bottomLeft
                 controlPoint:bottomMiddle];
    [path addQuadCurveToPoint:topLeft
                 controlPoint:leftMiddle];  
    //设置阴影路径  
   self.sendButton.layer.shadowPath = path.CGPath;

 
        
}

-(NSArray*)dataSourceArray
{
    if (!_dataSourceArray) {
        _dataSourceArray=[NSArray array];
    _dataSourceArray=@[@{@"chs":@"[smile]"},@{@"chs":@"[xixi]"},@{@"chs":@"[haha]"},@{@"chs":@"[love]"},@{@"chs":@"[nose]"},@{@"chs":@"[amazed]"},@{@"chs":@"[halo]"},@{@"chs":@"[cry]"},@{@"chs":@"[greedy]"},@{@"chs":@"[crazy]"},@{@"chs":@"[heng]"},@{@"chs":@"[lovely]"},@{@"chs":@"[anger]"},@{@"chs":@"[sweat]"},@{@"chs":@"[shy]"},@{@"chs":@"[sleep]"},@{@"chs":@"[money]"},@{@"chs":@"[laughing]"},@{@"chs":@"[laughcry]"},@{@"chs":@"[doge]"},@{@"chs":@"[cat]"},@{@"chs":@"[cool]"},@{@"chs":@"[decline]"},@{@"chs":@"[shutup]"},@{@"chs":@"[despise]"},@{@"chs":@"[colour]"},@{@"chs":@"[applause]"},@{@"chs":@"[sad]"},@{@"chs":@"[think]"},@{@"chs":@"[fallill]"},@{@"chs":@"[kiss]"},@{@"chs":@"[curse]"},@{@"chs":@"[happy]"},@{@"chs":@"[superciliouslook]"},@{@"chs":@"[righthem]"},@{@"chs":@"[lefthem]"},@{@"chs":@"[hush]"},@{@"chs":@"[grievance]"},@{@"chs":@"[spit]"},@{@"chs":@"[poor]"},@{@"chs":@"[yawn]"},@{@"chs":@"[blinktheeyes]"},@{@"chs":@"[disappointment]"},@{@"chs":@"[top]"},@{@"chs":@"[doubt]"},@{@"chs":@"[sleepy]"},@{@"chs":@"[cold]"},@{@"chs":@"[bye]"},@{@"chs":@"[blackline]"},@{@"chs":@"[sinister]"},@{@"chs":@"[face]"},@{@"chs":@"[dumbfounded]"},@{@"chs":@"[follow]"},@{@"chs":@"[horse]"},@{@"chs":@"[yuanxiao]"},@{@"chs":@"[gettheoneimmediately]"},@{@"chs":@"[redenvelopes]"},@{@"chs":@"[friedchickenandbeer]"},@{@"chs":@"[takemicroblogforatrip]"},@{@"chs":@"[right]"},@{@"chs":@"[heart]"},@{@"chs":@"[sad1]"},@{@"chs":@"[pig]"},@{@"chs":@"[panda]"},@{@"chs":@"[rabbit]"},@{@"chs":@"[handshake]"},@{@"chs":@"[bow]"},@{@"chs":@"[fabulous]"},@{@"chs":@"[yeah]"},@{@"chs":@"[good]"},@{@"chs":@"[weak]"},@{@"chs":@"[no]"},@{@"chs":@"[ok]"},@{@"chs":@"[haha1]"},@{@"chs":@"[come]"},@{@"chs":@"[fist]"},@{@"chs":@"[mighty]"},@{@"chs":@"[flower]"},@{@"chs":@"[clock]"},@{@"chs":@"[cloud]"},@{@"chs":@"[aircraft]"},@{@"chs":@"[moon]"},@{@"chs":@"[sun]"},@{@"chs":@"[wind]"},@{@"chs":@"[rain]"},@{@"chs":@"[awesome]"},@{@"chs":@"[what]"},@{@"chs":@"[see]"},@{@"chs":@"[microphone]"},@{@"chs":@"[ultraman]"},@{@"chs":@"[fuck]"},@{@"chs":@"[adorable]"},@{@"chs":@"[jiong]"},@{@"chs":@"[weave]"},@{@"chs":@"[gift]"},@{@"chs":@"[happiness]"},@{@"chs":@"[collar]"},@{@"chs":@"[music]"},@{@"chs":@"[greenribbon]"},@{@"chs":@"[cake]"},@{@"chs":@"[candle]"},@{@"chs":@"[cheers]"},@{@"chs":@"[boy]"},@{@"chs":@"[girl]"},@{@"chs":@"[soap]"},@{@"chs":@"[camera]"},@{@"chs":@"[sina]"},@{@"chs":@"[sandstorm]"}];
    }
    return _dataSourceArray;
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
}
-(instancetype)init
{
    if (self=[super init]) {
        self=[[NSBundle mainBundle]loadNibNamed:@"EmojiKeyBoard" owner:self options:nil][0];
        self.pageControl.numberOfPages=5;
        self.pageControl.currentPage=0;
        ((UIButton*)(self.emojiTypeChooseArray[0])).backgroundColor=RGB(244, 244, 246, 1);
       [self.emojiCollectionView registerNib:[UINib nibWithNibName:@"EmoJiCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"EmoJiCollectionViewCell"];
        [self.emojiCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
        [self.emojiCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];

            self.emojiCollectionView.dataSource=self;
            self.emojiCollectionView.delegate=self;

    }
    return self;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return 24;

}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    LRLog(@"333");
    
    if (scrollView.contentOffset.x>=0&&scrollView.contentOffset.x/SCREEN_WIDTH<=4) {
        
        ((UIButton*)(self.emojiTypeChooseArray[0])).backgroundColor=RGB(244, 244, 246, 1);
        ((UIButton*)(self.emojiTypeChooseArray[1])).backgroundColor=[UIColor whiteColor];
        ((UIButton*)(self.emojiTypeChooseArray[2])).backgroundColor=[UIColor whiteColor];
        ((UIButton*)(self.emojiTypeChooseArray[3])).backgroundColor=[UIColor whiteColor];
        self.pageControl.numberOfPages=5;
        self.pageControl.tag=0;
        self.pageControl.currentPage=(NSInteger)(scrollView.contentOffset.x/SCREEN_WIDTH);
    }
    else if (scrollView.contentOffset.x>4&&scrollView.contentOffset.x/SCREEN_WIDTH<=5) {
        
        ((UIButton*)(self.emojiTypeChooseArray[1])).backgroundColor=RGB(244, 244, 246, 1);
        ((UIButton*)(self.emojiTypeChooseArray[0])).backgroundColor=[UIColor whiteColor];
        ((UIButton*)(self.emojiTypeChooseArray[2])).backgroundColor=[UIColor whiteColor];
        ((UIButton*)(self.emojiTypeChooseArray[3])).backgroundColor=[UIColor whiteColor];
        self.pageControl.numberOfPages=0;
        self.pageControl.tag=1;
        
    }
    else if(scrollView.contentOffset.x>5&&scrollView.contentOffset.x/SCREEN_WIDTH<=8)
    {
        
        ((UIButton*)(self.emojiTypeChooseArray[2])).backgroundColor=RGB(244, 244, 246, 1);
        ((UIButton*)(self.emojiTypeChooseArray[1])).backgroundColor=[UIColor whiteColor];
        ((UIButton*)(self.emojiTypeChooseArray[0])).backgroundColor=[UIColor whiteColor];
        ((UIButton*)(self.emojiTypeChooseArray[3])).backgroundColor=[UIColor whiteColor];
        self.pageControl.numberOfPages=3;
        self.pageControl.currentPage=(NSInteger)(scrollView.contentOffset.x/SCREEN_WIDTH-6);
        self.pageControl.tag=2;
    }
    else
    {
        ((UIButton*)(self.emojiTypeChooseArray[1])).backgroundColor=[UIColor whiteColor];
        ((UIButton*)(self.emojiTypeChooseArray[2])).backgroundColor=[UIColor whiteColor];
        ((UIButton*)(self.emojiTypeChooseArray[0])).backgroundColor=[UIColor whiteColor];
        ((UIButton*)(self.emojiTypeChooseArray[3])).backgroundColor=RGB(244, 244, 246, 1);
        self.pageControl.numberOfPages=2;
        self.pageControl.currentPage=(NSInteger)(scrollView.contentOffset.x/SCREEN_WIDTH-9);
        self.pageControl.tag=3;
    }
    
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
   
    if (scrollView.contentOffset.x>=0&&scrollView.contentOffset.x/SCREEN_WIDTH<=4) {
        
        ((UIButton*)(self.emojiTypeChooseArray[0])).backgroundColor=RGB(244, 244, 246, 1);
        ((UIButton*)(self.emojiTypeChooseArray[1])).backgroundColor=[UIColor whiteColor];
         ((UIButton*)(self.emojiTypeChooseArray[2])).backgroundColor=[UIColor whiteColor];
         ((UIButton*)(self.emojiTypeChooseArray[3])).backgroundColor=[UIColor whiteColor];
        self.pageControl.numberOfPages=5;
        self.pageControl.tag=0;
        self.pageControl.currentPage=(NSInteger)(scrollView.contentOffset.x/SCREEN_WIDTH);
    }
     else if (scrollView.contentOffset.x>4&&scrollView.contentOffset.x/SCREEN_WIDTH<=5) {
         
         ((UIButton*)(self.emojiTypeChooseArray[1])).backgroundColor=RGB(244, 244, 246, 1);
         ((UIButton*)(self.emojiTypeChooseArray[0])).backgroundColor=[UIColor whiteColor];
         ((UIButton*)(self.emojiTypeChooseArray[2])).backgroundColor=[UIColor whiteColor];
         ((UIButton*)(self.emojiTypeChooseArray[3])).backgroundColor=[UIColor whiteColor];
         self.pageControl.numberOfPages=0;
         self.pageControl.tag=1;
        
    }
    else if(scrollView.contentOffset.x>5&&scrollView.contentOffset.x/SCREEN_WIDTH<=8)
    {
        
        ((UIButton*)(self.emojiTypeChooseArray[2])).backgroundColor=RGB(244, 244, 246, 1);
        ((UIButton*)(self.emojiTypeChooseArray[1])).backgroundColor=[UIColor whiteColor];
        ((UIButton*)(self.emojiTypeChooseArray[0])).backgroundColor=[UIColor whiteColor];
        ((UIButton*)(self.emojiTypeChooseArray[3])).backgroundColor=[UIColor whiteColor];
        self.pageControl.numberOfPages=3;
         self.pageControl.currentPage=(NSInteger)(scrollView.contentOffset.x/SCREEN_WIDTH-6);
        self.pageControl.tag=2;
    }
    else
    {
        ((UIButton*)(self.emojiTypeChooseArray[1])).backgroundColor=[UIColor whiteColor];
        ((UIButton*)(self.emojiTypeChooseArray[2])).backgroundColor=[UIColor whiteColor];
        ((UIButton*)(self.emojiTypeChooseArray[0])).backgroundColor=[UIColor whiteColor];
        ((UIButton*)(self.emojiTypeChooseArray[3])).backgroundColor=RGB(244, 244, 246, 1);
        self.pageControl.numberOfPages=2;
         self.pageControl.currentPage=(NSInteger)(scrollView.contentOffset.x/SCREEN_WIDTH-9);
        self.pageControl.tag=3;
    }
//    switch (indexPath.section) {
//        case 0:
//            self.pageControl.numberOfPages=5;
//            break;
//        case 1:
//            self.pageControl.numberOfPages=0;
//            break;
//        case 3:
//            self.pageControl.numberOfPages=3;
//            break;
//        case 4:
//            self.pageControl.numberOfPages=2;
//        default:
//            break;
//    }
//    self.pageControl.currentPage=indexPath.row;
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 5;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    EmoJiCollectionViewCell*Cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"EmoJiCollectionViewCell" forIndexPath:indexPath];
    [Cell.button addTarget:self action:@selector(emojiselect:) forControlEvents:UIControlEventTouchUpInside];
    if ((indexPath.row+1)%3==1) {
        if (self.dataSourceArray.count-1>=(indexPath.section*24+(indexPath.row+1)/3)) {
            [Cell.button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%ld",indexPath.section*24+(indexPath.row+1)/3+1]] forState:UIControlStateNormal];
            NSDictionary*dic=self.dataSourceArray[indexPath.section*24+(indexPath.row+1)/3];
           Cell.button.chs=dic[@"chs"];
            Cell.button.backGroundImgName=[NSString stringWithFormat:@"%ld",indexPath.section*24+(indexPath.row+1)/3+1];
            Cell.button.tag=0;
        }
        else
        {
            [Cell.button setImage:nil forState:UIControlStateNormal];
               [Cell.button removeTarget:self action:@selector(emojiselect:) forControlEvents:UIControlEventTouchUpInside];
        }
        
    }
     if ((indexPath.row+1)%3==2)
    {
       
        
        if (self.dataSourceArray.count-1>=(indexPath.section*24+8+(indexPath.row+1)/3)) {
            [Cell.button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%ld",indexPath.section*24+8+(indexPath.row+1)/3+1]] forState:UIControlStateNormal];
            NSDictionary*dic=self.dataSourceArray[indexPath.section*24+8+(indexPath.row+1)/3];
            Cell.button.chs=dic[@"chs"];
            Cell.button.backGroundImgName=[NSString stringWithFormat:@"%ld",indexPath.section*24+8+(indexPath.row+1)/3+1];
            Cell.button.tag=0;
  
        }
        else
        {
            [Cell.button setImage:nil forState:UIControlStateNormal];
               [Cell.button removeTarget:self action:@selector(emojiselect:) forControlEvents:UIControlEventTouchUpInside];
        }
       
    }
    if ((indexPath.row+1)%3==0) {
        if ((indexPath.row+1)/3!=8) {
            [Cell.button setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%ld",indexPath.section*24+16+(indexPath.row+1)/3]] forState:UIControlStateNormal];
            if (self.dataSourceArray.count-1>=(indexPath.section*24+15+(indexPath.row+1)/3)) {
                NSDictionary*dic=self.dataSourceArray[indexPath.section*24+15+(indexPath.row+1)/3];
                Cell.button.chs=dic[@"chs"];
                Cell.button.backGroundImgName=[NSString stringWithFormat:@"%ld",indexPath.section*24+16+(indexPath.row+1)/3];
                Cell.button.tag=0;
            }
            else
            {
                [Cell.button setImage:nil forState:UIControlStateNormal];
                [Cell.button removeTarget:self action:@selector(emojiselect:) forControlEvents:UIControlEventTouchUpInside];
            }
          
        }
        else
        {
            [Cell.button setImage:[UIImage imageNamed:@"face_delete"] forState:UIControlStateNormal
            ];
            Cell.button.tag=1;
        }
       
       
    }

         return Cell;
}
-(void)emojiselect:(EmojiButton*)button
{
    if ([self.delegate respondsToSelector:@selector(emojiSelectAtItem:)]) {
        [self.delegate emojiSelectAtItem:button];
    }
 
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((SCREEN_WIDTH-50)/8.000,131/3.00000);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
        return CGSizeMake(25,131);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(25,131);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if ([kind isEqualToString:@"UICollectionElementKindSectionHeader"]) {
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        
        
        return header;
    } else {
        UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footer" forIndexPath:indexPath];
       
        
        
        return footer;
    }
    
    
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return  0;
   
}


- (IBAction)pageControlClick:(UIPageControl *)sender {
    LRLog(@"333");
    self.emojiCollectionView.contentOffset=CGPointMake(sender.currentPage*SCREEN_WIDTH, 0);
}
- (IBAction)emojiKeyBoardSend:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(emojiSend:)]) {
        [self.delegate emojiSend:sender];
    }
}


- (IBAction)click:(UITapGestureRecognizer *)sender {
    return;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
