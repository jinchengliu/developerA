//
//  MobilePhoneRechargeViewController.m
//  MiniPay
//
//  Created by apple on 14-5-16.
//  Copyright (c) 2014年 allen. All rights reserved.
//

#import "MobilePhoneRechargeViewController.h"
#import "PwdAllertViewController.h"
#import "NormalQuestionViewController.h"
#import "FeeBackViewController.h"
#import "BMFlowerViewController.h"
@interface MobilePhoneRechargeViewController ()
{

  PwdAllertViewController *pwdAllertViewController;
    BOOL isclean;
     NSString *RandomNumber;
    
    /** 导航栏 按钮 加号 图片 */
    UIImageView *_plusIV;
    
    /** 是否已打开抽屉 */
    BOOL _isOpen;
    
    /** 抽屉视图 */
    ACNavBarDrawer *_drawerView;
}

@end

@implementation MobilePhoneRechargeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)goToPhoneBook{
    
//    ABPeoplePickerNavigationController* picker =
//    [[ABPeoplePickerNavigationController alloc] init];
//    picker.peoplePickerDelegate = self; // note: not merely "delegate"
//    //self.myPhoneBook = picker;
//    //[picker setDisplayedProperties:[NSArray arrayWithObject:NUMBER(kABPersonPhoneProperty)]];
//    picker.displayedProperties = [NSArray arrayWithObject: [NSNumber numberWithInt: kABPersonPhoneProperty]];
//    [self presentModalViewController:picker animated:YES];
  
}



#pragma mark phone book delegate
-(BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person {
    return YES;
}

-(BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
    
    ABMultiValueRef phoneProperty = ABRecordCopyValue(person,kABPersonPhoneProperty);
    int idx = ABMultiValueGetIndexForIdentifier (phoneProperty, identifier);
    NSString *phoneNumber = (__bridge NSString *)ABMultiValueCopyValueAtIndex(phoneProperty,idx);
    NSString* name = (__bridge NSString*)ABRecordCopyCompositeName(person);
    int numberCount = ABMultiValueGetCount(phoneProperty);//号码类型个数
    
    
   
    [self dismissModalViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"phoneBookDimssForQrModule" object:nil];
    return NO;
}

-(void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker {
    
    [self dismissModalViewControllerAnimated:YES];
    //电子货币模块浏览器以addsubview 加入 退出时强制改变控件Frame
    [[NSNotificationCenter defaultCenter] postNotificationName:@"phoneBookDimssForQrModule" object:nil];
    
}




- (IBAction)selectMoblephone:(id)sender
{

   
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setpageTitle:@"手机充值"];
    //self.title=@"手机充值";
         pickerArray = [NSArray arrayWithObjects:@"50",@"100",@"200",@"300",nil];
        _selectPicker.frame = CGRectMake(0, 480, 320, 216);
        self.textField1.delegate = self;
        _selectPicker.delegate = self;
       _selectPicker.dataSource = self;
       _textField.delegate=self;
    //
     self.textField1.inputAccessoryView = _doneToolbar;
       isclean=NO;
     [_doneToolbar setHidden:YES];

    // Do any additional setup after loading the view from its nib.
}



- (IBAction)selectButton:(id)sender {
    isclean=NO;
    [_textField1 endEditing:YES];
    [_doneToolbar setHidden:YES];
    
}

- (IBAction)cleanButton:(id)sender
{
    [_textField1 endEditing:YES];
    isclean=YES;
    
    
}


-(IBAction)hideKeyBoard:(id)sender{
    
    [self hiddenKeyboard];
}
-(void)hiddenKeyboard{
    
    //self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.textField1 resignFirstResponder];
   
    [self.textField resignFirstResponder];
    
}
//当用户按下return键或者按回车键，keyboard消失

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    //textField
    
    return YES;
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
    
    if(!isclean)
    {
        _textField1.text = [NSString stringWithFormat:@"¥%@元", [pickerArray objectAtIndex:row]] ;
        
        tmpMoney=[NSString stringWithFormat:@"%d",(int)([[pickerArray objectAtIndex:row] floatValue]*100)];
        NSMutableString *tmp=[[NSMutableString alloc] init];
        //若不够12位前面补0
        for(int i=0;i<(12-[tmpMoney length]);i++){
            [tmp appendString:@"0"];
            
        }
        [tmp appendString:tmpMoney];
        tradeMoney=tmp;
       tmpMoney1=tradeMoney;
        
    }
   
    
    //[self hiddenKeyboard];
    self.view.frame =CGRectMake(0, kSystemVersion>=7.0?63:0, self.view.frame.size.width, self.view.frame.size.height);
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    if(textField==_textField1)
    {
        _textField1.inputView = _selectPicker;
        [_doneToolbar setHidden:NO];
        
    }
    
    
    
    return YES;
}


