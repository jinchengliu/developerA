//
//  SmrzThreeViewController.m
//  MiniPay
//
//  Created by apple on 14-5-9.
//  Copyright (c) 2014年 allen. All rights reserved.
//

#import "SmrzThreeViewController.h"
#import "FDTakeController.h"
#import "GTMBase64.h"
#import "GDataXMLNode.h"
@interface SmrzThreeViewController ()
@end
@implementation SmrzThreeViewController
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
    //self.title=@"基本信息(3/3)";
    [self setpageTitle:@"基本信息(3/3)"];
    takeController = [[FDTakeController alloc] init];
    takeController.delegate = self;
    viewcontroller=self;
    
    // Do any additional setup after loading the view from its nib.
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
    else if(sender==self.sfzbtn1)
    {
        type=@"IDPIC2";
    }
    takeController.allowsEditingPhoto =YES;
    takeController.viewController=viewcontroller;
    [takeController takePhotoOrChooseFromLibrary];
}



- (void)takeController:(FDTakeController *)controller gotPhoto:(UIImage *)photo withInfo:(NSDictionary *)info
{
    
    //  NSData *imageData = UIImagePNGRepresentation(savedImage);
    // newImage= [self imageWithImage:photo scaledToSize:CGSizeMake(120.0f, 84.0f)];
    newImage=photo;
    // NSData *imageData = UIImagePNGRepresentation(newImage);
    NSData *imageData = UIImagePNGRepresentation(photo);
    //   NSData *imageData = UIImageJPEGRepresentation(photo,1.0);
    //[self performSelector:@selector(sendimage:) withObject:imageData afterDelay:1];
    [self sendfrmimage:imageData];
    // [self sendimage:imageData];
    [self showWaiting:@"正在上传请稍后！"];
}

-(void)sendfrmimage:(NSData*)image
{
    imagestr=[GTMBase64 stringByEncodingData:image];
    
    
    //NSURL *url = [[NSURL alloc] initWithString:@"http://211.147.87.20:8092/Vpm/199021.tran"];
    NSString *nsurl=[NSString stringWithFormat:@"%@%@.%@",TRADE_BASE_URL,@"199021",@"tran"];
    NSURL *url=[[NSURL alloc]initWithString:nsurl];
    ASIFormDataRequest *request=[ASIFormDataRequest requestWithURL:url];
    NSString *TWITTERFON_FORM_BOUNDARY = @"AaB03x";
    [request setDelegate:self];
    [request setPostValue:phonerNumber forKey:@"PHONENUMBER"];
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
        else if([type isEqualToString:@"IDPIC2"])
        {
            sfzurl1=picurl;
            [self.sfzbtn1 setBackgroundImage:newImage forState:UIControlStateNormal];
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

-(IBAction)sumitButton:(id)sender
{
    NSString *errMsg = nil;
    if ([CommonUtil strNilOrEmpty:grjzurl])
    {
        errMsg = @"请上传近期相片！";
        //[textField becomeFirstResponder];
    }
    else if ([CommonUtil strNilOrEmpty:yhkurl])
    {
        errMsg = @"请上传银行卡附件！";
        //[textField becomeFirstResponder];
    }
    else if ([CommonUtil strNilOrEmpty:sfzurl])
    {
        errMsg = @"请上传身份证正面附件!";
        // [textField becomeFirstResponder];
    }
    else if ([CommonUtil strNilOrEmpty:sfzurl1])
    {
        errMsg = @"请上传身份证反面附件!";
        // [textField becomeFirstResponder];
    }
    if(![CommonUtil strNilOrEmpty:errMsg])
        [self showAlert:errMsg];
    else
    {
        [self showWaiting:@"请稍后……"];
        NSMutableArray *array=[[NSMutableArray alloc] init];
        [array addObject:@"TRANCODE"];
        [array addObject:MERCHANT_INFO_CMD_P77022];
        [array addObject:@"PHONENUMBER"];
        [array addObject:phonerNumber];
        
        
        [array addObject:@"IDPICURL"];
        [array addObject:sfzurl];
        [array addObject:@"CARDPIC"];
        [array addObject:yhkurl];
        [array addObject:@"CARDPIC2"];
        [array addObject:sfzurl1];
        [array addObject:@"MYPIC"];
        [array addObject:grjzurl];
        NSString *paramXml=[CommonUtil createXml:array];
        NSString *PACKAGEMAC=[ValueUtils md5UpStr:paramXml];
        [array addObject:@"PACKAGEMAC"];
        [array addObject:PACKAGEMAC];
        NSString *params=[CommonUtil createXml:array];
        _controlCentral.requestController=self;
        [_controlCentral requestDataWithJYM:MERCHANT_INFO_CMD_P77022
                                 parameters:params
                         isShowErrorMessage:NO_TRADE_URL_TYPE
                                 completion:^(id result, NSError *requestError, NSError *parserError) {
                                     [self hideWaiting];
                                     if (result)
                                     {
                                         
                                         GDataXMLElement *rootElement=(GDataXMLElement *)result;
                                         
                                         GDataXMLElement *TERMTYPE = [[rootElement elementsForName:@"TERMTYPE"] objectAtIndex:0];
                                         NSString *postype=[TERMTYPE stringValue];
                                         if([postype isEqualToString:@"VPOS"])
                                         {
                                             //devicetype = [NSString stringWithFormat:@"%d",Vpos];
                                             [CommonUtil savepostype:[NSString stringWithFormat:@"%d",Vpos]];
                                             _dataManager.device_Type=Vpos;
                                         }
                                         
                                         else if([postype isEqualToString:@"支付通-QPOS"])
                                         {
                                             //devicetype = [NSString stringWithFormat:@"%d",Vpos];
                                             [CommonUtil savepostype:[NSString stringWithFormat:@"%d",Qpos]];
                                             _dataManager.device_Type=Qpos;
                                         }
                                         
                                         else if([postype isEqualToString:@"QPOS3.0"])
                                         {
                                             [CommonUtil savepostype:[NSString stringWithFormat:@"%d",Qpos_blue]];
                                             _dataManager.device_Type=Qpos_blue;
                                             
                                         }

                                         else if([postype isEqualToString:@"D180"])
                                         {
                                             //devicetype = [NSString stringWithFormat:@"%d",Vpos];
                                             [CommonUtil savepostype:[NSString stringWithFormat:@"%d",D180]];
                                             _dataManager.device_Type=D180;
                                         }
                                         
                                         else if([postype isEqualToString:@"SKTPOS"])
                                         {
                                             //devicetype = [NSString stringWithFormat:@"%d",Vpos];
                                             [CommonUtil savepostype:[NSString stringWithFormat:@"%d",SKTPOS]];
                                             _dataManager.device_Type=SKTPOS;
                                         }
                                         else
                                         {
                                             _dataManager.device_Type=NOpos;
                                         }
                                         UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"提交成功！请等待审核结果！" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
