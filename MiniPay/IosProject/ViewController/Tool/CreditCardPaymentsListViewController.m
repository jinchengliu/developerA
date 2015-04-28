//
//  CreditCardPaymentsListViewController.m
//  MiniPay
//
//  Created by apple on 14-5-8.
//  Copyright (c) 2014年 allen. All rights reserved.
//

#import "CreditCardPaymentsListViewController.h"
#import "AddCreditCardCell.h"
#import "CreditCardCell.h"
#import "GDataXMLNode.h"
#import "CreditCardModel.h"
#import "AddCreditCardViewController.h"
@interface CreditCardPaymentsListViewController ()
{



}

@end

@implementation CreditCardPaymentsListViewController
@synthesize ishavecreditCar=_ishavecreditCar,array=_array;
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
    if(_ishavecreditCar)
    {
       self.title=@"信用卡还款（2/4)";
        NSMutableArray *arr=[[NSMutableArray alloc] init];
        _array=arr;
        [self.tableView setHidden:TRUE];
        [self refreshData:nil];
    }
    else
    {
      self.title=@"信用卡还款（1/4)";
    }
    // Do any additional setup after loading the view from its nib.
}

//刷新数据
-(IBAction)refreshData:(id)sender{
    
    [self showWaiting:@"请稍后…"];
    [self getcreditCarList];
    
}

