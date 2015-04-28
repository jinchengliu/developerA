//
//  SmrztwoViewController.m
//  MiniPay
//
//  Created by apple on 14-5-9.
//  Copyright (c) 2014年 allen. All rights reserved.
//

#import "SmrztwoViewController.h"
#import "TSLocateView.h"
#import "GDataXMLNode.h"
#import "TSLocation.h"
#import "SmrzThreeViewController.h"
#import  "BankMassage.h"
@interface SmrztwoViewController ()
{
    BOOL ishidwait;
    
}

@end

@implementation SmrztwoViewController

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
    //self.title=@"基本信息(2/3)";
    [self setpageTitle:@"基本信息(2/3)"];
    //    NSMutableArray *arr=[[NSMutableArray alloc] init];
    //    _array=arr;
    //    NSMutableArray *arr1=[[NSMutableArray alloc] init];
    //    _array1=arr1;
    //    NSMutableArray *arr2=[[NSMutableArray alloc] init];
    //    _array2=arr2;
    _selectPicker.frame = CGRectMake(0, 480, 320, 216);
    self.textField.delegate = self;
    self.textField1.delegate = self;
    
    self.textField2.delegate = self;
    self.textField3.delegate = self;
    self.textField4.delegate = self;
    //self.textField3.inputAccessoryView = _doneToolbar;
    self.textField2.inputAccessoryView = _doneToolbar;
    isclean=NO;
    [_doneToolbar setHidden:YES];
    [self showWaiting:@""];
    ishidwait=YES;
    [self getcityprovinces];
    
    if(IsNilString(_bank_showname))
        _bank_showname=_bank_name;
    // Do any additional setup after loading the view from its nib.
    [self set_Text];
    if(_Is_Edit)
    {
        [_btn setHidden:YES];
    }
}

-(void)set_Text
{
      _textField.text=_name;
    //_textField.text=_kaihu_name;
    if(IsNilString(_kaihu_address_p)||IsNilString(_kaihu_address_s))
    {
        _textField1.text=@"";
    }
    else
        _textField1.text=[NSString stringWithFormat:@"%@,%@",_kaihu_address_p,_kaihu_address_s];
    citycode=_kaihu_addresscode;
    _textField2.text=_bank_showname;
    
    bankId=_bank_code;
    _textField3.text=_bank_address;
    bankNO=_bank_No;
    _textField4.text=_card_NO;
    
}

- (IBAction)selectButton:(id)sender {
    isclean=NO;
    [usertextfield endEditing:YES];
    [_doneToolbar setHidden:YES];
}

- (IBAction)cleanButton:(id)sender
{
    isclean=YES;
    [usertextfield endEditing:YES];
    
}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row
          forComponent:(NSInteger)component reusingView:(UIView *)view
{
   

    UILabel*mycom1 = view ? (UILabel *) view : [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 300.0f, 30.0f)];
    
    if(pickerArray.count>0)
    {
       BankMassage *bankMassage=[pickerArray objectAtIndex:row];
       mycom1.text = bankMassage.bank_Name;
      [mycom1 setFont:[UIFont boldSystemFontOfSize:12]];
       mycom1.backgroundColor = [UIColor clearColor];
    }
    // CFShow(mycom1);
    //  [imgstr1 release];
