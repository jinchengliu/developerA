//
//  Massage_LabController.m
//  CMBCDirectBank
//
//  Created by yitong on 13-10-8.
//  Copyright (c) 2013年 xuyunfei. All rights reserved.
//

#define kAlertViewSlideDownBgColor [UIColor colorWithRed:0/255.0 green:91.0/255.0 blue:181.0/255.0 alpha:1.0]
#define kAlertViewSlideDownLineColor [UIColor colorWithRed:220.0/255.0 green:227.0/255.0 blue:235.0/255.0 alpha:1.0]
#define kAlertViewSlideDownButtonColor1 [UIColor colorWithRed:253.0/255.0 green:173.0/255.0 blue:85.0/255.0 alpha:1.0]
#define kAlertViewSlideDownButtonColor2 [UIColor colorWithRed:70.0/255.0 green:182.0/255.0 blue:99.0/255.0 alpha:1.0]
#define kAlertViewSlideDownContentColor [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]

#define kAlertViewContentPadding 20

#import "Massage_LabController.h"


@implementation Massage_LabController

@synthesize otherBlock;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


+ (void)showWithTitle:(NSString *)title message:(NSString *)message otherBlock:(CMBCMassage_LabBlock)otherBlock prentView:(CMBCBankBaseViewController *)view
{
    
            
   // view.delegate=self;
    [[[self alloc] initWithTitle:title message:message otherBlock:otherBlock]
    show];
    
  
 }

- (id)initWithTitle:(NSString *)title  message:(NSString *)message otherBlock:(CMBCMassage_LabBlock)otherBlock

{
       self.otherBlock=otherBlock;
       UITapGestureRecognizer *tap=  [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(event:)];
       
    
    if ((self = [super initWithFrame:CGRectMake(0, 0, 320.0, 576.0)])) {
        
        if([UIApplication sharedApplication].statusBarHidden == NO) {
            self.frame = CGRectMake(0,20, 320.0, 576.0);
        }
        
        
                
        bgView = [self createBgView];
        contentView = [self createContentView:title message:message];
        [self addGestureRecognizer:tap];
        [bgView addGestureRecognizer:tap];
        self.tag=999999;
        //bgView.tag = 999999;
         [self addSubview:bgView];
 
          
        contentView.frame = CGRectMake(280, 44, 280,150+contentSize.height);
         [self addSubview:contentView];
         [UIView animateWithDuration:0.5f animations:^{

           contentView.frame= CGRectMake(40, 44, 280, 150+contentSize.height);
             bgView.alpha = 0.1;
            
        } completion:^(BOOL finished) {
            // [self createSideButton];
        }];
        
       

        
    }
    return self;
}



- (UIView*) createBgView
{
    UIView * bg = [[UIView alloc] init];
    bg.backgroundColor = [UIColor grayColor];
    bg.alpha = 0.0;
    bg.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    bg.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    return bg;
}

- (UIView*)createContentView:(NSString *)title message:(NSString *)message
                
{
    
    
   UIView *content = [[UIView alloc] init];
    //UIScrollView  *content=[[UIScrollView alloc]init];

    content.autoresizingMask = UIViewAutoresizingFlexibleWidth;
   // UIScrollView  *content=[[UIScrollView alloc]init]；
    
    //创建标题
    lbTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 25, 280, 20)];
    lbTitle.textAlignment = NSTextAlignmentCenter;
    lbTitle.font = [UIFont systemFontOfSize:20];
    lbTitle.text = title;
     lbTitle.textColor = kAlertViewSlideDownContentColor;
    lbTitle.backgroundColor = [UIColor clearColor];

    //添加一条分割线
    UIView * vLine = [[UIView alloc] initWithFrame:CGRectMake(10.0, 55.0, 260, 0.6)];
    vLine.backgroundColor = kAlertViewSlideDownLineColor;
    [content addSubview:lbTitle];
    [content addSubview:vLine];
         
    //创建内容区（左右上线边距20）
    float contentWidth = 240.0;
    UIFont * fontContent = [UIFont systemFontOfSize:16];
   // CGSize contentSize;
    if(kIsIphone5) {
        contentSize = [message sizeWithFont:fontContent constrainedToSize:CGSizeMake(contentWidth, self.frame.size.height-200) lineBreakMode:NSLineBreakByCharWrapping];
    }
    else
    {
        contentSize = [message sizeWithFont:fontContent constrainedToSize:CGSizeMake(contentWidth, self.frame.size.height-300) lineBreakMode:NSLineBreakByCharWrapping];
    }
    //lbContent = [[UILabel alloc] initWithFrame:CGRectMake(kAlertViewContentPadding, vLine.frame.origin.y+kAlertViewContentPadding,contentWidth, contentSize.height)];
    lbContent = [[UITextView alloc] initWithFrame:CGRectMake(kAlertViewContentPadding, vLine.frame.origin.y+kAlertViewContentPadding,contentWidth, contentSize.height+80)];
      lbContent.scrollEnabled = YES;//是否可以拖动
    
    
    [lbContent setEditable:NO];
    //lbContent.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适应高度
    lbContent.backgroundColor = [UIColor clearColor];
    lbContent.text = message;
    lbContent.textColor = kAlertViewSlideDownContentColor;
    //lbContent.numberOfLines = 0;
    lbContent.font = fontContent;
    //lbContent.lineBreakMode = NSLineBreakByCharWrapping;
    
    [content addSubview:lbContent];

    content.backgroundColor = kAlertViewSlideDownBgColor;

           return content;
}


-(void)show
{
    //[UIApplication sharedApplication].delegate.window.self.
    //[self removeFromSuperview];
    [[[[[UIApplication sharedApplication] delegate] window] viewWithTag:999999]removeFromSuperview];
    [[UIApplication sharedApplication].delegate.window addSubview:self];
    
}



-(void)dismissSelf
{
    
    [UIView animateWithDuration:0.5f animations:^{
     //   CGSize selfViewSize = self.frame.size;
        contentView.frame = CGRectMake(320, 44, 280, 150+contentSize.height);
        
        
        
    } completion:^(BOOL finished) {
        [contentView removeFromSuperview];
        contentView=nil;
         [self removeFromSuperview];

    }];

}
- (void)event:(UITapGestureRecognizer *)gesture
{
    
    [self dismissSelf];
    

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