- (IBAction)okButton:(id)sender
{
    NSString *errMsg = nil;
    
    if ([CommonUtil strNilOrEmpty:self.textField.text])
    {
        errMsg = @"请输入手机号!";
        [self.textField becomeFirstResponder];
        
    }
    else if (_textField.text.length<11)
    {
        errMsg = @"请输入正确手机号！";
        [self.textField becomeFirstResponder];
    }
    else if ([CommonUtil strNilOrEmpty:self.textField1.text])
    {
        errMsg = @"请选择充值金额！";
        [self.textField1 becomeFirstResponder];
        
    }
    
    if(![CommonUtil strNilOrEmpty:errMsg])
        [self showAlert:errMsg];
    else
    {
        
        UIAlertView*alert=[[UIAlertView alloc] initWithTitle:@"充值提示" message:[NSString stringWithFormat:@"手机号为:%@.\n充值金额:%@.\n确定充值吗？",_textField.text,_textField1.text] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
        
        
    }
    
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(buttonIndex!=alertView.cancelButtonIndex){
        
        if(alertView.tag==1000)
        {
            NSString *str=[[DataManager sharedDataManager].seetingdict objectForKey:@"tellphone"];
            
            NSMutableString *phonenumber= [[NSMutableString alloc]initWithString:str];
            NSRange range = NSMakeRange(0, [phonenumber length]);
            [phonenumber replaceOccurrencesOfString:@"-" withString:@"" options:NSCaseInsensitiveSearch range:range];
            
            [CommonUtil callPhoneNumber: phonenumber];
            return;
            
        }
        
               [self checkIsSign];
        
    }
}


//D180刷卡
-(void)d180SwipCard{
    
    //[self showTrading];
    
    NSString *psamHex=[AESUtil hexStringFromString:[[pasamNo substringWithRange:NSMakeRange(2, [pasamNo length]-2)] dataUsingEncoding:NSUTF8StringEncoding]];
    
    macMeta=[NSString stringWithFormat:@"%@%@%@%@%@%@",SEARCH_BLANCE_CMD_708111,tradeMoney,tseqno,nowTime,nowDate,psamHex];
    op = [[MPosOperation alloc] initWithType:OPER_GET_MAC withName:@"getmac" withArgNum:1 withArgs:[[NSArray alloc] initWithObjects:macMeta, nil] withDelegate:mPosOperationDelegate];
    [opq addOperation:op];
     _D180identify=4;
    
}


//发送刷卡请求，查询余额
-(void)finishSwipCard{
    
    [self showTrading];
    
    DLog(@"===========开始计算mac……");
    
    NSString *psamHex=[AESUtil hexStringFromString:[[pasamNo substringWithRange:NSMakeRange(2, [pasamNo length]-2)] dataUsingEncoding:NSUTF8StringEncoding]];
    
    macMeta=[NSString stringWithFormat:@"%@%@%@%@%@%@",SEARCH_BLANCE_CMD_708111,tradeMoney,tseqno,nowTime,nowDate,psamHex];
    
    //获取mac
    [self getMac:macMeta];
    
    
    
}


//Qpos刷卡
-(void)qPosSwipCard{
    NSString *psamHex=[AESUtil hexStringFromString:[[pasamNo substringWithRange:NSMakeRange(2, [pasamNo length]-2)] dataUsingEncoding:NSUTF8StringEncoding]];
    
    macMeta=[NSString stringWithFormat:@"%@%@%@%@%@%@",SEARCH_BLANCE_CMD_708111,tradeMoney,tseqno,nowTime,nowDate,psamHex];
    
    
    
    
    DLog(@"Qpos mac加密前======%@",macMeta);
     [[ZftQiposLib getInstance] doTradeEx:tmpMoney andType:1 andRandom:nil andextraString:macMeta andTimesOut:60];
    
}



-(void)onDecodeCompleted:(NSString*) formatID
                  andKsn:(NSString*) ksn
            andencTracks:(NSString*) encTracks
         andTrack1Length:(int) track1Length
         andTrack2Length:(int) track2Length
         andTrack3Length:(int) track3Length
         andRandomNumber:(NSString*) randomNumber
            andMaskedPAN:(NSString*) maskedPAN
           andExpiryDate:(NSString*) expiryDate
       andCardHolderName:(NSString*) cardHolderName{
    NSLog(@"回调函数接受返回数据");
    NSLog(@"ksn %@" ,ksn);
    NSLog(@"encTracks %@" ,encTracks);
    NSLog(@"track1Length %i",track1Length);
    NSLog(@"track2Length %i",track2Length);
    NSLog(@"track3Length %i",track3Length);
    NSLog(@"randomNumber %@",randomNumber);
    NSLog(@"maskedPAN %@",maskedPAN);
    NSLog(@"expiryDate %@",expiryDate);
    NSString* string =[[NSString alloc] initWithFormat:@"ksn:%@ encTracks:%@ \n track1Length:%i \n track2Length:%i \n track3Length:%i \n randomNumber:%@ \n maskedPAN:%@ \n expiryDate:%@",ksn,encTracks,track1Length,track2Length,track3Length,randomNumber,maskedPAN,expiryDate];
    //string = [NSString initWithFormat:@"%@,%@", ksn, ksn ];
    NSLog(@"%@",string);
    [self hideAllView];
    RandomNumber=randomNumber;
    termialNo=ksn;
    pasamNo=ksn;
    macEncrypt=@"";
    
    if(_dataManager.device_Type==SKTPOS)
    {
        pwdAllertViewController = [[PwdAllertViewController alloc] initWithNibName:@"PwdAllertViewController" bundle:nil cardNo:maskedPAN];
        // pwdAllertViewController.lableNo.text=maskedPAN;
        pwdAllertViewController.hidViewBlock=^(void){
            [pwdAllertViewController.view removeFromSuperview];
            pwdAllertViewController=nil;
        };
        pwdAllertViewController.okBlock=^(NSString*str)
        {
            [self hideAllView];
            [self showTrading];
            [pwdAllertViewController.view removeFromSuperview];
            pwdAllertViewController=nil;
            trackInfo=encTracks;
            pinInfo=[AESUtil encrypt:str password:[ValueUtils md5UpStr:AES_PWD]];
            [self finishGetMac];
        };
        //   // [self presentViewController:pwdAllertViewController animated:YES completion:nil];
        [pwdAllertViewController showControllerByAddSubView:self animated:NO];
        //m_recvData.text= m_con;
    }
    
}

//交易请求
-(void)finishGetMac{
    
    [self showTrading];
    
    NSMutableArray *array=[[NSMutableArray alloc] init];
    
    [array addObject:@"TRANCODE"];
    [array addObject:SEARCH_BLANCE_CMD_708111];
    
    if(_dataManager.device_Type==SKTPOS)
    {
        [array addObject:@"POSTYPE_B"];
        [array addObject:@"2"];
        [array addObject:@"RAND_B"];
        [array addObject:RandomNumber];
    }
    else
    {
        [array addObject:@"POSTYPE_B"];
        [array addObject:@"1"];
        [array addObject:@"RAND_B"];
        [array addObject:@""];
        
        [array addObject:@"TSeqNo_B"];
        [array addObject:tseqno];
        
        [array addObject:@"TTxnTm_B"];
        [array addObject:nowTime];
        
        [array addObject:@"TTxnDt_B"];
        [array addObject:nowDate];
    }
    
    [array addObject:@"TERMINALNUMBER_B"];
    [array addObject:pasamNo];
    [array addObject:@"CHECKX_B"];  //交易经度
    [array addObject:_dataManager.latitude];

    [array addObject:@"CHECKY_B"];  //交易纬度
    [array addObject:_dataManager.longitude];

    
    [array addObject:@"SELLTEL_B"];
    [array addObject:phonerNumber];
    
    [array addObject:@"phoneNumber_B"];
    [array addObject:_textField.text];
    
    [array addObject:@"Track2_B"];
    [array addObject:trackInfo];
    
    [array addObject:@"TXNAMT_B"];
    [array addObject:tradeMoney];
    
    
    [array addObject:@"CRDNOJLN_B"];
    [array addObject:pinInfo];
    
    [array addObject:@"MAC_B"]; //mac
    [array addObject:macEncrypt];
    
    NSString *paramXml=[CommonUtil createXml:array];
    NSString *PACKAGEMAC=[ValueUtils md5UpStr:paramXml];
    
    [array addObject:@"PACKAGEMAC"];
    [array addObject:PACKAGEMAC];
    
    NSString *params=[CommonUtil createXml:array];
    _controlCentral.requestController=self;
    [_controlCentral requestDataWithJYM:SEARCH_BLANCE_CMD_708111
                             parameters:params
                     isShowErrorMessage:TRADE_URL_TYPE
                             completion:^(id result, NSError *requestError, NSError *parserError) {
                                 [self hideAllView];
                                 if (result)
                                 {
                                     [self showAlert:@"充值成功！"];
                                     [self.navigationController popViewControllerAnimated:YES];
                                 }
                             }];
    
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
 
    //** barButton *********************************************************************************
    CGFloat navRightBtn_w = 40.f;
    CGFloat navRightBtn_h = 30.f;
    CGFloat navRightBtn_x = App_Frame_Width - 10.f;
    CGFloat navRightBtn_y = (kTopBarHeight - navRightBtn_h) / 2.f;
    
    UIButton *navRightBtn = [[UIButton alloc] init];
    [navRightBtn setFrame:CGRectMake(navRightBtn_x,
                                     navRightBtn_y,
                                     navRightBtn_w,
                                     navRightBtn_h)];
    
    // 按钮背景图片
    //UIImage *navRightBtnBGImg = PNGIMAGE(@"nav_btn");
    //[navRightBtn setBackgroundImage:navRightBtnBGImg forState:UIControlStateNormal];
    
    
    //-- 按钮上的图片 --------------------------------------------------------------------------------
    CGFloat plusIV_w = 20.f;
    CGFloat plusIV_h = 20.f;
    CGFloat plusIV_x = (navRightBtn.bounds.size.width - plusIV_w) / 2.f;
    CGFloat plusIV_y = (navRightBtn.bounds.size.height - plusIV_h) / 2.f;
    
    _plusIV = [[UIImageView alloc] initWithImage:PNGIMAGE(@"nav_plus")];
    [_plusIV setFrame:CGRectMake(plusIV_x,
                                 plusIV_y,
                                 plusIV_w,
                                 plusIV_h)];
    
    [navRightBtn addSubview:_plusIV];
    
    // 设置按钮点击时调用的方法
    [navRightBtn addTarget:self action:@selector(navPlusBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:navRightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
    //** 抽屉 *******************************************************************************
    
    //-- 按钮信息 -------------------------------------------------------------------------------
    // 就不建数据对象了，第一个为图片名、第二个为按钮名
    NSArray *item_01 = [NSArray arrayWithObjects:@"acnavicon01", @"用户帮助", nil];
    NSArray *item_02 = [NSArray arrayWithObjects:@"acnavicon02", @"充值记录", nil];
    NSArray *item_03 = [NSArray arrayWithObjects:@"acnavicon03", @"客服热线", nil];
    NSArray *item_04 = [NSArray arrayWithObjects:@"acnavicon04", @"意见反馈", nil];
    
    // 最好是 2-5 个按钮，1个很2，5个以上很丑
    NSArray *allItems = [NSArray arrayWithObjects:item_01,item_02,item_03, item_04, nil];
    
    _drawerView = [[ACNavBarDrawer alloc] initWithView:self.view andItemInfoArray:allItems];
    _drawerView.delegate = self;
    
    
    
    //
    //    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //
    //    rightButton.frame = CGRectMake(0, 0, 20, 20);
    //    [rightButton setBackgroundImage:[UIImage imageNamed:@"help"]
    //                           forState:UIControlStateNormal];
    //
    //    [rightButton addTarget:self
    //                    action:@selector(help)
    //          forControlEvents:UIControlEventTouchUpInside];
    //
    //    item = [[UIBarButtonItem alloc]
    //            initWithCustomView:rightButton];
    //    self.navigationItem.rightBarButtonItem = item;
    
    
    
}




-(void)theBtnPressed:(UIButton *)theBtn
{
    NSInteger btnTag = theBtn.tag;
    
    NSInteger btnNumber = btnTag + 1;
    
    DLog(@"按钮%d被点击", btnNumber);
    
    switch (theBtn.tag)
    {
        case 0:
        {
            [self help];
        }
            break;
            
        case 1:
        {
            BMFlowerViewController *bMFlowerViewController=[[BMFlowerViewController alloc] init];
           // bMFlowerViewController.hidesBottomBarWhenPushed=YES;
            bMFlowerViewController.bm_Type=2;
            
            [self.navigationController pushViewController:bMFlowerViewController animated:YES];
            
        }
            break;
            
        case 2:
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"联系客服" message:[NSString stringWithFormat:@"确定拨打%@",[[DataManager sharedDataManager].seetingdict objectForKey:@"tellphone"]] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alert.tag=1000;
            [alert show];
            
        }
            break;
            
        case 3:
        {
            FeeBackViewController *feeBack=[[FeeBackViewController alloc] init];
            feeBack.hidesBottomBarWhenPushed=YES;
            
            [self.navigationController pushViewController:feeBack animated:YES];

        }
            break;
            
        default:
            break;
    }
    
    // 点完按钮，旋回加号图片
    [self rotatePlusIV];
}




-(void)theBGMaskTapped
{
    // 触摸背景遮罩时，需要通过回调，旋回加号图片
    [self rotatePlusIV];
}





- (void)navPlusBtnPressed:(UIButton *)sender
{
    // 如果是关，则开，反之亦然
    if (_drawerView.isOpen == NO)
    {
        [_drawerView openNavBarDrawer];
    }
    else
    {
        [_drawerView closeNavBarDrawer];
    }
    
    [self rotatePlusIV];
}

#pragma mark - Rotate _plusIV

- (void)rotatePlusIV
{
    // 旋转加号按钮
    float angle = _drawerView.isOpen ? -M_PI : 0.0f;
    [UIView animateWithDuration:0.2f animations:^{
        _plusIV.transform = CGAffineTransformMakeRotation(angle);
    }];
}

-(void)help
{
    
    NormalQuestionViewController *question=[[NormalQuestionViewController alloc] init];
    // question.hidesBottomBarWhenPushed=YES;
    question.url_type=chongzhi;
    [self.navigationController pushViewController:question animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
