//
//  FlowViewController.h
//  MiniPay
//
//  Created by allen on 13-11-17.
//  Copyright (c) 2013年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ValueUtils.h"
#import "AESUtil.h"
#import "FlowCell.h"
#import "Response_199008_Model.h"
#import "SignatureViewController.h"

@interface FlowViewController : YMTradeBaseController<FlowCellDelagate,UIAlertViewDelegate,SignatureDelegate>{
    
    int rowIndex;
    NSString *tradeMoney;
    NSMutableString *macEnStr;
    
    Response_199008_Model *currentModel;
    NSArray* reversedArray;
    
}
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *totalNumTextView;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *fMoneyTextView;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *bMoneyTextView;
@property (weak, nonatomic) IBOutlet UILabel *myLable;
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *datetext;

@property(nonatomic,strong) NSMutableArray *array;
@property(nonatomic,strong) NSMutableArray *array1;
@property(nonatomic,strong) NSMutableArray *paramArray;
-(IBAction)hideKeyBoard:(id)sender;
-(IBAction)refreshData:(id)sender;
-(IBAction)findfordate:(id)sender;
@end
