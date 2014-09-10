//
//  WYDInfoHeadView.m
//  ManagerDemo
//
//  Created by xmfish on 14-8-15.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "WYDInfoHeadView.h"

@implementation WYDInfoHeadView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    _progressView.transform = CGAffineTransformMakeScale(1.0f,8.0f);
    _hasPercent.backgroundColor = [UIColor clearColor];
    _leftMoney.backgroundColor = [UIColor clearColor];
    [self setProgress:0.336];
    [self setLeftMoneyAccount:6589650];
}


-(void)setProgress:(CGFloat)progress
{
    _progressView.progress = progress;
    //中间文字
    NSString* htmlStr = [NSString stringWithFormat:@"已融资<font color=\"red\">%.1f</font>%%",progress*100.0];
    NSData *data = [htmlStr dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary* optionsDic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:kCTTextAlignmentLeft],DTDefaultTextAlignment, [NSNumber numberWithInt:11],DTDefaultFontSize, nil];
    NSAttributedString *percentString = [[NSAttributedString alloc] initWithHTMLData:data options:optionsDic documentAttributes:nil];
    _hasPercent.attributedString = percentString;
    
}
-(void)setLeftMoneyAccount:(NSInteger)money
{
    
    NSString* htmlStr = [NSString stringWithFormat:@"剩余:  <font color=\"red\">%ld</font> 元",money];
    NSData *data = [htmlStr dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary* optionsDic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:kCTTextAlignmentRight],DTDefaultTextAlignment, [NSNumber numberWithInt:11],DTDefaultFontSize, nil];
    NSAttributedString *percentString = [[NSAttributedString alloc] initWithHTMLData:data options:optionsDic documentAttributes:nil];
    _leftMoney.attributedString = percentString;
}
-(void)setInfoWithDic:(NSDictionary *)dic
{
    //计算总数.
    NSInteger totalCount = [[dic objectForKey:@"total"] integerValue];
    NSString* totalStr = @".00";
    while (totalCount>0) {
        totalStr = [[NSString stringWithFormat:@"%ld",totalCount%10] stringByAppendingString:totalStr];
        totalCount = totalCount/10;
        if (totalCount>0 && (totalStr.length-2)%4==0 && totalStr.length>=6) {
            totalStr = [@"," stringByAppendingString:totalStr];
        }
    }
    _totalCountLabel.text = totalStr;
    //设置剩余
    [self setProgress:[[dic objectForKey:@"freeze"] floatValue]/[[dic objectForKey:@"total"] floatValue]];
    //设置已经融资
    [self setLeftMoneyAccount:[[dic objectForKey:@"avaiable"] integerValue]];
    //设置预期年化
    _expectLabel.text = [dic objectForKey:@"nhsy"];
    _startBuyLabel.text = [dic objectForKey:@"startBuy"];
    _profitDescLabel.text = [dic objectForKey:@"profitDesc"];
    _benxiLabel.text = [dic objectForKey:@"benxiDesc"];
    _fundPeriodDescLabel.text = [dic objectForKey:@"fundPeriodDesc"];
    _securityTipLabel.text = [dic objectForKey:@"securityTip"];
    _specialBlackDescLabel.text = [dic objectForKey:@"specialBlackDesc"];
}
@end
