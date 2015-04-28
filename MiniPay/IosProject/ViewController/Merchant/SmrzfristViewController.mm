//
//  SmrzfristViewController.m
//  MiniPay
//
//  Created by apple on 14-5-9.
//  Copyright (c) 2014年 allen. All rights reserved.
//

#import "SmrzfristViewController.h"
#import "SmrztwoViewController.h"
#import "GDataXMLNode.h"
#import "DeviceTypeListViewController.h"
#import "divceModel.h"
//#import "MPosOperation.h"
#import <ExternalAccessory/ExternalAccessory.h>

@interface SmrzfristViewController ()
{
    NSMutableArray *nsarray;
    // EAAccessoryManager *eam;

}

@end

@implementation SmrzfristViewController
@synthesize accessoryList=_accessoryList;
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
    //self.title=@"基本信息(1/3)";
    [self setpageTitle:@"基本信息(1/3)"];
    self.textField.delegate = self;
    self.textField1.delegate = self;
    self.textField2.delegate = self;
    self.textField3.delegate = self;
    self.textField4.delegate = self;
    self.textField5.delegate=self;
    self.textField3.inputAccessoryView = _doneToolbar;
    _selectPicker.delegate = self;
    _selectPicker.dataSource = self;
    isclean=NO;
    [_doneToolbar setHidden:YES];
    pickerArray = [NSArray arrayWithObjects:@"服装", @"3c家电", @"美容化妆、健身养身", @"品牌直销",@"办公用品印刷",@"家居建材家具",@"商业服务、成人教育",@"生活服务", @"箱包皮具配饰",@"食品饮料烟酒零售",@"文化体育休闲玩意",@"杂货超市",@"餐饮娱乐、休闲度假",@"汽车、自行车",@"珠宝工艺、古董花鸟",@"彩票充值票务旅游",@"药店及医疗服务",@"物流、租赁",@"公益类", nil];
    // Do any additional setup after loading the view from its nib.
    [self set_Txet];
    [self showWaiting:@""];
    [self getdivicelist];

}

-(void)set_Txet
{
    _textField.text=_name;
    _textField1.text=_id_cid;
    _textField2.text=_mer_name;
    _textField3.text=_jyfw;
    _textField4.text=_address;
    _textField5.text=_TermNO;
    
}
-(IBAction)hideKeyBoard:(id)sender{
    
    [self hiddenKeyboard];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(_Is_Edit||textField==_textField5)
    {
        return NO;
    }
    if(textField==self.textField3)
    {
        
        _textField3.inputView = _selectPicker;
        [_doneToolbar setHidden:NO];
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
    
    
    return YES;
}

- (IBAction)selectButton:(id)sender {
    isclean=NO;
    [_textField3 endEditing:YES];
    [_doneToolbar setHidden:YES];
}

- (IBAction)cleanButton:(id)sender
{
    isclean=YES;
    [_textField3 endEditing:YES];
    
}

-(void)hiddenKeyboard{
    
    //self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.textField1 resignFirstResponder];
    [self.textField2 resignFirstResponder];
    [self.textField3 resignFirstResponder];
    [self.textField4 resignFirstResponder];
    
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [pickerArray count];
}
-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [pickerArray objectAtIndex:row];
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    
    NSInteger row = [_selectPicker selectedRowInComponent:0];
    if(!isclean&& textField==self.textField3)
    {
        _textField3.text=[pickerArray objectAtIndex:row];
    }
    self.view.frame =CGRectMake(0, kSystemVersion>=7.0?63:0, self.view.frame.size.width, self.view.frame.size.height);
}
-(IBAction)sumitButton:(id)sender
{
    NSString *errMsg = nil;
    
    if ([CommonUtil strNilOrEmpty:_textField.text])
    {
        errMsg = @"请输入申请人姓名!";
        [_textField becomeFirstResponder];
        
    }
    else if ([CommonUtil strNilOrEmpty:self.textField1.text])
    {
        errMsg = @"请输入身份证号!";
        [self.textField1 becomeFirstResponder];
        
    }
    // else if (![CommonUtil chk18PaperId:self.textField1.text])
    else if (self.textField1.text.length<18)
        
    {
        errMsg = @"请输入合法身份证号!";
        [self.textField1 becomeFirstResponder];
        
    }
    else if ([CommonUtil strNilOrEmpty:self.textField2.text])
    {
        errMsg = @"请输入商户名称!";
        [self.textField2 becomeFirstResponder];
        
    }
    else if ([CommonUtil strNilOrEmpty:self.textField3.text])
    {
        errMsg = @"请选择经营范围!";
        //[self.textField becomeFirstResponder];
        
    }
    else if ([CommonUtil strNilOrEmpty:self.textField4.text])
    {
        errMsg = @"请输入经营地址!";
        [self.textField4 becomeFirstResponder];
        
    }
    else if ([CommonUtil strNilOrEmpty:self.textField5.text])
    {
        errMsg = @"请输入机器序列号!";
        [self.textField4 becomeFirstResponder];
    }
    
    
    if(![CommonUtil strNilOrEmpty:errMsg])
        [self showAlert:errMsg];
    else
    {
        
        if(_Is_Edit)
            [self pushview];
        else
        {
            [self showWaiting:nil];
            //获取商户信息
            [self getTermNO];
        }
        
    }
}


