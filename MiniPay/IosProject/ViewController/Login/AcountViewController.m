//
//  AcountViewController.m
//  MiniPay
//
//  Created by apple on 14-4-1.
//  Copyright (c) 2014年 allen. All rights reserved.
//

#import "AcountViewController.h"
#import "FDTakeController.h"
#import "GDataXMLNode.h"
#import "BankMassage.h"
#import "GTMBase64.h"
@interface AcountViewController ()
{
    BOOL isclean;
    UITextField *usertextfield;
    UIViewController*viewController;
   
}

@end

@implementation AcountViewController
@synthesize textField,selectPicker,pickerview,doneToolbar;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title=@"基本信息(2/2)";

    }
    return self;
}

- (id)initWithphonenumberandcheckcode:(NSString *)phonnumber checkcode:(NSString *)code andpwd:(NSString*)pwd1
{
     self.title=@"基本信息(2/2)";
       phonenunber=phonnumber;
       chkecode=code;
     pwd=pwd1;
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
        reversedArray=[[NSMutableArray  alloc]init];
    BankMassage *model=[[BankMassage alloc]initWithIdAndName:@"01" andNmame:@"工商银行"];
      BankMassage *model1=[[BankMassage alloc]initWithIdAndName:@"02" andNmame:@"农业银行"];
    [reversedArray addObject:model];
    [reversedArray addObject:model1];
    pickerArray = [[reversedArray reverseObjectEnumerator] allObjects];
   // pickerArray = [NSArray arrayWithObjects:@"动物",@"植物",@"石头",@"天空", nil];
    //    textField.inputView = selectPicker;
     self.textField5.inputAccessoryView = doneToolbar;
    
    textField.delegate = self;
    self.textField1.delegate = self;
    self.textField2.delegate = self;
    self.textField3.delegate = self;
    self.textField4.delegate = self;
    self.textField5.delegate = self;
    self.textField6.delegate = self;
    self.textField7.delegate = self;
    selectPicker.delegate = self;
    selectPicker.dataSource = self;
    selectPicker.frame = CGRectMake(0, 480, 320, 216);
   // [selectPicker setHidden:YES];
    [pickerview setHidden:YES];
    [doneToolbar setHidden:YES];
    isclean=NO;
    self.tableView.separatorStyle = NO;
    
    self.takeController = [[FDTakeController alloc] init];
    self.takeController.delegate = self;
    viewController=self;

    
    // Do any additional setup after loading the view from its nib.
}


- (IBAction)showSheet:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"title,nil时不显示"
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:@"确定"
                                  otherButtonTitles:@"第一项", @"第二项",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];
}

- (IBAction)selectButton:(id)sender {
    isclean=NO;
    [usertextfield endEditing:YES];
    [doneToolbar setHidden:YES];
}

- (IBAction)cleanButton:(id)sender
{
    isclean=YES;
    [usertextfield endEditing:YES];
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
       usertextfield=textField;
    if(textField==self.textField5)
    {
  
     textField.inputView = selectPicker;
     [doneToolbar setHidden:NO];
    }
       return YES;
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
    
    NSInteger row = [selectPicker selectedRowInComponent:0];
    if(!isclean&& textField==self.textField5)
    {
        BankMassage *bankMassage=[pickerArray objectAtIndex:row];
        textField.text = bankMassage.bank_Name;
    }
    self.view.frame =CGRectMake(0, kSystemVersion>=7.0?55:0, self.view.frame.size.width, self.view.frame.size.height);
}


- (IBAction)takePhotoOrChooseFromLibrary:(id)sender
{
   // IsJsp=YES;
    if(sender==self.sfzbtn)
    {
      type=@"IDPIC";
    }
   else if(sender==self.grjzbtn)
    {
        type=@"MYPIC";
    }
   else if(sender==self.yhkbtn)
   {
       type=@"CARDPIC";
   }
    self. takeController.allowsEditingPhoto =YES;
        self.takeController.viewController=viewController;
    [self.takeController takePhotoOrChooseFromLibrary];
}

