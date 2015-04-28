//
//  SmrzThreeViewController.h
//  MiniPay
//
//  Created by apple on 14-5-9.
//  Copyright (c) 2014年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FDTakeController.h"
//@class FDTakeController;
@interface SmrzThreeViewController : YMTradeBaseController<FDTakeDelegate>
{
    NSString*sfzurl;
    NSString*sfzurl1;
    NSString*grjzurl;
    NSString*yhkurl;
    NSString*type;
     UIImage *newImage;
    NSString *imagestr;
    FDTakeController *takeController;
    UIViewController *viewcontroller;

}
- (IBAction)sumitButton:(id)sender;
//@property FDTakeController *takeController;
- (IBAction)takePhotoOrChooseFromLibrary:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *sfzbtn;
@property (strong, nonatomic) IBOutlet UIButton *grjzbtn;
@property (strong, nonatomic) IBOutlet UIButton *yhkbtn;
@property (strong, nonatomic) IBOutlet UIButton *sfzbtn1;

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *number;
@property (strong, nonatomic) NSString *shanghuname;
@property (strong, nonatomic) NSString *jyfw;
@property (strong, nonatomic) NSString *jydz;
@property (strong, nonatomic) NSString *xlh;

@property (strong, nonatomic) NSString *khname;
@property (strong, nonatomic) NSString *pcityname;
@property (strong, nonatomic) NSString *pictyid;
@property (strong, nonatomic) NSString *cityname;
@property (strong, nonatomic) NSString *cityid;

@property (strong, nonatomic) NSString *bankname;
@property (strong, nonatomic) NSString *bankId;
@property (strong, nonatomic) NSString *citybankname;
@property (strong, nonatomic) NSString *citybankId;
@property (strong, nonatomic) NSString *cardnumber;
@end