-(void)pushview
{
    SmrztwoViewController *smrztwoViewController=[[SmrztwoViewController alloc] init];
    smrztwoViewController.hidesBottomBarWhenPushed=YES;
    smrztwoViewController.name=_textField.text;
    smrztwoViewController.number=_textField1.text;
    smrztwoViewController.shanghuname=_textField2.text;
    smrztwoViewController.jyfw=_textField3.text;
    smrztwoViewController.jydz=_textField4.text;
    smrztwoViewController.xlh=_textField5.text;
    
    
    
    smrztwoViewController.kaihu_name=_kaihu_name;
    smrztwoViewController.kaihu_address_p=_kaihu_address_p;
    smrztwoViewController.kaihu_address_s=_kaihu_address_s;
    smrztwoViewController.kaihu_addresscode=_kaihu_addresscode;
    smrztwoViewController.bank_name=_bank_name;
    smrztwoViewController.bank_code=_bank_code;
    smrztwoViewController.bank_address=_bank_address;
    smrztwoViewController.card_NO=_card_NO;
    smrztwoViewController.Is_Edit=_Is_Edit;
    smrztwoViewController.bank_No=_bank_NO;
    smrztwoViewController.bank_showname=_bank_showname;

    
    [self.navigationController pushViewController:smrztwoViewController animated:YES];
    
}


-(void)getTermNO
{
    NSMutableArray *array=[[NSMutableArray alloc] init];
    NSString *phonerNumber=[_dataManager GetObjectWithNSUserDefaults:PHONENUMBER];
    [array addObject:@"TRANCODE"];
    [array addObject:MERCHANT_INFO_CMD_P77024];
    [array addObject:@"TERMID"];
    [array addObject:_textField5.text];
    
    [array addObject:@"PACKAGEMAC"];
    [array addObject:[ValueUtils md5UpStr:[CommonUtil createXml:array]]];
    
    NSString *params=[CommonUtil createXml:array];
    
    _controlCentral.requestController=self;
    [_controlCentral requestDataWithJYM:MERCHANT_INFO_CMD_P77024
                             parameters:params
                     isShowErrorMessage:TRADE_URL_TYPE
                             completion:^(id result, NSError *requestError, NSError *parserError) {
                                 
                                 [self hideWaiting];
                                 if (result)
                                 {
                                     GDataXMLElement *rootElement=(GDataXMLElement *)result;
                                     
                                     GDataXMLElement *TERMTYPE = [[rootElement elementsForName:@"TERMTYPE"] objectAtIndex:0];
                                     NSString *postype=[TERMTYPE stringValue];
                                     if([postype isEqualToString:@"VPOS"])
                                     {
                                         [CommonUtil savepostype:[NSString stringWithFormat:@"%d",Vpos]];
                                         _dataManager.device_Type=Vpos;
                                     }
                                     
                                     else if([postype isEqualToString:@"支付通-QPOS"])
                                     {
                                         [CommonUtil savepostype:[NSString stringWithFormat:@"%d",Qpos]];
                                         _dataManager.device_Type=Qpos;
                                     }
                                     
                                     else if([postype isEqualToString:@"D180蓝牙POS"])
                                     {
                                         [CommonUtil savepostype:[NSString stringWithFormat:@"%d",D180]];
                                         _dataManager.device_Type=D180;

                                      }
                                     else if([postype isEqualToString:@"QPOS3.0"])
                                     {
                                         [CommonUtil savepostype:[NSString stringWithFormat:@"%d",Qpos_blue]];
                                         _dataManager.device_Type=Qpos_blue;
                                         
                                     }
                                     else if([postype isEqualToString:@"BBPOS-刷卡头"])
                                     {
                                         [self showAlert:@"当前应用不支当前设备！"];
                                         return;

                                         
                                     }
                                     
                                     else if([postype isEqualToString:@"SKTPOS"])
                                     {
                                         [self showAlert:@"当前应用只支持当前设备！"];
                                         return;
                                     }
                                     else
                                     {
                                         [self showAlert:@"当前应用只支持当前设备！"];
                                         return;
                                     }
                                     
                                     [self pushview];
                                     
                                 }
                             }];
    
}



