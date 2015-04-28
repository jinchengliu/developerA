//
//  SignaturViewController.m
//  MiniPay
//
//  Created by apple on 14-4-2.
//  Copyright (c) 2014年 allen. All rights reserved.
//

#import "SignaturViewController.h"
#import "TradeResultViewController.h"
@interface SignaturViewController ()
{

}

@end

@implementation SignaturViewController
@synthesize imageview1=_imageview1;
@synthesize delegate=_delegate;
@synthesize finshcaedBlock=_finshcaedBlock;
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
    //self.title=@"签名";
    [self setpageTitle:@"签名"];
    if(kIsIphone5)
    {
        self.drawView=[[MyView alloc]initWithFrame: CGRectMake(0, 81, 320, 317)];
   }
    else
    {
        self.drawView=[[MyView alloc]initWithFrame: CGRectMake(0, 81, 320, 238)];
        _lable.frame=CGRectMake(20, 329, 295, 21);

    }
    
     [self.moneylable setText:[NSString stringWithFormat:@"￥%@",_money]];
    //self.logno=@"";
    
//      self.drawView.layer.borderWidth = 1;
//    
//      self.drawView.layer.borderColor = [[UIColor colorWithRed:0.52 green:0.09 blue:0.07 alpha:1] CGColor];

    [self.drawView setBackgroundColor:[UIColor whiteColor]];
    [self.drawView setLineColor:3];
     [self.drawView setlineWidth:4];
    [self.view addSubview: self.drawView];
    
    // Do any additional setup after loading the view from its nib.
}

-(IBAction)confirmBtn:(id)sender{
    
    if(self.drawView.istrue)
    {
        if( againsumit)
        {
            [self showWaiting:nil];
            [self saveimage];
            if(_finshcaedBlock)
                _finshcaedBlock(signatureImageStr);
         //  [self sendhttp];
           // [self performSelector:@selector(sendhttp) withObject:nil afterDelay:0.6];

        }
        else
        {
            [self saveimage];
             againsumit=TRUE;
            [self.drawView setLineColor:4];
            [self.drawView setlineWidth:4];
            [self.confirmBtn setTitle:@"确认签名" forState:UIControlStateNormal];

        }
        

       
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示" message:@"当前签名过于简单!" delegate:Nil cancelButtonTitle:Nil otherButtonTitles:@"确定", nil];
        [alert show];
    }
   // if(self.drawView.l)
}


-(void)sendhttp
{
    NSMutableArray *array=[[NSMutableArray alloc] init];
    
    [array addObject:@"TRANCODE"];
    [array addObject:SIGNATURE_CMD_199010];
    
    [array addObject:@"LOGNO"];
    [array addObject:self.logno];
    
    [array addObject:@"ELESIGNA"];
    [array addObject:signatureImageStr];
    
    NSString *paramXml=[CommonUtil createXml:array];
    NSString *PACKAGEMAC=[ValueUtils md5UpStr:paramXml];
    
    [array addObject:@"PACKAGEMAC"];
    [array addObject:PACKAGEMAC];
    
    NSString *params=[CommonUtil createXml:array];
    
    _controlCentral.requestController=self;
    [_controlCentral requestDataWithJYM:SIGNATURE_CMD_199010
                             parameters:params
                     isShowErrorMessage:TRADE_URL_TYPE
                             completion:^(id result, NSError *requestError, NSError *parserError) {
                                 
                                 [self hideWaiting];
                                 if (result)
                                 {
                                     //                                     if(_type==1){
                                     //
                                     //
                                     //
                                     //                                     }else{
                                     //
                                     //                                         UIAlertView *view=[[UIAlertView alloc] initWithTitle:@"提示" message:@"签名成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
                                     //                                         [view show];
                                     //
                                     //                                     }
                                     
                                     TradeResultViewController *result=[[TradeResultViewController alloc] init];
                                     result.type=_type;
                                     result.logno=_logno;
                                     result.hidesBottomBarWhenPushed=YES;
                                     result.Trademoney=_money;
                                     if([_delegate respondsToSelector:@selector(didFinishTrade:)]){
                                         [_delegate didFinishTrade:YES];
                                     }
                                     [self.navigationController pushViewController:result animated:YES];
   
                                 }
                             }];

}
-(IBAction)cancelmBtn:(id)sender{
    
       [self.confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
       againsumit=FALSE;
       [self.drawView clear];
       [self.drawView setLineColor:3];
    
}

-(void)saveimage
{
    UIGraphicsBeginImageContext(self.drawView.bounds.size);
    [self.drawView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
  
    UIGraphicsEndImageContext();
    
    UIImage *image1=[self image:image centerInSize:CGSizeMake(100,100)];
    
//    UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);
//    for (int i=1;i<16;i++) {
//        if ((i>=1&&i<=5)||(i>=11&&i<=14)) {
//            continue;
//        }
//        UIView *view=[self.drawView viewWithTag:i];
//        
//    }
    NSData *imageData = UIImagePNGRepresentation(image1);
    signatureImageStr=[AESUtil hexStringFromString:imageData];

   // _imageview1.image=image1;
    imageData=nil;
    
    image=nil;

}

- (UIImage *)image:(UIImage *)image centerInSize:(CGSize)viewsize
{
    UIGraphicsBeginImageContext(CGSizeMake(viewsize.width, viewsize.height));
    [image drawInRect:CGRectMake(0, 0, viewsize.width, viewsize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return reSizeImage;
}

//生成图片
- (IBAction)selectFirstName
{
    //截图
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(self.drawView.frame.size.width, self.drawView.frame.size.height), YES, 0);
    
    [self.drawView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGImageRef imageRef = viewImage.CGImage;
    CGRect rect;
    rect =CGRectMake(150, 280, self.drawView.frame.size.width, self.drawView.frame.size.height);//这里可以设置想要截图的区域898
    CGImageRef imageRefRect =CGImageCreateWithImageInRect(imageRef, rect);
    UIImage *sendImage = [[UIImage alloc] initWithCGImage:imageRefRect];
    UIImage *newImage= [self imageWithImage:sendImage scaledToSize:CGSizeMake(132.0f, 55.0f)];
    NSData *imageViewData = UIImagePNGRepresentation(newImage);
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:@"snapshotSign.jpg"];
    
    [imageViewData writeToFile:savedImagePath atomically:YES];
    CGImageRelease(imageRefRect);
    
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"snapshotSign.jpg"];
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:filePath];
    _imageview1.image=sendImage;
    
    NSData *imageData = UIImagePNGRepresentation(savedImage);
    signatureImageStr=[AESUtil hexStringFromString:imageData];
    

    if(IsNilString(signatureImageStr)){
        [self hideWaiting];
        [self showAlert:@"请签名"];
        return;
    }
    
    
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


-(void)cancelClick{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   
    
    // Dispose of any resources that can be recreated.
}

@end
