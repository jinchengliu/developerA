//
//  FlowCell.m
//  MiniPay
//
//  Created by allen on 13-11-18.
//  Copyright (c) 2013年 allen. All rights reserved.
//

#import "FlowCell.h"
#import "ValueUtils.h"

@implementation FlowCell
@synthesize delegate=_delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}


//交易详情
-(void)tradeDetail{
    
    if([_delegate respondsToSelector:@selector(cellDidBtn:type:)]){
        [_delegate cellDidBtn:_detailBtn.tag type:0];
    }
}

//撤销交易
-(void)cancelDetail{
    
    if([_delegate respondsToSelector:@selector(cellDidBtn:type:)]){
        [_delegate cellDidBtn:_cancelBtn.tag type:1];
    }
}

-(void)setShow{
    
    [_detailBtn addTarget:self action:@selector(tradeDetail) forControlEvents:UIControlEventTouchUpInside];
    [_cancelBtn addTarget:self action:@selector(cancelDetail) forControlEvents:UIControlEventTouchUpInside];
}


-(void)setData:(Response_199008_Model *)model index:(int)index{
    
    double rmd=[model.TXNAMT doubleValue]/100;
    NSString *money=[NSString stringWithFormat:@"%.2f",rmd];
    [_moneyTextView setText:[NSString stringWithFormat:@"￥%@",money]];
    NSString *cardNo=model.CRDNO;
    for(int i=4;i<model.CRDNO.length-4;i++){
        NSRange range=NSMakeRange(i, 1);
        cardNo=[cardNo stringByReplacingCharactersInRange:range withString:@"*"];
    }
    [_cardNoTextView setText:cardNo];
    
    NSString *date=[NSString stringWithFormat:@"%@   %@",[ValueUtils formatDateString:model.SYSDAT from:@"yyyyMMddHHmmss" to:@"yyyy-MM-dd HH:mm:ss"],[ValueUtils getWeekDay1:model.SYSDAT]];
    [_dateLabel setText:date];
    [_cancelBtn setTag:index];
    [_detailBtn setTag:index];
    //判断当前状态
    NSString *TXNCD=model.TXNCD;
    NSString *TXNSTS=model.TXNSTS;
    
    NSString *SYSDAT=[NSString stringWithFormat:@"%@",[ValueUtils formatDateString:model.SYSDAT from:@"yyyyMMddHHmmss" to:@"yyyyMMdd"]];
    NSString *nowDate=[ValueUtils currentDayStringFormatyyyyMMdd];
    _cancelBtn.hidden=YES;
    if([@"0200000000" isEqualToString:TXNCD] && [@"S" isEqualToString:TXNSTS]){
        
        _statusLabel.text=@"交易成功";
        if([nowDate isEqualToString:SYSDAT]){
           // _cancelBtn.hidden=NO;
        }
        
    }
   else if([@"0200000000" isEqualToString:TXNCD] && ![@"S" isEqualToString:TXNSTS]){
        
        _statusLabel.text=@"交易失败";
        if([nowDate isEqualToString:SYSDAT]){
            // _cancelBtn.hidden=NO;
        }
    }
   else if([@"0200020010" isEqualToString:TXNCD] && [@"S" isEqualToString:TXNSTS]){
        _statusLabel.text=@"消费成功";
        if([nowDate isEqualToString:SYSDAT]){
            // _cancelBtn.hidden=NO;
        }
    }
   else if([@"0200020010" isEqualToString:TXNCD] && ![@"S" isEqualToString:TXNSTS]){
       _statusLabel.text=@"消费失败";
       if([nowDate isEqualToString:SYSDAT]){
           // _cancelBtn.hidden=NO;
       }
       
   }
    else if([@"0200200000" isEqualToString:TXNCD] && [@"S" isEqualToString:TXNSTS]){
        _statusLabel.text=@"撤销成功";
        
    }else{
        _statusLabel.text=@"";
    }
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