- (void)takeController:(FDTakeController *)controller gotPhoto:(UIImage *)photo withInfo:(NSDictionary *)info
{
    
      //  NSData *imageData = UIImagePNGRepresentation(savedImage);
   // newImage= [self imageWithImage:photo scaledToSize:CGSizeMake(120.0f, 84.0f)];
    newImage=photo;
   // NSData *imageData = UIImagePNGRepresentation(newImage);
     NSData *imageData = UIImageJPEGRepresentation(photo,0.5);
  //   NSData *imageData = UIImageJPEGRepresentation(photo,1.0);
    //[self performSelector:@selector(sendimage:) withObject:imageData afterDelay:1];
    [self sendfrmimage:imageData];
   // [self sendimage:imageData];
    [self showWaiting:@"正在上传请稍后！"];
}

-(void)sendfrmimage:(NSData*)image
{
    imagestr=[GTMBase64 stringByEncodingData:image];
    
    NSURL *url = [[NSURL alloc] initWithString:@"http://211.147.87.29:8092/Vpm/199021.tran"];
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
     NSString *TWITTERFON_FORM_BOUNDARY = @"AaB03x";
    [request setDelegate:self];
    [request setPostValue:phonenunber forKey:@"PHONENUMBER"];
    [request setPostValue:type forKey:@"FILETYPE"];
//    [request setData:image withFileName:[NSString stringWithFormat:@"people_%@.jpg",type] andContentType:@"image/jpeg" forKey:@"photo"];
    [request setPostValue:imagestr forKey:@"photos"];

    NSString *content=[[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@",TWITTERFON_FORM_BOUNDARY];
    //[request addRequestHeader:@"Content-Type" value:content];
   
    [request addRequestHeader:@"xface-Version" value:@"1.5.9953"];
    [request addRequestHeader:@"CONTENT-TYPE" value:@"application/x-www-form-urlencoded;charset=utf-8"];
    [request addRequestHeader:@"xface-UserId" value:@"460013181089809"];
    [request addRequestHeader:@"xface-Agent" value:@"w480h800"];
    [request addRequestHeader:@"User-Agent" value:@"IOS;DeviceId:iPhone;"];
    [request addRequestHeader:@"User-Agent-Backup" value:@"IOS;DeviceId:iPhone;"];
    [request addRequestHeader:@"Accepts-Encoding" value:@"utf-8"];

    //    [request addRequestHeader:@"charset" value:@"UTF-8"];
    
    
       //  [request setPostBody:image];
    
   
    [request setTimeOutSeconds:30];

    [request setRequestMethod:@"POST"];
    [request startAsynchronous];

}
- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSData *data = [request responseData];
    
    NSString* aStr=[[NSString alloc]initWithData:data encoding:NSASCIIStringEncoding];
    [self showAlert:@"上传错误！"];
    [self hideWaiting];

}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    NSError * error = nil;
    NSData *data = [request responseData];
    
//    NSString* aStr=[[NSString alloc]initWithData:data encoding:NSASCIIStringEncoding];
//    NSData* data = [aStr dataUsingEncoding:NSUTF32LittleEndianStringEncoding];
    NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
     NSString *stat = [responseDic objectForKey:@"RSPCOD"];
    NSString *msg = [responseDic objectForKey:@"RSPMSG"];
    if([stat isEqualToString:@"00"])
    {
         NSString *picurl = [responseDic objectForKey:@"PICURL"];
        
        if([type isEqualToString:@"IDPIC"])
        {
            sfzurl=picurl;
            [self.sfzbtn setBackgroundImage:newImage forState:UIControlStateNormal];
        }
        else if([type isEqualToString:@"MYPIC"])
        {
            grjzurl=picurl;
             [self.grjzbtn setBackgroundImage:newImage forState:UIControlStateNormal];
        
        }
        else if([type isEqualToString:@"CARDPIC"])
        {
            
            yhkurl=picurl;
             [self.yhkbtn setBackgroundImage:newImage forState:UIControlStateNormal];
        }
    
    }
    else
    {
         [self showAlert:msg];
    }
  
    [self hideWaiting];
    
}


-(void)sendimage:(NSData*)imageData