//    if(row==0)
//    {
//           }
   
    
    return mycom1;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [pickerArray count];
}
-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    BankMassage *bankMassage=[pickerArray objectAtIndex:row];
    
    
    return bankMassage.bank_Name;
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    NSInteger row = [_selectPicker selectedRowInComponent:0];
    if(pickerArray .count>0)
    {
        if(!isclean&& textField==self.textField2)
        {
            
            BankMassage *bankMassage=[pickerArray objectAtIndex:row];
            usertextfield.text = bankMassage.bank_Showname;
            _bank_name=IsNilString(bankMassage.bank_Name)?@"":bankMassage.bank_Name;
            bankId=IsNilString(bankMassage.bank_Id)?@"":bankMassage.bank_Id;
            bankNO=IsNilString(bankMassage.bank_No)?@"":bankMassage.bank_No;
        }
        //   else if(!isclean&& textField==self.textField3)
        //    {
        //
        //        BankMassage *bankMassage=[pickerArray objectAtIndex:row];
        //        usertextfield.text = bankMassage.bank_Name;
        //        citybankId=bankMassage.bank_Id;
        //    }
    }
    //[self hiddenKeyboard];
    self.view.frame =CGRectMake(0, kSystemVersion>=7.0?63:0, self.view.frame.size.width, self.view.frame.size.height);
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(_Is_Edit)
    {
        return NO;
    }
    
    CGRect frame = textField.frame;
    int offset = frame.origin.y + 28 - (self.view.frame.size.height - 216.0);//键盘高度216
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
    if(offset > 0)
        self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
    
    [UIView commitAnimations];
    if(locateView)
    {
        [locateView cancel:nil];
        locateView=nil;
        
    }
    
    if(textField==_textField2)
    {
        usertextfield=textField;
       
        //[_doneToolbar setHidden:NO];
        [self showWaiting:@""];
        [self getbankname];
        
        _textField2.inputView = _selectPicker;
        //[_doneToolbar setHidden:NO];
        [_selectPicker setHidden:YES];
    }
    //    if(textField==_textField3)
    //    {
    //        usertextfield=textField;
    //        _textField3.inputView = _selectPicker;
    //        [_doneToolbar setHidden:NO];
    //
    //        if (![CommonUtil strNilOrEmpty:bankId]&&![CommonUtil strNilOrEmpty:citycode])
    //        [self getcitybank];
    //        else
    //        {
    //            [self performSelector:@selector(selectButton:) withObject:nil afterDelay:0.5];
    //
    //            [self showAlert:@"请选择城市和开户行！"];
    //
    //        }
    //
    //
    //    }
    
    else if(textField==self.textField1)
    {
        [self performSelector:@selector(hiddenKeyboard) withObject:nil afterDelay:0.5];
        
        // [self hiddenKeyboard];
        locateView = [[TSLocateView alloc] initWithTitle:@"城市" delegate:self provinces:provinces citys:cities];
        locateView.hidwaitBlock=^(void){
            [self hideWaiting];
            ishidwait=YES;
        };
        // locateView.hidesBottomBarWhenPushed=YES;
        locateView.getcityBlock=^(NSString *code){
            [self showWaiting:@""];
            ishidwait=NO;
            
            [self  getcitycity:code];
            return cities;
            
        };
        
        //[self performSelector:@selector(hiddenKeyboard) withObject:nil afterDelay:0.5];
        
        [locateView showInView:self.view];
        
        return NO;
    }
    
    return YES;
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    //You can uses location to your application.
    if(buttonIndex == 0) {
        NSLog(@"Cancel");
    }else {
        NSLog(@"Select");
        TSLocateView *locateView = (TSLocateView *)actionSheet;
        pcode = locateView.locate.code;
        citycode = locateView.city.code;
        provincename=locateView.locate.country;
        cityname=locateView.city.country;
        _textField1.text=[NSString stringWithFormat:@"%@,%@",locateView.locate.country,locateView.city.country];
    }
}

-(void)getcitybank
{
    NSMutableArray *array=[[NSMutableArray alloc] init];
    [array addObject:@"TRANCODE"];
    [array addObject:FEEBACK_CMD_199034];
    [array addObject:@"CITYCOD"];
    [array addObject:citycode];
    [array addObject:@"BBANKCOD"];
    [array addObject:bankId];
    NSString *paramXml=[CommonUtil createXml:array];
    NSString *PACKAGEMAC=[ValueUtils md5UpStr:paramXml];
    [array addObject:@"PACKAGEMAC"];
    [array addObject:PACKAGEMAC];
    NSString *params=[CommonUtil createXml:array];
    _controlCentral.requestController=self;
    [_controlCentral requestDataWithJYM:FEEBACK_CMD_199034
                             parameters:params
                     isShowErrorMessage:NO_TRADE_URL_TYPE
                             completion:^(id result, NSError *requestError, NSError *parserError) {
                                 
                                 // [self hideWaiting];
                                 if (result)
                                 {
                                     GDataXMLElement *rootElement=(GDataXMLElement *)result;
                                     GDataXMLElement *TRANDETAILS = [[rootElement elementsForName:@"TRANDETAILS"] objectAtIndex:0];
                                     
                                     
                                     NSArray *cardarray = [TRANDETAILS elementsForName:@"TRANDETAIL"];
                                     
                                     
                                     NSMutableArray *resarray= [[NSMutableArray alloc] init];
                                     
                                     for (GDataXMLElement *user in cardarray) {
                                         
                                         
                                         BankMassage *model=[[BankMassage alloc]init];
                                         GDataXMLElement *BANKNAM = [[user elementsForName:@"BANKNAM"] objectAtIndex:0];
                                         [model setBank_Name:[BANKNAM stringValue]];
                                         
                                         GDataXMLElement *BANKNO = [[user elementsForName:@"BANKNO"] objectAtIndex:0];
                                         [model setBank_Id:[BANKNO stringValue]];
                                         
                                         
                                         
                                         [resarray addObject:model];
                                         
                                     }
                                     
                                     pickerArray = resarray;
                                     if(pickerArray.count>0)
                                     {
                                         _selectPicker.delegate = self;
                                         _selectPicker.dataSource = self;
                                     }
                                     else
                                         
                                     {
                                         [self showAlert:@"没查到当前城市的网点信息！"];
                                         [self selectButton:nil];
                                     }
                                     //_selectPicker.dataSource=pickerArray;
                                     
                                 }
                             }];
    
}

