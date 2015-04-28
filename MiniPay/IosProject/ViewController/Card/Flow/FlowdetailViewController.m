//
//  FlowdetailViewController.m
//  MiniPay
//
//  Created by apple on 14-5-13.
//  Copyright (c) 2014年 allen. All rights reserved.
//

#import "FlowdetailViewController.h"
#import "GDataXMLNode.h"
@interface FlowdetailViewController ()

@end

@implementation FlowdetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setpageTitle:@"小票详情"];
    //self.title=@"小票详情";
    [self showWaiting:@""];
    [self GetFlowdeatal];
    
    // Do any additional setup after loading the view from its nib.
}

-(void)GetFlowdeatal
{
    NSMutableArray *array=[[NSMutableArray alloc] init];
    
    [array addObject:@"TRANCODE"];
    [array addObject:FLOW_CMD_199036];
//    [array addObject:@"PHONENUMBER"];
//    [array addObject:phonerNumber];
    
    [array addObject:@"LOGNO"];
    [array addObject:_logoNo];
    
    NSString *paramXml=[CommonUtil createXml:array];
    NSString *PACKAGEMAC=[ValueUtils md5UpStr:paramXml];
    
    [array addObject:@"PACKAGEMAC"];
    [array addObject:PACKAGEMAC];
    
    NSString *params=[CommonUtil createXml:array];
    
    _controlCentral.requestController=self;
    [_controlCentral requestDataWithJYM:FLOW_CMD_199036
                             parameters:params
                     isShowErrorMessage:TRADE_URL_TYPE
                             completion:^(id result, NSError *requestError, NSError *parserError) {
                                 
                                 [self hideWaiting];
                                 if (result)
                                 {
                                     GDataXMLElement *rootElement=(GDataXMLElement *)result;
                                     GDataXMLElement *MERCNAM = [[rootElement elementsForName:@"MERCNAM"] objectAtIndex:0];
                                     GDataXMLElement *MERCID = [[rootElement elementsForName:@"MERCID"] objectAtIndex:0];
                                     GDataXMLElement *TXNTYP = [[rootElement elementsForName:@"TXNTYP"] objectAtIndex:0];
                                     GDataXMLElement *TXNDATE = [[rootElement elementsForName:@"TXNDATE"] objectAtIndex:0];
                                     GDataXMLElement *TXNAMT = [[rootElement elementsForName:@"TXNAMT"] objectAtIndex:0];
                                    
                                     [_label setText:[MERCNAM stringValue]];
                                     [_label1 setText:[MERCID stringValue]];
                                     [_label2 setText:[TXNTYP stringValue]];
                                     //NSString*str=[TXNDATE stringValue];
                                     
                                    
                                    
                                     NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                                     //设定时间格式,这里可以设置成自己需要的格式
                                     [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
//                                     [dateFormatter stringFromDate:[ValueUtils formatStrToDate:[TXNDATE stringValue]]];
                                     
                                     [_label3 setText: [dateFormatter stringFromDate:[ValueUtils formatStrToDate:[TXNDATE stringValue]]]];
                                      [_label4 setText:[NSString stringWithFormat:@"￥%@",[TXNAMT stringValue]]];
                                     
                                     //[self parseXml:rootElement];
                                     
                                 }
                             }];

}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