{
   //imagestr = [[NSString alloc] initWithData:imageData encoding:NSUTF8StringEncoding];
   // imagestr=[AESUtil base64forData:imageData];
    imagestr=[GTMBase64 stringByEncodingData:imageData];


  // imagestr=[AESUtil hexStringFromString:imageData];
    NSMutableArray *array=[[NSMutableArray alloc] init];
    
    [array addObject:@"TRANCODE"];
    [array addObject:SIGNATURE_CMD_702704];
    
    [array addObject:@"AC_NO_A"];
    [array addObject:@"9559970030000000215"];
    
    [array addObject:@"CTxnAt_A"];
    [array addObject:@"000000010000"];
    
    [array addObject:@"InMod_A"];
    [array addObject:@"022"];
    [array addObject:@"TPosCnd_A"];
    [array addObject:@"08"];
    
    [array addObject:@"Track2_A"];
    [array addObject:@"9559970030000000215D00002101815546"];
    
    [array addObject:@"TTermId_A"];
    [array addObject:@"00000001"];
    
    [array addObject:@"TMercId_A"];
    [array addObject:@"023310053110001"];
    
    [array addObject:@"NewPin_A"];
    [array addObject:@"13611111111"];
    
    [array addObject:@"TCcyCod_A"];
    [array addObject:@"156"];
    
    [array addObject:@"TSwtDat_A"];
    [array addObject:@"468203021033744"];
    
    
    NSString *paramXml=[CommonUtil createXml:array];
    NSString *PACKAGEMAC=[ValueUtils md5UpStr:paramXml];
    
    [array addObject:@"PACKAGEMAC"];
    [array addObject:PACKAGEMAC];
    
    NSString *params=[CommonUtil createXml:array];
    
    _controlCentral.requestController=self;
    [_controlCentral requestDataWithJYM:SIGNATURE_CMD_702704
                             parameters:params
                     isShowErrorMessage:NO_TRADE_URL_TYPE
                             completion:^(id result, NSError *requestError, NSError *parserError) {
                                 
                                 [self hideWaiting];
                                 if (result)
                                 {
                                     GDataXMLElement *rootElement=(GDataXMLElement *)result;
                                     // [self parseTradeXml:rootElement];
                                     
                                 }
                             }];



}

//解析xml
-(void)parseTradeXml:(GDataXMLElement *)rootElement{
    
    GDataXMLElement *lognoElement = [[rootElement elementsForName:@"LOGNO"] objectAtIndex:0];
    NSString *logno=[lognoElement stringValue];

}


- (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    // Return the new image.
    return newImage;
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
    
    
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
   
}


-(void)cancelClick{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   if(indexPath.row==2||indexPath.row==4){
        return 96.f;
      }
   else if(indexPath.row==6){
        return 140.f;
    }
   else if(indexPath.row==7){
       return 65.f;
   }
    return 44.0f;

}

-(UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {
    
    
    
    if(indexPath.row==0){
        
        return self.bankCell;
        
    }else if(indexPath.row==1){
       return self.bankCell1;
        
    }else if(indexPath.row==2){
        
       return self.bankCell2;
    }else if(indexPath.row==3){
        
        return self.bankCell3;
    }else if(indexPath.row==4){
       return self.bankCell4;
        
    }else if(indexPath.row==5){
       return self.bankCell5;
        
    }
    else if(indexPath.row==6){
        return self.bankCell7;
        
    }
    else if(indexPath.row==7){
        return self.bankCell6;
        
    }
    return nil;
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     [self hiddenKeyboard];
    
    
}



//开始编辑输入框的时候，软键盘出现，执行此事件
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(textField.tag>1)
    {
    CGPoint origin = textField.frame.origin;
    CGPoint point = [textField.superview convertPoint:origin toView:self.tableView];
    float navBarHeight = self.navigationController.navigationBar.frame.size.height;
    CGPoint offset = self.tableView.contentOffset;
    // Adjust the below value as you need
    offset.y = (point.y - navBarHeight-40);
    [self.tableView setContentOffset:offset animated:YES];
    }
}


