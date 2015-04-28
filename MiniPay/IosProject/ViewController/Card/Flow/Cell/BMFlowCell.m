//
//  BMFlowCell.m
//  MiniPay
//
//  Created by apple on 14-7-26.
//  Copyright (c) 2014年 allen. All rights reserved.
//

#import "BMFlowCell.h"
#import "BMFlowModel.h"
@interface BMFlowCell ()

@end

@implementation BMFlowCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setData:(BMFlowModel *)model index:(int)index flowType:(int)type{
    switch (type) {
        case 0:
           _titleLable.text=@"转账时间";
           _titleLable1.text=@"收款卡卡号";
           _titleLable2.text=@"转账金额";
           _titleLable3.text=@"交易状态";
            break;
        case 1:
            _titleLable.text=@"还款时间";
            _titleLable1.text=@"信用卡卡号";
            _titleLable2.text=@"还款金额";
            _titleLable3.text=@"还款状态";
            break;
        case 2:
            _titleLable.text=@"充值时间";
            _titleLable1.text=@"手机号";
            _titleLable2.text=@"充值金额";
            _titleLable3.text=@"充值状态";
            break;
        case 3:
            _titleLable.text=@"提现时间";
            _titleLable1.text=@"提现方式";
            _titleLable2.text=@"提现金额";
            _titleLable3.text=@"手续费";
            break;
            
        default:
            break;
    }
    
    double rmd=[model.TXNAMT doubleValue];
    NSString *money=[NSString stringWithFormat:@"%.2f",rmd];
    [_coentLable2 setText:[NSString stringWithFormat:@"￥%@",money]];
    NSString *cardNo=model.CRDNO;
    for(int i=4;i<model.CRDNO.length-4;i++){
        NSRange range=NSMakeRange(i, 1);
        cardNo=[cardNo stringByReplacingCharactersInRange:range withString:@"*"];
    }
    [_coentLable1 setText:cardNo];
    
    NSString *date=[NSString stringWithFormat:@"%@   %@",[ValueUtils formatDateString:model.SYSDAT from:@"yyyyMMddHHmmss" to:@"yyyy-MM-dd HH:mm"],[ValueUtils getWeekDay1:model.SYSDAT]];
     [_coentLable setText:date];
    
     NSString *TXNSTS=model.TXNSTS;
    if(type!=3)
    {
      if([@"S" isEqualToString:TXNSTS])
      {
       TXNSTS=@"成功！";
      }
      else
      {
        TXNSTS=@"失败！";
       }
    }
    else
    {
         double rmd=[TXNSTS doubleValue];
        TXNSTS=[NSString stringWithFormat:@"%.2f",rmd];

    }
    
    switch (type) {
        case 0:
            [_coentLable3 setText:[NSString stringWithFormat:@"转账%@",TXNSTS]];
          break;
        case 1:
            [_coentLable3 setText:[NSString stringWithFormat:@"还款%@",TXNSTS]];
           break;
        case 2:
           [_coentLable3 setText:[NSString stringWithFormat:@"充值%@",TXNSTS]];
            break;
        case 3:
            [_coentLable3 setText:[NSString stringWithFormat:@"¥%@",TXNSTS]];
            break;
            
        default:
            break;
    }

}


@end
