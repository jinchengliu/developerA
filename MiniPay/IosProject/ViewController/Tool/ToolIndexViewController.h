//
//  ToolIndexViewController.h
//  MiniPay
//
//  Created by allen on 13-11-17.
//  Copyright (c) 2013年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ToolIndexViewController : YMTradeBaseController{
    
    NSMutableArray *array;
    NSMutableString *macEnStr;
    
    
    
}

@property(nonatomic,strong)NSMutableArray *array;

-(IBAction)iconClick:(id)sender;

@end