-(void)getbankname
{
    NSMutableArray *array=[[NSMutableArray alloc] init];
    [array addObject:@"TRANCODE"];
    [array addObject:FEEBACK_CMD_199035];
    
    
    NSString *paramXml=[CommonUtil createXml:array];
    NSString *PACKAGEMAC=[ValueUtils md5UpStr:paramXml];
    
    [array addObject:@"PACKAGEMAC"];
    [array addObject:PACKAGEMAC];
    
    NSString *params=[CommonUtil createXml:array];
    
    _controlCentral.requestController=self;
    [_controlCentral requestDataWithJYM:FEEBACK_CMD_199035
                             parameters:params
                     isShowErrorMessage:NO_TRADE_URL_TYPE
                             completion:^(id result, NSError *requestError, NSError *parserError) {
                                 
                                 [self hideWaiting];
                                 if (result)
                                 {
                                     GDataXMLElement *rootElement=(GDataXMLElement *)result;
                                     GDataXMLElement *TRANDETAILS = [[rootElement elementsForName:@"TRANDETAILS"] objectAtIndex:0];
                                     
                                     
                                     NSArray *cardarray = [TRANDETAILS elementsForName:@"TRANDETAIL"];
                                     
                                     NSMutableArray *resarray= [[NSMutableArray alloc] init];
                                     
                                     
                                     for (GDataXMLElement *user in cardarray) {
                                         
                                         
                                         BankMassage *model=[[BankMassage alloc]init];
                                         
                                         
                                         
                                         
                                         
                                         
                                         GDataXMLElement *BANKNAM = [[user elementsForName:@"BANKNAM"] objectAtIndex:0];
                                         [model setBank_Name:[BANKNAM stringValue]];
                                         
                                         GDataXMLElement *BANKCOD = [[user elementsForName:@"BANKCOD"] objectAtIndex:0];
                                         [model setBank_Id:[BANKCOD stringValue]];
                                         
                                         GDataXMLElement *BANKNO = [[user elementsForName:@"BANKNO"] objectAtIndex:0];
                                         [model setBank_No:[BANKNO stringValue]];
                                         
                                         GDataXMLElement *SHOWBANKNAME = [[user elementsForName:@"SHOWBANKNAME"] objectAtIndex:0];
                                         [model setBank_Showname:[SHOWBANKNAME stringValue]];
                                         
                                         
                                         
                                         
                                         [resarray addObject:model];
                                         
                                     }
                                     
                                     pickerArray = resarray;
                                     _selectPicker.delegate = self;
                                     _selectPicker.dataSource = self;
                                     [_doneToolbar setHidden:NO];
                                     [_selectPicker setHidden:NO];


                                     //_selectPicker.dataSource=pickerArray;
                                     
                                 }
                             }];
    
    
}

-(void)getcityprovinces
{
    NSMutableArray *array=[[NSMutableArray alloc] init];
    [array addObject:@"TRANCODE"];
    [array addObject:FEEBACK_CMD_199031];
    
    
    NSString *paramXml=[CommonUtil createXml:array];
    NSString *PACKAGEMAC=[ValueUtils md5UpStr:paramXml];
    
    [array addObject:@"PACKAGEMAC"];
    [array addObject:PACKAGEMAC];
    
    NSString *params=[CommonUtil createXml:array];
    
    _controlCentral.requestController=self;
    [_controlCentral requestDataWithJYM:FEEBACK_CMD_199031
                             parameters:params
                     isShowErrorMessage:NO_TRADE_URL_TYPE
                             completion:^(id result, NSError *requestError, NSError *parserError) {
                                 
                                 // [self hideWaiting];
                                 if (result)
                                 {
                                     GDataXMLElement *rootElement=(GDataXMLElement *)result;
                                     [self parseXml:rootElement];
                                     
                                     // [self sendCheckCode1];
                                 }
                             }];
    
}

