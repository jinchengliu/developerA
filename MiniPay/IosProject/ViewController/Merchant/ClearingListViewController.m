//
//  ClearingListViewController.m
//  MiniPay
//
//  Created by allen on 13-11-17.
//  Copyright (c) 2013年 allen. All rights reserved.
//
//清算列表
#import "ClearingListViewController.h"
#import "ClearingListCell.h"
#import "GDataXMLNode.h"

@interface ClearingListViewController ()

@end

@implementation ClearingListViewController

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
    self.title=@"清算列表";
    NSMutableArray *arr=[[NSMutableArray alloc] init];
    _array=arr;
    [self showWaiting:nil];
    //获取商户信息
    [self getMerchantList];
}
//获取商户信息
-(void)getMerchantList
{
    NSMutableArray *array=[[NSMutableArray alloc] init];
    NSString *phonerNumber=[_dataManager GetObjectWithNSUserDefaults:PHONENUMBER];
    [array addObject:@"TRANCODE"];
    [array addObject:MERCHANT_CMD_199009];
    [array addObject:@"PHONENUMBER"];
    [array addObject:phonerNumber];
    [array addObject:@"PACKAGEMAC"];
    [array addObject:[ValueUtils md5UpStr:[CommonUtil createXml:array]]];
    NSString *params=[CommonUtil createXml:array];
    _controlCentral.requestController=self;
    [_controlCentral requestDataWithJYM:MERCHANT_CMD_199009
                             parameters:params
                     isShowErrorMessage:TRADE_URL_TYPE
                             completion:^(id result, NSError *requestError, NSError *parserError) {
                                 [self hideWaiting];
                                 if (result)
                                 {
                                     GDataXMLElement *rootElement=(GDataXMLElement *)result;
                                     [self parseXml:rootElement];
                                 }
                             }];
}
//解析xml
-(void)parseXml:(GDataXMLElement *)rootElement{
    GDataXMLElement *trandetailsElement = [[rootElement elementsForName:@"TRANDETAILS"] objectAtIndex:0];
    NSArray *trandetail = [trandetailsElement elementsForName:@"TRANDETAIL"];
    [_array removeAllObjects];
    for (GDataXMLElement *user in trandetail) {
        Response_199009_Model *model=[[Response_199009_Model alloc] init];
        GDataXMLElement *bRAACTNOElement = [[user elementsForName:@"BRAACTNO"] objectAtIndex:0];
        [model setBRAACTNO:[bRAACTNOElement stringValue]];
        GDataXMLElement *mERNAMElement = [[user elementsForName:@"MERNAM"] objectAtIndex:0];
        [model setMERNAM:[mERNAMElement stringValue]];
        GDataXMLElement *oPNBNKElement = [[user elementsForName:@"OPNBNK"] objectAtIndex:0];
        [model setOPNBNK:[oPNBNKElement stringValue]];
        GDataXMLElement *tXNENDDTElement = [[user elementsForName:@"TXNENDDT"] objectAtIndex:0];
        [model setTXNENDDT:[tXNENDDTElement stringValue]];
        GDataXMLElement *tOTTXNCNTElement = [[user elementsForName:@"TOTTXNCNT"] objectAtIndex:0];
        [model setTOTTXNAMT:[tOTTXNCNTElement stringValue]];
        GDataXMLElement *cRDFLGElement = [[user elementsForName:@"CRDFLG"] objectAtIndex:0];
        [model setCRDFLG:[cRDFLGElement stringValue]];
        GDataXMLElement *sTLDTElement = [[user elementsForName:@"STLDT"] objectAtIndex:0];
        [model setSTLDT:[sTLDTElement stringValue]];
        GDataXMLElement *sTLTOTALAMTElement = [[user elementsForName:@"STLTOTALAMT"] objectAtIndex:0];
        [model setSTLTOTALAMT:[sTLTOTALAMTElement stringValue]];
        GDataXMLElement *tOTTXNAMTElement = [[user elementsForName:@"TOTTXNAMT"] objectAtIndex:0];
        [model setTOTTXNAMT:[tOTTXNAMTElement stringValue]];
        GDataXMLElement *tXNSTRDTElement = [[user elementsForName:@"TXNSTRDT"] objectAtIndex:0];
        [model setTXNSTRDT:[tXNSTRDTElement stringValue]];
        [_array addObject:model];
    }
    if([_array count]>0){
        [self.tableView reloadData];
    }else{
        [self showAlert:@"暂无清算信息"];
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_array count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.f;
}
-(UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {
    static NSString * CellIdentifier = @"ClearingListCell";
    UITableViewCell *cell = (UITableViewCell*)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell==nil)
    {
        NSArray *views=[[NSBundle mainBundle]loadNibNamed:CellIdentifier owner:nil options:nil];
        cell=[views objectAtIndex:0];
    }
    Response_199009_Model *model=[_array objectAtIndex:indexPath.row];
    [(ClearingListCell *)cell setData:model];
    return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