-(void)getcreditCarList
{

    NSMutableArray *array=[[NSMutableArray alloc] init];
    
    [array addObject:@"TRANCODE"];
    [array addObject:SIGNATURE_CMD_708013];
    
    [array addObject:@"SELLTEL_B"];
    [array addObject:phonerNumber];
    
    NSString *paramXml=[CommonUtil createXml:array];
    NSString *PACKAGEMAC=[ValueUtils md5UpStr:paramXml];
    
    [array addObject:@"PACKAGEMAC"];
    [array addObject:PACKAGEMAC];
    
    NSString *params=[CommonUtil createXml:array];
    
    _controlCentral.requestController=self;
    [_controlCentral requestDataWithJYM:SIGNATURE_CMD_708013
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
    
    
        
    GDataXMLElement *TRANDETAILS = [[rootElement elementsForName:@"TRANDETAILS"] objectAtIndex:0];
    
    
    NSArray *cardarray = [TRANDETAILS elementsForName:@"TRANDETAIL"];
   
    [_array removeAllObjects];
    
    for (GDataXMLElement *user in cardarray) {
        
        CreditCardModel *model=[[CreditCardModel alloc] init];
        
        
        
        
        
        GDataXMLElement *MER_AC_NO = [[user elementsForName:@"MER_AC_NO"] objectAtIndex:0];
        [model setMER_AC_NO:[MER_AC_NO stringValue]];
        
        GDataXMLElement *MER_AC_NAME = [[user elementsForName:@"MER_AC_NAME"] objectAtIndex:0];
        [model setMER_AC_NAME:[MER_AC_NAME stringValue]];
        
        GDataXMLElement *CRDNAM = [[user elementsForName:@"CRDNAM"] objectAtIndex:0];
        [model setCRDNAM:[CRDNAM stringValue]];
        
        
        GDataXMLElement *CRDLOG = [[user elementsForName:@"CRDLOG"] objectAtIndex:0];
        [model setCRDLOG:[CRDLOG stringValue]];
        
        [_array addObject:model];
        
    }
    creditCardArray = [[_array reverseObjectEnumerator] allObjects];
    if(creditCardArray.count>0)
    {
      self.title=@"信用卡还款（2/4)";
        _ishavecreditCar=TRUE;
    }
    else
    {
        self.title=@"信用卡还款（1/4)";
        _ishavecreditCar=FALSE;

    }
  
    [self.tableView setHidden:FALSE];
    [self.tableView reloadData];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)cancelClick{
    
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)viewWillAppear:(BOOL)animated{
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 10, 20);
    [leftButton setBackgroundImage:[UIImage imageNamed:@"nav_back"]
                          forState:UIControlStateNormal];
    
    [leftButton addTarget:self
                   action:@selector(cancelClick)
         forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]
                             initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = item;
 UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
        rightButton.frame = CGRectMake(0, 0, 20, 20);
        [rightButton setBackgroundImage:[UIImage imageNamed:@"add_creditcard_icon"]
                            forState:UIControlStateNormal];
    
    [rightButton addTarget:self
                   action:@selector(addCreditCard)
         forControlEvents:UIControlEventTouchUpInside];
    
    item = [[UIBarButtonItem alloc]
                             initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = item;
    
    
    
}
-(void)deletecreditcrd:(int)indexRow 
{
    
     [self showWaiting:@"请稍后…"];
       CreditCardModel *model=[creditCardArray objectAtIndex:indexRow];

    NSString *cardno=model.MER_AC_NO;

    NSMutableArray *array=[[NSMutableArray alloc] init];
    
    [array addObject:@"TRANCODE"];
    [array addObject:SIGNATURE_CMD_708014];
    
    [array addObject:@"MER_AC_NO_B"];
    [array addObject:cardno];
    
    NSString *paramXml=[CommonUtil createXml:array];
    NSString *PACKAGEMAC=[ValueUtils md5UpStr:paramXml];

    [array addObject:@"PACKAGEMAC"];
    [array addObject:PACKAGEMAC];
    
    NSString *params=[CommonUtil createXml:array];
    
    _controlCentral.requestController=self;
    [_controlCentral requestDataWithJYM:SIGNATURE_CMD_708014
                             parameters:params
                     isShowErrorMessage:TRADE_URL_TYPE
                             completion:^(id result, NSError *requestError, NSError *parserError) {
                                 
                                 [self hideWaiting];
                                 if (result)
                                 {
                                     [self refreshData:nil];
                                     
                                 }
                             }];

    
}
-(void)addCreditCard
{
    AddCreditCardViewController *addCreditCardViewController=[[AddCreditCardViewController alloc] init];
    addCreditCardViewController.delegate=self;
    [self.navigationController pushViewController:addCreditCardViewController animated:YES];

}

-(NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    if(_ishavecreditCar)
    {
      return [creditCardArray count];
    }
    else
    {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(_ishavecreditCar)
    {
        return 108.f;

    }
    else
    {
        return 147.f;
    
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
 //  selestModel =[creditCardArray objectAtIndex:indexPath.row];
    
    
}

//(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString *CellIdentifier = @"cell1";
//    UITableViewCell *cell  =[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//        UILabel *labelTest = [[UILabel alloc]init];
//        
//        [labelTest setFrame:CGRectMake(2, 2, 80, 40)];
//        [labelTest setBackgroundColor:[UIColor clearColor]];
//        [labelTest setTag:1];
//        [[cell contentView]addSubview:labelTest];
//    }
//    UILabel *label1 = (UILabel*)[cell viewWithTag:1];
//    [label1 setText:[self.tests objectAtIndex:indexPath.row]];
//    return cell;
//}

-(UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {
    
    
    static NSString * CellIdentifier = @"AddCreditCardCell";
    
    
  
    
    if(_ishavecreditCar)
    {
         CellIdentifier = @"CreditCardCell";
          CreditCardCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if(nil==cell)
        {
            NSArray *nsa=[[NSBundle mainBundle]loadNibNamed:CellIdentifier owner:self options:nil];
            cell=[nsa objectAtIndex:0];
        }
        CreditCardModel *model=[creditCardArray objectAtIndex:indexPath.row];
        int lenth=model.MER_AC_NO.length-4;
        cell.cardNOLable.text=[NSString stringWithFormat:@"尾号%@信用卡",[model.MER_AC_NO substringWithRange:NSMakeRange(lenth, 4)]] ;
        cell.banknameLable.text=model.CRDNAM;
        NSURL *photourl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TRADE_BASE_URL,model.CRDLOG]];
        //url请求实在UI主线程中进行的
        UIImage *images = [UIImage imageWithData:[NSData dataWithContentsOfURL:photourl]];//通过网络url获取;
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
        NSString *imagePath =[NSString stringWithFormat:@"%@%@",TRADE_BASE_URL,model.CRDLOG];
        cell.cardimage.image=images;
        cell.deletebtn.tag=indexPath.row;
        cell.delegate=self;

        return cell;
        
    }
   
    else
    {
        CellIdentifier = @"AddCreditCardCell";
        AddCreditCardCell *cell1=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if(nil==cell1||!_ishavecreditCar)
        {
            NSArray *nsa=[[NSBundle mainBundle]loadNibNamed:CellIdentifier owner:self options:nil];
            cell1=[nsa objectAtIndex:0];
        }
       // cell1.addbtn.tag=indexPath.row;
        cell1.delegate=self;
       // [self.tableView re];
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [cell1 setNeedsDisplay];
        return  cell1;

    }
    
    
}



@end
