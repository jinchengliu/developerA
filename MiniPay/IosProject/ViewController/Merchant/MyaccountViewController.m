//
//  MyaccountViewController.m
//  MiniPay
//
//  Created by apple on 14-5-5.
//  Copyright (c) 2014年 allen. All rights reserved.
//

#import "MyaccountViewController.h"
#import "GDataXMLNode.h"
#import "TixianViewController.h"
#import "NormalQuestionViewController.h"
#import "FeeBackViewController.h"
#import "BMFlowerViewController.h"
@interface MyaccountViewController (){
    BOOL isclean;
    BOOL isputongtx;
     Boolean isOpen;
    NSString*stuts;
    
    
    /** 导航栏 按钮 加号 图片 */
    UIImageView *_plusIV;
    
    /** 是否已打开抽屉 */
    BOOL _isOpen;
    
    /** 抽屉视图 */
    ACNavBarDrawer *_drawerView;

}

@end

@implementation MyaccountViewController

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
    [self setpageTitle:@"提现"];
    //self.title=@"提现";
    [self showWaiting:nil];
    [self getMerchantInfo];
    //获取商户信息
    _textField1.delegate=self;
    _nameLable.text=_name;
    _banknameLable.text=_bankname;
    _cardnoLable.text=_cardno;
    _ksnLable.text=_dataManager.TerminalSerialNumber;
    _mxMovingPlaceholderTextField.placeholder =_merchantNameLabel;
     [_mxMovingPlaceholderTextField startMoving];
    _shanghulable.text=_merchantNameLabel;
    _nameLable2.text=_name;
    isOpen = NO;
     [_textField1 setKeyboardType:UIKeyboardTypeDecimalPad];
    UIToolbar* keyboardToolbar_ = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0,self.view.bounds.size.width, 38.0f)];
    keyboardToolbar_.barStyle = UIBarStyleDefault;
    //    UIBarButtonItem *titleButton = [[UIBarButtonItem alloc] initWithTitle:@""
    //
    //                                                                    style: UIBarButtonItemStylePlain
    //
    //                                                                   target: nil
    //
    //                                                                   action: nil];
    //左空格
    UIBarButtonItem *leftflexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    //右空格
    UIBarButtonItem *rightflexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *doneBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(resignKeyboard:)];
    
    
    
    [keyboardToolbar_ setItems:[NSArray arrayWithObjects:leftflexible,doneBarItem,rightflexible, nil]];
    _textField1.inputAccessoryView = keyboardToolbar_;
    
    // _textField1.returnKeyType=UIReturnKeyDefault;
}
- (void)resignKeyboard:(id)sender
{
    
    [_textField1 resignFirstResponder];
}




- (IBAction)OnClick1:(UIButton *)sender {
    
    //    if (isOpen) {
    //        [self.img setHidden:YES];
    //    }else {
    //        [self.img setHidden:NO];
    //    }
    
    [UIView animateWithDuration:.5 animations:^{
        self.mainView.alpha = 1;
        //        self.mainView.transform = CGAffineTransformScale(self.btn.transform, 4.2f, 4.2f);
        self.mainView.frame = CGRectMake(self.mainView.frame.origin.x, self.mainView.frame.origin.y, self.mainView.frame.size.width, self.mainView.frame.size.height+(isOpen ? -122 : 122));
        self.view1.frame = CGRectMake(self.view1.frame.origin.x, self.view1.frame.origin.y+(isOpen ? -122 : 122), self.view1.frame.size.width, self.view1.frame.size.height);
        //self.img.alpha=0;
        if(!isOpen)
        {
            [UIView animateWithDuration:.5 animations:^{
                // self.img.alpha = 1;
                
                //number = number+90.0;
                
                CGAffineTransform rotate = CGAffineTransformMakeRotation(180 / 180.0 * M_PI );
                
                [_openbtn setTransform:rotate];
                 }];
        }
        else
        {
        
            [UIView animateWithDuration:.5 animations:^{
                // self.img.alpha = 1;
                
                //number = number+90.0;
                
                CGAffineTransform rotate = CGAffineTransformMakeRotation(360 / 180.0 * M_PI );
                
                [_openbtn setTransform:rotate];
            }];

        
        }
    }completion:^(BOOL finished) {
        
        
        
            
        
    }];
    
    isOpen = !isOpen;
    
}

