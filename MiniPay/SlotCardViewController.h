//
//  SlotCardViewController.h
//  MiniPay
//
//  Created by allen on 13-11-17.
//  Copyright (c) 2013年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignatureViewController.h"
#import <CoreLocation/CoreLocation.h>
@interface SlotCardViewController : YMTradeBaseController<UITextFieldDelegate,CLLocationManagerDelegate>{
    
    NSMutableString *moneyStr;
    NSTimer *timer;
    NSString *tradeMoney;
    
    NSMutableArray *array;
    
    UIAlertView *alert;
    
   
}
@property (strong,nonatomic) CLLocationManager *locationManager;
@property (strong,nonatomic) CLLocation *startPoint;
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *moneyTextView;

-(IBAction)numberClick:(id)sender;

-(IBAction)slotCard:(id)sender;

@end
