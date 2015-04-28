//
//  
//  JKCustomAlert.m
//  AlertTest
//
//  Created by  on 12-5-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "JKCustomAlert.h"

@interface JKCustomAlert ()
    @property(nonatomic, retain) NSMutableArray *_buttonArrays;
@end

@implementation JKCustomAlert

@synthesize backgroundImage,contentImage,_buttonArrays,JKdelegate;
@synthesize msg,content;

- (id)initWithCustomer:(NSString *)titlemsg content:(NSString *)message btnType:(NSString *)type{
    if (self == [super init]) {
		
        self.backgroundImage = [UIImage imageNamed:@"alert_bg.png"];
        self.msg = titlemsg;
        self.content=message;
        
        if([type isEqualToString:@"default"]){
           
            UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn1 setImage:[UIImage imageNamed:@"confirm_btn.png"] forState:UIControlStateNormal];
            [btn1 setFrame:CGRectMake(12, 95, 120, 41)];
            
            UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn2 setImage:[UIImage imageNamed:@"cancel_btn.png"] forState:UIControlStateNormal];
            [btn2 setFrame:CGRectMake(140, 95, 120, 41)];
            
            self._buttonArrays = [NSMutableArray arrayWithObjects:btn1,btn2,nil];
        }else if([type isEqualToString:@"one"]){
            
            UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn1 setImage:[UIImage imageNamed:@"confirm_big_btn.png"] forState:UIControlStateNormal];
            [btn1 setFrame:CGRectMake(12, 95, 249, 41)];
            
            self._buttonArrays = [NSMutableArray arrayWithObjects:btn1,nil];
        }
	    }
    return self;
}

-(void) addButtonWithUIButton:(UIButton *) btn
{
    [_buttonArrays addObject:btn];
}


- (void)drawRect:(CGRect)rect {
	
	CGSize imageSize = self.backgroundImage.size;
	[self.backgroundImage drawInRect:CGRectMake(0, 0, imageSize.width, imageSize.height)];
    
}

- (void) layoutSubviews {
    //屏蔽系统的ImageView 和 UIButton
    for (UIView *v in [self subviews]) {
        if ([v class] == [UIImageView class]){
            [v setHidden:YES];
        }
           
     
        if ([v isKindOfClass:[UIButton class]] ||
            [v isKindOfClass:NSClassFromString(@"UIThreePartButton")]) {
            [v setHidden:YES];
        }
    }
    
    for (int i=0;i<[_buttonArrays count]; i++) {
        UIButton *btn = [_buttonArrays objectAtIndex:i];
        btn.tag = i;
        [self addSubview:btn];
        [btn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
	
         
        UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 271, 44)];
        titleLabel.text=self.msg;
        titleLabel.textAlignment=UITextAlignmentCenter;
        titleLabel.backgroundColor=[UIColor clearColor];
        titleLabel.font=[UIFont fontWithName:@"" size:18];
        titleLabel.textColor=[UIColor colorWithRed:244/255.0 green:110/255.0 blue:43/255.0 alpha:1];
        
        UILabel *contentLabel=[[UILabel alloc]initWithFrame:CGRectMake(12, 40, 250, 50)];
        contentLabel.text=self.content;
        contentLabel.textAlignment=UITextAlignmentCenter;
        contentLabel.backgroundColor=[UIColor clearColor];
        contentLabel.font=[UIFont fontWithName:@"STHeitiSC-Light" size:15];
        contentLabel.textColor=[UIColor blackColor];
        contentLabel.adjustsFontSizeToFitWidth = NO;
		contentLabel.numberOfLines = 2;
		contentLabel.baselineAdjustment = UIBaselineAdjustmentAlignCenters;

        
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, backgroundImage.size.width, backgroundImage.size.height-60)];
        [view setBackgroundColor:[UIColor clearColor]];
        [view addSubview:titleLabel];
        [titleLabel release];
        
        [view addSubview:contentLabel];
        [contentLabel release];
        [self addSubview:view];
  
}

-(void) buttonClicked:(id)sender
{
    UIButton *btn = (UIButton *) sender;
    
    if (JKdelegate) {
        if ([JKdelegate respondsToSelector:@selector(alertView:clickedButtonAtIndex:)])
        {
            [JKdelegate alertView:self clickedButtonAtIndex:btn.tag];
        }
    }
    
    [self dismissWithClickedButtonIndex:0 animated:YES];

}

- (void) show {
        [super show];
        CGSize imageSize = self.backgroundImage.size;
        self.bounds = CGRectMake(0, 0, imageSize.width, imageSize.height);
        

}


- (void)dealloc {
    [_buttonArrays removeAllObjects];
    [backgroundImage release];
    if (contentImage) {
        [contentImage release];
        contentImage = nil;
    }
   
    [super dealloc];
}


@end