- (IBAction)selectButton:(id)sender {
    isclean=NO;
   [_textField endEditing:YES];
    [_doneToolbar setHidden:YES];
    if ([CommonUtil strNilOrEmpty:self.textField1.text])
    {
        [self showAlert:@"请输入提现金额！"];
        return;
    }
    [self tixianBtn:nil];
}

- (IBAction)cleanButton:(id)sender
{
     [_textField endEditing:YES];
     isclean=YES;
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
        _textField.text = [pickerArray objectAtIndex:row];
    if([_textField.text isEqualToString:@"快速提现"])
    {
       
        isputongtx=FALSE;
    }
    else
    {
       isputongtx=TRUE;
    
    }
    
    //[self hiddenKeyboard];
     self.view.frame =CGRectMake(0, kSystemVersion>=7.0?63:0, self.view.frame.size.width, self.view.frame.size.height);
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if([stuts isEqualToString:@"2"])
        return false;
   
    if(textField==_textField)
    {
        _textField.inputView = _selectPicker;
        [_doneToolbar setHidden:NO];
         
    }
   
    
    
    return YES;
}



- (IBAction)tixianBtn:(id)sender
{
    
    NSString *errMsg = nil;
    //    if ([CommonUtil strNilOrEmpty:_jierField.text])
    //    {
    //        errMsg = @"请输入金额！";
    //        [_jierField becomeFirstResponder];
    //
    //    }
    if ([_textField1.text intValue]<100)
    {
        errMsg = @"提现金额不能低于100！";
        [_textField1 becomeFirstResponder];
        
    }
    
   else
       if (!(sender==_ptbuton)&&[_textField1.text intValue]>10000)
    {
        errMsg = @"快速提现金额不能超过1万！";
        [_textField1 becomeFirstResponder];
        
    }
   
    if(![CommonUtil strNilOrEmpty:errMsg])
        [self showAlert:errMsg];
    else
    {
      
        TixianViewController *tixian=[[TixianViewController alloc] init];
        tixian.jine=_textField1.text;
          _textField1.text=@"";
        tixian.Ispttixian=isputongtx;
        if(sender==_ptbuton)
        {
            
            tixian.Ispttixian=YES;
            
        }
        else
        {
            tixian.Ispttixian=NO;
            
        }
        tixian.gohomeBlock=^(void){
            [self getMerchantInfo];
        };
        [self.navigationController pushViewController:tixian animated:YES];

        
    }
    
}

//获取商户信息
-(void)getMerchantInfo
{
    NSMutableArray *array=[[NSMutableArray alloc] init];
    NSString *phonerNumber=[_dataManager GetObjectWithNSUserDefaults:PHONENUMBER];
    [array addObject:@"TRANCODE"];
    [array addObject:MERCHANT_INFO_CMD_199026];
    [array addObject:@"PHONENUMBER"];
    [array addObject:phonerNumber];
    
    [array addObject:@"PACKAGEMAC"];
    [array addObject:[ValueUtils md5UpStr:[CommonUtil createXml:array]]];
    
    NSString *params=[CommonUtil createXml:array];
    
    _controlCentral.requestController=self;
    [_controlCentral requestDataWithJYM:MERCHANT_INFO_CMD_199026
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


-(IBAction)hiddenKeyboard:(id)sender{
    
    //self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [_textField1 resignFirstResponder];
   // [_pwdField resignFirstResponder];
    
    
}

//解析xml
-(void)parseXml:(GDataXMLElement *)rootElement{
    
    
    GDataXMLElement *CASHBAL = [[rootElement elementsForName:@"CASHBAL"] objectAtIndex:0];
    GDataXMLElement *CASHACBAL = [[rootElement elementsForName:@"CASHACBAL"] objectAtIndex:0];
     GDataXMLElement *ACSTATUS = [[rootElement elementsForName:@"ACSTATUS"] objectAtIndex:0];
      [_myzcLable setText:[NSString stringWithFormat:@"￥%@",[CASHBAL stringValue]]];
      [_myyeLable setText:[NSString stringWithFormat:@"￥%@",[CASHACBAL stringValue]]];
  
      stuts=[ACSTATUS stringValue];
//    [_accountLabel setText:[accountElement stringValue]];
//    [_bankLabel setText:[backElement stringValue]];
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
    NSArray *item_02 = [NSArray arrayWithObjects:@"acnavicon02", @"提现记录", nil];
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
            bMFlowerViewController.bm_Type=3;
            
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
    question.url_type=tixian;
    [self.navigationController pushViewController:question animated:YES];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
