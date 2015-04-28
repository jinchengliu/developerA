//
//  UICityPicker.h
//  DDMates
//
//  Created by ShawnMa on 12/16/11.
//  Copyright (c) 2011 TelenavSoftware, Inc. All rights reserved.
//


#import <QuartzCore/QuartzCore.h>
#import "TSLocation.h"
typedef void(^HidwaitBlock)();
typedef  NSArray*(^GetcityBlock)(NSString *code);
@interface TSLocateView : UIActionSheet<UIPickerViewDelegate, UIPickerViewDataSource> {
@private
    NSArray *provinces;
    //NSArray	*cities;
}
@property(nonatomic,retain)NSArray *cities;
@property(nonatomic,retain)GetcityBlock getcityBlock;
@property(nonatomic,retain)HidwaitBlock hidwaitBlock;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIPickerView *locatePicker;
@property (strong, nonatomic) TSLocation *locate;
@property (strong, nonatomic) TSLocation *city;

- (id)initWithTitle:(NSString *)title delegate:(id /*<UIActionSheetDelegate>*/)delegate provinces:(NSArray*)provincesarry citys:(NSArray*)citysarry;

- (IBAction)cancel:(id)sender;
- (void)showInView:(UIView *)view;

-(void)lodpickview;

@end
