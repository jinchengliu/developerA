//
//  SignatureViewController.m
//  MiniPay
//
//  Created by allen on 13-12-4.
//  Copyright (c) 2013年 allen. All rights reserved.
//

#import "SignatureViewController.h"
#import "GDataXMLNode.h"
//用户刷卡签名页面
@interface SignatureViewController ()

@property (unsafe_unretained, nonatomic) IBOutlet DAScratchPadView *scratchPad;


@end



@implementation SignatureViewController
@synthesize scratchPad=_scratchPad;
@synthesize delegate=_delegate;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}


-(IBAction)confirmBtn:(id)sender{
    
    [self showWaiting:nil];
    //获取转换签名信息
    [self selectFirstName];
    
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
                                     result.hidesBottomBarWhenPushed=YES;
                                     result.Trademoney=_money;
                                     if([_delegate respondsToSelector:@selector(didFinishTrade:)]){
                                         
                                         [_delegate didFinishTrade:YES];
                                     }
                                     [self.navigationController pushViewController:result animated:YES];
                                     
                                     
                                 }
                             }];

    
    
    
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(buttonIndex!=alertView.cancelButtonIndex){
        if([_delegate respondsToSelector:@selector(didFinishTrade:)]){
            [_delegate didFinishTrade:YES];
        }
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    
}


-(IBAction)cancelmBtn:(id)sender{
    
   
    [self.navigationController popToRootViewControllerAnimated:YES];
    

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"签名";
    //_scratchPad=[[DAScratchPadView alloc]init];
    _scratchPad.drawColor = [UIColor blackColor];  //签名颜色
    _scratchPad.drawWidth=2.0f;  //笔粗细
    _scratchPad.toolType = DAScratchPadToolTypePaint;  //画笔类型
    
    
}


-(void)setDrawColor
{


}


//生成图片
- (IBAction)selectFirstName
{
    //截图
    if(kIsIphone5){
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(640, 1136), YES, 0);
    }else{
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(640, 960), YES, 0);
    }
            
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGImageRef imageRef = viewImage.CGImage;
    CGRect rect;
    if(kIsIphone5){
         rect =CGRectMake(0, 0, 640, 898);//这里可以设置想要截图的区域898
    }else{
         rect =CGRectMake(0, 0, 640, 722);//这里可以设置想要截图的区域772
    }
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
