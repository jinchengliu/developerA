//
//  MerchantIndexViewController.h
//  MiniPay
//
//  Created by allen on 13-11-17.
//  Copyright (c) 2013年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MxMovingPlaceholderTextField.h"

@interface MerchantIndexViewController : YMTableViewController<UIAlertViewDelegate>{
    
    
    BOOL isLoadDate;
    UIImageView *topBgView;
    UIImageView *topBgSelView;
    
    UIImageView *middleBgView1;
    UIImageView *middleBgSelView;
    
    UIImageView *middleBgView2;
    UIImageView *middleBgView3;
    UIImageView *middleBgView4;
     UIImageView *middleBgView5;
    UIImageView *middleBgView6;
    UIImageView *botomBgView;
    UIImageView *botomBgSelView;
    NSString*status;
    
    
}

@property (retain, nonatomic) IBOutlet UIView *mainView;

@property (weak, nonatomic) IBOutlet UILabel *carNoLabel;
@property (weak, nonatomic) IBOutlet UILabel *statuslable;
@property (weak, nonatomic) IBOutlet UILabel *accountLabel;
@property (weak, nonatomic) IBOutlet UILabel *accountLabel1;
@property (weak, nonatomic) IBOutlet UILabel *bankLabel;
@property (weak, nonatomic) IBOutlet UILabel *merchantNameLabel;
@property(nonatomic,strong) NSMutableArray *array;
@property (strong, nonatomic) IBOutlet UITableViewCell *firstCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *thirdCell;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *dateLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *inDateLabel;
@property (strong, nonatomic) IBOutlet UITableViewCell *fouthCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *fifthCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *sixthCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *servenCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *eightCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *nineCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *myaccountCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *smrzCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *skCell;
@property (strong, nonatomic) IBOutlet MxMovingPlaceholderTextField *mxMovingPlaceholderTextField;

- (IBAction)OnClick1:(UIButton *)sender;
-(IBAction)refreshData:(id)sender;

@end
