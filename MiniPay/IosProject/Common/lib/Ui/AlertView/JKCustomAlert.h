//
//  JKCustomAlert.m
//  AlertTest
//
//  Created by  on 12-5-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol JKCustomAlertDelegate <NSObject>
@optional
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
@end

@interface JKCustomAlert : UIAlertView {
    id  JKdelegate;
	UIImage *backgroundImage;
    UIImage *contentImage;
    NSMutableArray *_buttonArrays;
    
    NSString *msg;
    NSString *content;

}

@property(readwrite, retain) UIImage *backgroundImage;
@property(readwrite, retain) UIImage *contentImage;

@property(readwrite, retain) NSString *msg;
@property(readwrite, retain) NSString *content;

@property(nonatomic, assign) id JKdelegate;

- (id)initWithCustomer:(NSString *)titlemsg content:(NSString *)message btnType:(NSString *)type;

-(void) addButtonWithUIButton:(UIButton *) btn;
@end