-(IBAction)sumitButton:(id)sender
{
       NSString *errMsg = nil;
    
    if ([CommonUtil strNilOrEmpty:textField.text])
    {
        errMsg = @"请输入申请人姓名!";
        [textField becomeFirstResponder];

    }
    else if ([CommonUtil strNilOrEmpty:self.textField1.text])
    {
        errMsg = @"请输入身份证号!";
        [self.textField1 becomeFirstResponder];
        
    }
    else if (![CommonUtil chk18PaperId:self.textField1.text])
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
        errMsg = @"请输入经营地址!";
        [self.textField3 becomeFirstResponder];
        
    }
    else if ([CommonUtil strNilOrEmpty:self.textField4.text])
    {
        errMsg = @"请输入开户名!";
        [self.textField4 becomeFirstResponder];
        
    }
    else if ([CommonUtil strNilOrEmpty:self.textField5.text])
    {
        errMsg = @"请选择开户行!";
        //[self.textField becomeFirstResponder];
        
    }
    else if ([CommonUtil strNilOrEmpty:self.textField6.text])
    {
        errMsg = @"请输入开户网点!";
        [self.textField6 becomeFirstResponder];
        
    }
    else if ([CommonUtil strNilOrEmpty:self.textField7.text])
    {
        errMsg = @"请输入银行卡号!";
        [self.textField7 becomeFirstResponder];
        
    }
    else if ([CommonUtil strNilOrEmpty:grjzurl])
    {
        errMsg = @"请上传近期相片！";
        //[textField becomeFirstResponder];
        
    }
    else if ([CommonUtil strNilOrEmpty:sfzurl])
    {
        errMsg = @"请上传身份证附件！";
        //[textField becomeFirstResponder];
        
    }
    else if ([CommonUtil strNilOrEmpty:yhkurl])
    {
        errMsg = @"请上传银行卡附件!";
       // [textField becomeFirstResponder];
        
    }

    
     if(![CommonUtil strNilOrEmpty:errMsg])
     [self showAlert:errMsg];
     else
     {
         [self showWaiting:@""];
         
         NSMutableArray *array=[[NSMutableArray alloc] init];
         
         [array addObject:@"TRANCODE"];
         [array addObject:LOGIN_CMD_199001];
         
         [array addObject:@"PHONENUMBER"];
         [array addObject:phonenunber];
         
         [array addObject:@"MSGCODE"];
         [array addObject:chkecode];
         
         [array addObject:@"PASSWORD"];
         [array addObject:pwd];
         
         [array addObject:@"USERNAME"];
         [array addObject:textField.text];
         
         [array addObject:@"IDNUMBER"];
         [array addObject:self.textField1.text];
         
         [array addObject:@"IDPICURL"];
         [array addObject:sfzurl];
         
         [array addObject:@"MERNAME"];
         [array addObject:self.textField2.text];
         
         [array addObject:@"MERADDRESS"];
         [array addObject:self.textField3.text];
         
         [array addObject:@"ACCOUNTNAME"];
         [array addObject:self.textField4.text];
         
         [array addObject:@"RECEIVEBANK"];
         [array addObject:self.textField5.text];

         
         [array addObject:@"BRANKBRANCH"];
         [array addObject:self.textField6.text];

         
         [array addObject:@"BANKACCOUNT"];
         [array addObject:self.textField7.text];

         
         [array addObject:@"CARDPIC"];
         [array addObject:yhkurl];

         
         [array addObject:@"MYPIC"];
         [array addObject:grjzurl];

         
         
         NSString *paramXml=[CommonUtil createXml:array];
         NSString *PACKAGEMAC=[ValueUtils md5UpStr:paramXml];
         
         [array addObject:@"PACKAGEMAC"];
         [array addObject:PACKAGEMAC];
         
         NSString *params=[CommonUtil createXml:array];
         
         _controlCentral.requestController=self;
         [_controlCentral requestDataWithJYM:LOGIN_CMD_199001
                                  parameters:params
                          isShowErrorMessage:NO_TRADE_URL_TYPE
                                  completion:^(id result, NSError *requestError, NSError *parserError) {
                                      
                                      [self hideWaiting];
                                      if (result)
                                      {
                                          UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"注册成功！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                                          [alert show];
                                          
                                                                                    
                                      }
                                  }];

     }
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(buttonIndex!=alertView.cancelButtonIndex){
        
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }
}



//当用户按下return键或者按回车键，keyboard消失

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    [self hiddenKeyboard];
    
    return YES;
}




-(void)hiddenKeyboard{
    
    //self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.textField1 resignFirstResponder];
    [self.textField2 resignFirstResponder];
    [self.textField3 resignFirstResponder];
    [self.textField4 resignFirstResponder];
    [self.textField5 resignFirstResponder];
    [self.textField6 resignFirstResponder];
    [self.textField7 resignFirstResponder];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