-(void)getdivicelist
{
    
    NSMutableArray *array=[[NSMutableArray alloc] init];
    [array addObject:@"TRANCODE"];
    [array addObject:MERCHANT_INFO_CMD_300143];
    NSDictionary* infoDict =[[NSBundle mainBundle] infoDictionary];
    // NSString* versionNum =[infoDict objectForKey:@"CFBundleVersion"];
    NSString*appName =[infoDict objectForKey:@"CFBundleDisplayName"];
    
    
    [array addObject:@"name"];
    
    [array addObject:appName];
//    switch ([DataManager sharedDataManager].postype_Vison) {
//        case wfb:
//        
//            break;
//            
//        case cyh:
//            [array addObject:@"name"];
//            
//            [array addObject:@"畅意汇"];
//            break;
//        case xft:
//        [array addObject:@"name"];
//        
//        [array addObject:@"携宝通"];
//        break;
//        case hf:
//        [array addObject:@"name"];
//        
//        [array addObject:@"挥付商务"];
//        break;
//        case hfb:
//        [array addObject:@"name"];
//        
//        [array addObject:@"华付宝"];
//        break;
//        case lxzf:
//        [array addObject:@"name"];
//        
//        [array addObject:@"联迅支付"];
//        break;
//        case mf:
//        [array addObject:@"name"];
//        
//        [array addObject:@"米付宝"];
//        break;
//        default:
//            [array addObject:@"name"];
//            
//            [array addObject:@"微付宝"];
//            break;
//            break;
//    }
    
    
    [array addObject:@"PACKAGEMAC"];
    [array addObject:[ValueUtils md5UpStr:[CommonUtil createXml:array]]];
    
    NSString *params=[CommonUtil createXml:array];
    
    _controlCentral.requestController=self;
    [_controlCentral requestDataWithJYM:MERCHANT_INFO_CMD_300143
                             parameters:params
                     isShowErrorMessage:TRADE_URL_TYPE
                             completion:^(id result, NSError *requestError, NSError *parserError) {
                                 
                                 [self hideWaiting];
                                 if (result)
                                 {
                                     GDataXMLElement *rootElement=(GDataXMLElement *)result;
                                     
                                     GDataXMLElement *trandetailsElement = [[rootElement elementsForName:@"TRANDETAILS"] objectAtIndex:0];
                                     
                                     NSArray*  trandetail = [trandetailsElement elementsForName:@"TRANDETAIL"];
                                     // NSMutableArray *
                                     nsarray=[[NSMutableArray alloc] init];
                                     //AllMenuItems=[[NSMutableArray alloc] init];
                                     for (GDataXMLElement *arry in trandetail) {
                                         
                                         
                                         divceModel *model=[[divceModel alloc] init];
                                         
                                         
                                         GDataXMLElement *PICTURE = [[arry elementsForName:@"PICTURE"] objectAtIndex:0];
                                         [model setPICTURE:[PICTURE stringValue]];
                                         
                                         GDataXMLElement *TRMMODNO = [[arry elementsForName:@"TRMMODNO"] objectAtIndex:0];
                                         [model setTRMMODNO:[TRMMODNO stringValue]];
                                         
                                         GDataXMLElement *TXNCD = [[arry elementsForName:@"TXNCD"] objectAtIndex:0];
                                         [model setTXNCD:[TXNCD stringValue]];
                                         
                                         [nsarray addObject:model];
                                     }
                                     
                                     //                                     AllMenuItems= [[array reverseObjectEnumerator] allObjects];
                                     
                                 }
                             }];
    
    
}