//解析xml
-(void)parseXml:(GDataXMLElement *)rootElement{
    
    
    
    GDataXMLElement *TRANDETAILS = [[rootElement elementsForName:@"TRANDETAILS"] objectAtIndex:0];
    
    
    NSArray *cardarray = [TRANDETAILS elementsForName:@"TRANDETAIL"];
    
    NSMutableArray *resarray= [[NSMutableArray alloc] init];
    
    for (GDataXMLElement *user in cardarray) {
        
        TSLocation *model=[[TSLocation alloc] init];
        
        
        
        
        
        GDataXMLElement *AREANAM = [[user elementsForName:@"AREANAM"] objectAtIndex:0];
        [model setCountry:[AREANAM stringValue]];
        
        GDataXMLElement *AREACOD = [[user elementsForName:@"AREACOD"] objectAtIndex:0];
        [model setCode:[AREACOD stringValue]];
        
        
        
        [resarray addObject:model];
        
    }
    provinces = resarray;//[[_array reverseObjectEnumerator] allObjects];
    TSLocation*model=[provinces objectAtIndex:0];
    [self getcitycity:model.code];
}

-(void)getcitycity:(NSString *)code
{
    
    NSMutableArray *array=[[NSMutableArray alloc] init];
    [array addObject:@"TRANCODE"];
    [array addObject:FEEBACK_CMD_199032];
    
    [array addObject:@"PARCOD"];
    [array addObject:code ];
    
    
    NSString *paramXml=[CommonUtil createXml:array];
    NSString *PACKAGEMAC=[ValueUtils md5UpStr:paramXml];
    
    [array addObject:@"PACKAGEMAC"];
    [array addObject:PACKAGEMAC];
    
    NSString *params=[CommonUtil createXml:array];
    
    _controlCentral.requestController=self;
    [_controlCentral requestDataWithJYM:FEEBACK_CMD_199032
                             parameters:params
                     isShowErrorMessage:NO_TRADE_URL_TYPE
                             completion:^(id result, NSError *requestError, NSError *parserError) {
                                 if(ishidwait)
                                     [self hideWaiting];
                                 if (result)
                                 {
                                     GDataXMLElement *rootElement=(GDataXMLElement *)result;
                                     GDataXMLElement *TRANDETAILS = [[rootElement elementsForName:@"TRANDETAILS"] objectAtIndex:0];
                                     
                                     
                                     NSArray *cardarray = [TRANDETAILS elementsForName:@"TRANDETAIL"];
                                     NSMutableArray *resarray= [[NSMutableArray alloc] init];
                                     //[_array removeAllObjects];
                                     
                                     for (GDataXMLElement *user in cardarray) {
                                         
                                         TSLocation *model=[[TSLocation alloc] init];
                                         
                                         
                                         
                                         
                                         
                                         GDataXMLElement *AREANAM = [[user elementsForName:@"AREANAM"] objectAtIndex:0];
                                         [model setCountry:[AREANAM stringValue]];
                                         
                                         GDataXMLElement *AREACOD = [[user elementsForName:@"AREACOD"] objectAtIndex:0];
                                         [model setCode:[AREACOD stringValue]];
                                         
                                         
                                         
                                         [resarray addObject:model];
                                         
                                     }
                                     if(ishidwait)
                                         cities = resarray;//[[_array reverseObjectEnumerator] allObjects];
                                     else{
                                         locateView.cities=resarray;
                                         [locateView lodpickview];
                                         // cities1=resarray;
                                         
                                     }
                                 }
                             }];
    
}


//当用户按下return键或者按回车键，keyboard消失

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    [self hiddenKeyboard];
    
    return YES;
}


-(IBAction)hideKeyBoard:(id)sender{
    
    [self hiddenKeyboard];
}
-(void)hiddenKeyboard{
    
    //self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.textField resignFirstResponder];
    
    [self.textField1 resignFirstResponder];
    [self.textField2 resignFirstResponder];
    [self.textField3 resignFirstResponder];
    [self.textField4 resignFirstResponder];
    
}


