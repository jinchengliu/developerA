//
//  KakazhuanzhangViewController.m
//  MiniPay
//
//  Created by apple on 14-5-27.
//  Copyright (c) 2014年 allen. All rights reserved.
//

#import "KakazhuanzhangViewController.h"
#import "PwdAllertViewController.h"
#import "BankMassage.h" 
#import "NormalQuestionViewController.h"
#import "FeeBackViewController.h"
#import "BMFlowerViewController.h"
@interface KakazhuanzhangViewController ()
{
    PwdAllertViewController *pwdAllertViewController;
    BOOL isclean;
    NSMutableArray* reversedArray;
     NSArray *pickerArray;
     NSString *RandomNumber;
    NSString *tradeMoney;
    NSString*type;
    
    /** 导航栏 按钮 加号 图片 */
    UIImageView *_plusIV;
    
    /** 是否已打开抽屉 */
    BOOL _isOpen;
    
    /** 抽屉视图 */
    ACNavBarDrawer *_drawerView;

}

@end

@implementation KakazhuanzhangViewController

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
    [self setpageTitle:@"转帐"];
    
   // self.title=@"转帐";
    reversedArray=[[NSMutableArray alloc]init];
    BankMassage *model=[[BankMassage alloc]initWithIdAndName:@"01" andNmame:@"身份证"];
    BankMassage *model1=[[BankMassage alloc]initWithIdAndName:@"02" andNmame:@"军官证"];
    BankMassage *model2=[[BankMassage alloc]initWithIdAndName:@"03" andNmame:@"护照"];
    BankMassage *model3=[[BankMassage alloc]initWithIdAndName:@"04" andNmame:@"回乡证"];
    BankMassage *model4=[[BankMassage alloc]initWithIdAndName:@"05" andNmame:@"台胞证"];
    BankMassage *model6=[[BankMassage alloc]initWithIdAndName:@"06" andNmame:@"警官证"];
    BankMassage *model7=[[BankMassage alloc]initWithIdAndName:@"07" andNmame:@"士兵证"];
    BankMassage *model8=[[BankMassage alloc]initWithIdAndName:@"99" andNmame:@"其他证件类型"];
    [reversedArray addObject:model];
    [reversedArray addObject:model1];
    [reversedArray addObject:model2];
    [reversedArray addObject:model3];
    [reversedArray addObject:model4];
    [reversedArray addObject:model6];
    [reversedArray addObject:model7];
    [reversedArray addObject:model8];

    pickerArray = reversedArray;
    self.textField3.inputAccessoryView = _doneToolbar;
    
    _textField.delegate = self;
     _textField3.inputView = _selectPicker;
    self.textField1.delegate = self;
    self.textField2.delegate = self;
    self.textField3.delegate = self;
    self.textField4.delegate = self;
    self.textField5.delegate = self;
    self.textField6.delegate = self;
    
    _selectPicker.delegate = self;
    _selectPicker.dataSource = self;
    _selectPicker.frame = CGRectMake(0, 480, 320, 216);
    // [selectPicker setHidden:YES];
    [_doneToolbar setHidden:YES];
    isclean=NO;
    _textField3.text=@"身份证";
    type=@"01";
    // Do any additional setup after loading the view from its nib.
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(textField==self.textField3)
    {
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

//当用户按下return键或者按回车键，keyboard消失
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//输入框编辑完成以后，将视图恢复到原始状态
-(void)textFieldDidEndEditing:(UITextField *)textField
{
     NSInteger row = [_selectPicker selectedRowInComponent:0];
    if(!isclean&& textField==self.textField3)
    {
        BankMassage *bankMassage=[pickerArray objectAtIndex:row];
        textField.text = bankMassage.bank_Name;
        type=bankMassage.bank_Id;
    }
    self.view.frame =CGRectMake(0, kSystemVersion>=7.0?63:0, self.view.frame.size.width, self.view.frame.size.height);
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

- (IBAction)okButton:(id)sender
{
    NSString *errMsg = nil;
    
    if ([CommonUtil strNilOrEmpty:self.textField1.text])
    {
        errMsg = @"请输入转入卡姓名!";
        [self.textField1 becomeFirstResponder];
        
    }
    else if ([CommonUtil strNilOrEmpty:self.textField2.text])
    {
        errMsg = @"请输入转出卡姓名!";
        [self.textField2 becomeFirstResponder];
        
    }
    else if ([CommonUtil strNilOrEmpty:self.textField3.text])
    {
        errMsg = @"请选择证件类型!";
        [self.textField3 becomeFirstResponder];
        
    }
    else if ([CommonUtil strNilOrEmpty:self.textField4.text])
    {
        errMsg = @"请输入证件号!";
        [self.textField4 becomeFirstResponder];
        
    }
    else if ([CommonUtil strNilOrEmpty:self.textField.text])
    {
        errMsg = @"请输入收款卡号!";
        [self.textField becomeFirstResponder];
        
    }
    else if ([CommonUtil strNilOrEmpty:self.textField5.text])
    {
        errMsg = @"请输入转帐金额!";
        [self.textField5 becomeFirstResponder];
        
    }
    else if ([CommonUtil strNilOrEmpty:self.textField6.text])
    {
        errMsg = @"请输入手机号!";
        [self.textField6 becomeFirstResponder];
        
    }

    else if (_textField6.text.length<11)
    {
        errMsg = @"请输入合法手机号";
        [self.textField6 becomeFirstResponder];
        
    }
    if(![CommonUtil strNilOrEmpty:errMsg])
        [self showAlert:errMsg];
    else
    {
        
        UIAlertView*alert=[[UIAlertView alloc] initWithTitle:@"转账提示" message:[NSString stringWithFormat:@"收款银行卡号:%@.\n转账金额为:¥%@元.\n确定转账吗？",_textField.text,_textField5.text] delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        
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
        
        NSString *moneyVal=_textField5.text;
        //        NSMutableString *money=[NSMutableString stringWithFormat:@"%@",moneyVal];
        //        [money replaceCharactersInRange:NSMakeRange(0, 1) withString:@""];
        //        NSRange range=[money rangeOfString:@"."];
        //        if(range.length==0){
        //            [money appendString:@".00"];
        //        }
        
        tmpMoney=[NSString stringWithFormat:@"%d",(int)([moneyVal floatValue]*100)];
        NSMutableString *tmp=[[NSMutableString alloc] init];
        //若不够12位前面补0
        for(int i=0;i<(12-[tmpMoney length]);i++){
            [tmp appendString:@"0"];
            
        }
        [tmp appendString:tmpMoney];
        tradeMoney=tmp;
        tmpMoney1=tradeMoney;
        // tmpMoney1=tradeMoney;
        
        
        //tmpMoney=@"";
        [self checkIsSign];
        
    }
}


//D180刷卡
-(void)d180SwipCard{
    
    //[self showTrading];
    
    NSString *psamHex=[AESUtil hexStringFromString:[[pasamNo substringWithRange:NSMakeRange(2, [pasamNo length]-2)] dataUsingEncoding:NSUTF8StringEncoding]];
    
    macMeta=[NSString stringWithFormat:@"%@%@%@%@%@%@",SEARCH_BLANCE_CMD_708100,tradeMoney,tseqno,nowTime,nowDate,psamHex];
    op = [[MPosOperation alloc] initWithType:OPER_GET_MAC withName:@"getmac" withArgNum:1 withArgs:[[NSArray alloc] initWithObjects:macMeta, nil] withDelegate:mPosOperationDelegate];
    [opq addOperation:op];
     _D180identify=4;
    
}


//发送刷卡请求，查询余额
-(void)finishSwipCard{
    
    [self showTrading];
    
    DLog(@"===========开始计算mac……");
    
    NSString *psamHex=[AESUtil hexStringFromString:[[pasamNo substringWithRange:NSMakeRange(2, [pasamNo length]-2)] dataUsingEncoding:NSUTF8StringEncoding]];
    
    macMeta=[NSString stringWithFormat:@"%@%@%@%@%@%@",SEARCH_BLANCE_CMD_708100,tradeMoney,tseqno,nowTime,nowDate,psamHex];
    //获取mac
    [self getMac:macMeta];
    
    
    
}


//Qpos刷卡
-(void)qPosSwipCard{
    
    NSString *psamHex=[AESUtil hexStringFromString:[[pasamNo substringWithRange:NSMakeRange(2, [pasamNo length]-2)] dataUsingEncoding:NSUTF8StringEncoding]];
    
    macMeta=[NSString stringWithFormat:@"%@%@%@%@%@%@",SEARCH_BLANCE_CMD_708100,tradeMoney,tseqno,nowTime,nowDate,psamHex];

    
    
    
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
    RandomNumber=randomNumber;
    termialNo=ksn;
    pasamNo=ksn;
    macEncrypt=@"";
    [self hideAllView];
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
    [array addObject:SEARCH_BLANCE_CMD_708100];
    
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
    [array addObject:@"Track2_B"];
    [array addObject:trackInfo];
    [array addObject:@"TXNAMT_B"];
    [array addObject:tradeMoney];
    [array addObject:@"CRDNO1_B"];
    [array addObject:_textField.text];
    
    [array addObject:@"INCARDNAM_B"];
    [array addObject:_textField1.text];
    
    [array addObject:@"OUTCARDNAM_B"];
    [array addObject:_textField2.text];
    
    [array addObject:@"OUT_IDTYP_B"];
    [array addObject:type];
    
    [array addObject:@"OUT_IDTYPNAM_B"];
    [array addObject:_textField3.text];
    
    [array addObject:@"OUT_IDCARD_B"];
    [array addObject:_textField4.text];
    
    [array addObject:@"CRDNOJLN_B"];
    [array addObject:pinInfo];
    [array addObject:@"MOBILE_B"];
    [array addObject:_textField6.text];
    [array addObject:@"MAC_B"]; //mac
    [array addObject:macEncrypt];
    NSString *paramXml=[CommonUtil createXml:array];
    NSString *PACKAGEMAC=[ValueUtils md5UpStr:paramXml];
    
    [array addObject:@"PACKAGEMAC"];
    [array addObject:PACKAGEMAC];
    NSString *params=[CommonUtil createXml:array];
    _controlCentral.requestController=self;
    [_controlCentral requestDataWithJYM:SEARCH_BLANCE_CMD_708100
                             parameters:params
                     isShowErrorMessage:TRADE_URL_TYPE
                             completion:^(id result, NSError *requestError, NSError *parserError) {
                                 
                                 [self hideAllView];
                                 if (result)
                                 {
                                     [self showAlert:@"转账成功！"];
                                    
                                     [self.navigationController popViewControllerAnimated:YES];
                                     
                                 }
                             }];
    }

-(IBAction)hideKeyBoard:(id)sender
{
    [self hiddenKeyboard];
}

-(void)hiddenKeyboard{
    [self.textField1 resignFirstResponder];
    [self.textField2 resignFirstResponder];
    [self.textField resignFirstResponder];
    [self.textField3 resignFirstResponder];
    [self.textField5 resignFirstResponder];
    [self.textField4 resignFirstResponder];
    [self.textField6 resignFirstResponder];
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
    NSArray *item_02 = [NSArray arrayWithObjects:@"acnavicon02", @"转账记录", nil];
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
            bMFlowerViewController.bm_Type=0;
            
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
    question.url_type=zhuanzhang;
    [self.navigationController pushViewController:question animated:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