//当用户按下return键或者按回车键，keyboard消失

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    [self hiddenKeyboard];
    
    return YES;
}


- (IBAction)selectdivce:(id)sender
{
    if(_Is_Edit)
    {
        return;
    }
    
    //    NSArray * AllMenuItems= [[DataManager sharedDataManager].seetingdict objectForKey:@"divcelist"];
    //[self showWaiting:@""];
    if(nsarray.count>1)
    {
        DeviceTypeListViewController *deviceTypeListViewController=[[DeviceTypeListViewController alloc]initWithNibName:@"DeviceTypeListViewController" bundle:nil resorearry:nsarray];
        
        deviceTypeListViewController.okBlock=^(NSString*str)
        {
            [self Creatdcvice];
        };
        // [self presentModalViewController:deviceTypeListViewController animated:YES];
        [self.navigationController pushViewController:deviceTypeListViewController animated:YES];
        return;
    }
    else
    {
        // NSDictionary * itemdict=[AllMenuItems objectAtIndex:0];
        divceModel *model=[nsarray objectAtIndex:0];
        // NSString* devicetypeid=[itemdict objectForKey:@"TRMMODNO"];
        NSString* devicetypeid=model.TRMMODNO;
        
        if([devicetypeid isEqualToString:@"VPOS"])
        {
            _dataManager.device_Type=Vpos;
        }
        else if([devicetypeid isEqualToString:@"支付通-QPOS"])
        {
            _dataManager.device_Type=Qpos;
        }
        else if([devicetypeid isEqualToString:@"QPOS3.0"])
        {
            _dataManager.device_Type=Qpos_blue;
        }
        
        else if([devicetypeid isEqualToString:@"D180蓝牙POS"])
        {
            _dataManager.device_Type=D180;
        }
        [self Creatdcvice];
    }
    //[self presentModalViewController:deviceTypeListViewController animated:YES];
}


-(void)Creatdcvice
{
    
    switch (_dataManager.device_Type) {
            
       case Vpos:
            m_vcom = [vcom getInstance];
            [m_vcom open];
            [m_vcom setMode:VCOM_TYPE_FSK recvMode:VCOM_TYPE_F2F]; //设置数据发送模式和接收模式
            [m_vcom setMac:FALSE];
            m_vcom.eventListener=self;
            [self showWaiting:@"请插入设备……"];
            break;
        case Qpos:
            [ZftQiposLib setContectType:0];
           [[ZftQiposLib getInstance]setLister:self];
            [self showWaiting:@"请插入设备……"];
            break;
        case Qpos_blue:
            [ZftQiposLib setContectType:1];
            [[ZftQiposLib getInstance]setLister:self];
            devicList=[[NSMutableArray alloc]init];
            
            //[self showWaiting:@"请链接蓝牙……"];
            [self getdivceno];
            break;
        case D180:
//            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(accessoryConnected:) name:EAAccessoryDidConnectNotification object:nil];
//            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(accessoryDisConnected:) name:EAAccessoryDidDisconnectNotification object:nil];
//            eam = [EAAccessoryManager sharedAccessoryManager];
//            _accessoryList = [[NSMutableArray alloc] initWithArray: [eam connectedAccessories]];
//            selectedBTMac = @"00:00:00:00:00:00";
//            if (_accessoryList.count > 0) {
//                selectedBTMac = [_accessoryList[0] valueForKey:@"macAddress"];
//            }
//            opq = [[NSOperationQueue alloc] init];
//            [opq setMaxConcurrentOperationCount:3];
//            op = [[MPosOperation alloc] initWithType:OPER_START withName:@"start" withArgNum:1 withArgs:[[NSArray alloc] initWithObjects:selectedBTMac, nil] withDelegate:mPosOperationDelegate];
//            [opq addOperation:op];
//             op.delegate=self;
           // [self showWaiting:@"请插入设备……"];
            [self getdivceno];
            break;
        default:
            
            
            
            break;
    }
    //    [self getDeviceNO];
    
    
}


-(void) onDevicePlugged
{
    [self performSelector:@selector(getdivceno) withObject:nil afterDelay:0.6];
    
}

-(void)EDYonPlugin
{
     [self performSelector:@selector(getdivceno) withObject:nil afterDelay:0.6];
}