-(void)sumitButton:(id)sender
{
    
    
    NSString *errMsg = nil;
    
    if ([CommonUtil strNilOrEmpty:_textField.text])
    {
        errMsg = @"请输入开户名!";
        [_textField becomeFirstResponder];
        
    }
    
    else if ([CommonUtil strNilOrEmpty:self.textField1.text])
    {
        errMsg = @"请选择城市!";
        [self.textField1 becomeFirstResponder];
        
    }
    else if ([CommonUtil strNilOrEmpty:self.textField2.text])
    {
        errMsg = @"请选择开户银行!";
        [self.textField2 becomeFirstResponder];
        
    }
    else if ([CommonUtil strNilOrEmpty:self.textField3.text])
    {
        errMsg = @"请选择银行网点！!";
        [self.textField3 becomeFirstResponder];
        
    }
    else if ([CommonUtil strNilOrEmpty:self.textField4.text])
    {
        errMsg = @"请输入银行卡号!";
        [self.textField4 becomeFirstResponder];
        
    }
    
    
    
    if(![CommonUtil strNilOrEmpty:errMsg])
        [self showAlert:errMsg];
    else
    {
        
        [self showWaiting:nil];
        [self saveInfo];
        
    }
}

-(void)saveInfo
{
    citybankId=@"";
    NSMutableArray *array=[[NSMutableArray alloc] init];
    NSString *phonerNumber=[_dataManager GetObjectWithNSUserDefaults:PHONENUMBER];
    [array addObject:@"TRANCODE"];
    [array addObject:MERCHANT_INFO_CMD_P77025];
    [array addObject:@"PHONENUMBER"];
    [array addObject:phonerNumber];
    [array addObject:@"USERNAME"];
    [array addObject:_name];
    [array addObject:@"IDNUMBER"];
    [array addObject:_number];
    [array addObject:@"MERNAME"];
    [array addObject:_shanghuname];
    [array addObject:@"SCOBUS"];
    [array addObject:_jyfw];
    [array addObject:@"MERADDRESS"];
    [array addObject:_jydz];
    [array addObject:@"BANKUSERNAME"];
    [array addObject:_textField.text];
    [array addObject:@"BANKAREA"];
    [array addObject:citycode];
    [array addObject:@"BIGBANKCOD"];
    [array addObject:bankId];
    [array addObject:@"BIGBANKNAM"];
    [array addObject:_bank_name];
    [array addObject:@"BANKCODE"];
    [array addObject:citybankId];
    [array addObject:@"BANKNAM"];
    [array addObject:_textField3.text];
    [array addObject:@"BANKACCOUNT"];
    [array addObject:_textField4.text];
    [array addObject:@"BANKNO"];
    [array addObject:bankNO];
    [array addObject:@"TERMID"];
    [array addObject:_xlh];
    [array addObject:@"PACKAGEMAC"];
    [array addObject:[ValueUtils md5UpStr:[CommonUtil createXml:array]]];
    
    NSString *params=[CommonUtil createXml:array];
    
    _controlCentral.requestController=self;
    [_controlCentral requestDataWithJYM:MERCHANT_INFO_CMD_P77025
                             parameters:params
                     isShowErrorMessage:TRADE_URL_TYPE
                             completion:^(id result, NSError *requestError, NSError *parserError) {
                                 
                                 [self hideWaiting];
                                 if (result)
                                 {
                                     [self pushview];
                                     
                                 }
                             }];
    
}


-(void)pushview
{
    
    SmrzThreeViewController *smrzThreeViewController=[[SmrzThreeViewController alloc] init];
    smrzThreeViewController.hidesBottomBarWhenPushed=YES;
    
    //    smrzThreeViewController.cityid=citycode;
    //    smrzThreeViewController.cityname=cityname;
    //    smrzThreeViewController.name=_name;
    //    smrzThreeViewController.number=_number;
    //    smrzThreeViewController.shanghuname=_shanghuname;
    //    smrzThreeViewController.jyfw=_jyfw;
    //    smrzThreeViewController.jydz=_jydz;
    //    smrzThreeViewController.khname=_textField.text;
    //    smrzThreeViewController.pcityname=provincename;
    //    smrzThreeViewController.pictyid=pcode;
    //    smrzThreeViewController.bankname=_textField2.text;
    //    smrzThreeViewController.bankId=bankId;
    //    smrzThreeViewController.citybankname=_textField3.text;
    //    smrzThreeViewController.citybankId=citybankId;
    //    smrzThreeViewController.cardnumber=_textField4.text;
    //    smrzThreeViewController.xlh=_xlh;
    [self.navigationController pushViewController:smrzThreeViewController animated:YES];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