-(void)getdivceno
{
    [self getDeviceNO];
}

-(void)EDYonError:(NSString*)errmsg{
    [self hideAllView];
    [self showAlert:@"获取终端信息失败，请检查麦克风是否容许当前应用！"];
}
-(void)EDYGet55Message:(NSString *) message{}

- (void)onError:(int)errorCode ErrorMessage:(NSString *)errorMessage{
    [self hideAllView];
    [self showAlert:@"获取终端信息失败，请检查麦克风是否容许当前应用！"];

}

-(void)dataArrive:(vcom_Result *)vs Status:(int)_status{
    
    DLog(@"======identify======%d",_identify);
    [m_vcom StopRec];
    
    if(_status==-3){
        //设备没有响应
        [self hideAllView];
        //        [self hideCheckPos];
        //        [self hideSwipCard];
        //        [self hideTrading];
        [self showAlert:@"设备无响应"];
    }else if(_status == -2){
        //耳机没有插入
        [self hideAllView];
        //        [self hideCheckPos];
        //        [self hideSwipCard];
        [self showAlert:@"请插入刷卡器"];
    }else if(_status==-1){
        //接收数据的格式错误
        [self hideAllView];
        //        [self hideCheckPos];
        //        [self hideSwipCard];
        //        [self hideTrading];
        [self showAlert:@"接收数据的格式错误"];
    }else {
        //操作指令正确
        if(vs->res==0){
            
                termialNo=[NSString stringWithFormat:@"%s",BinToHex(vs->hardSerialNo, 0, vs->hardSerialNoLen)];
                [self performSelector:@selector(hidview) withObject:nil afterDelay:0.6];
                _textField5.text=termialNo;
                
        
        }
    }
}


-(void)EDYgetTerminalID:(NSString *)terminalId
{
    [self performSelector:@selector(hidview) withObject:nil afterDelay:0.6];
    _textField5.text=terminalId;
}


- (void)taskFinishedWithResult:(NSString *)result{
    if ([result isEqualToString:@"通讯错误"])
    {
        [self showAlert:@"未找到适配的蓝牙设备，请到设置页面检查设备蓝牙是否已匹配？匹配完成后重新启动应用！"];
        [self hideAllView];
        return;
    }
    
    
    [self performSelector:@selector(hidview) withObject:nil afterDelay:0.6];
    _textField5.text=result;

}



-(void)hidview
{
    [self hideAllView];
}
//
//- (void)accessoryConnected:(NSNotification *)notification
//{
//    EAAccessory *connectedAccessory = [[notification userInfo] objectForKey:EAAccessoryKey];
//    
//    NSLog(@"accessory connected! mac is : %@", [connectedAccessory valueForKey:@"macAddress"]);
//    EAAccessory *ea;
//    BOOL found = NO;
//    for (ea in _accessoryList) {
//        if ([[connectedAccessory valueForKey:@"macAddress"] isEqualToString: [ea valueForKey:@"macAddress"]]) {
//            found = YES;
//            NSLog(@"found in accesory list");
//            break;
//        }
//    }
//    
//    if (!found) {
//        [_accessoryList addObject:connectedAccessory];
//        NSLog(@"added to accessory list");
//        // FIXME! refresh view
//        //[_btPicker reloadAllComponents];
//    }
//    
//}
//
//- (void)accessoryDisConnected:(NSNotification *)notification
//{
//    EAAccessory *disconnectedAccessory = [[notification userInfo] objectForKey:EAAccessoryKey];
//    
//    NSLog(@"accessory disconnected! mac is : %@", [disconnectedAccessory valueForKey:@"macAddress"]);
//    EAAccessory *ea;
//    NSInteger idx = 0;
//    BOOL found = NO;
//    for (ea in _accessoryList) {
//        if ([[disconnectedAccessory valueForKey:@"macAddress"] isEqualToString: [ea valueForKey:@"macAddress"]]) {
//            found = YES;
//            NSLog(@"found in accessory list");
//            break;
//        }
//        idx++;
//    }
//    
//    if (found) {
//        NSLog(@"to remove it from the accessory list");
//        [_accessoryList removeObjectAtIndex:idx];
//    }
//    
//    // FIXME! refresh view
//    //[_btPicker reloadAllComponents];
//}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
