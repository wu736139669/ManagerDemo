//
//  LoanListCell.m
//  ManagerDemo
//
//  Created by xmfish on 14-8-12.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "LoanListCell.h"

@implementation LoanListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)awakeFromNib
{
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC*1.0),
//                   dispatch_get_main_queue(), ^(){
//                       [self initView];
//                   });
    [self initView];
}
-(void)initView
{
    _percentView.wrapperColor = [UIColor clearColor];
    _percentView.progressColor = [UIColor redColor];
    _percentDtlabel.backgroundColor = [UIColor clearColor];
    //旋转
    _typeLabel.transform = CGAffineTransformMakeRotation( M_PI/4);
}
-(void)setPercent:(NSInteger) percent
{
    NSString* htmlStr = [NSString stringWithFormat:@"<span  style=\"font-size:20px; color:red; text-align:center; \">%ld</span> %%",percent];
    NSData *data = [htmlStr dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary* optionsDic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:kCTTextAlignmentCenter],DTDefaultTextAlignment, nil];
    NSAttributedString *percentString = [[NSAttributedString alloc] initWithHTMLData:data options:optionsDic documentAttributes:nil];
    _percentDtlabel.attributedString = percentString;
    CGRect frame = _percentDtlabel.frame;
    CGSize size = [_percentDtlabel suggestedFrameSizeToFitEntireStringConstraintedToWidth:_percentDtlabel.frame.size.width];
    frame.size.height = size.height+2;
    _percentDtlabel.frame = frame;
    _percentDtlabel.center = _pieImage.center;
    [_percentView setProgress:percent/100.0 animated:NO];
}
-(void)setTimeWithString:(NSString*)htmlString
{
    
    NSData *data = [htmlString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary* optionsDic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:kCTTextAlignmentLeft],DTDefaultTextAlignment, nil];
    NSAttributedString *percentString = [[NSAttributedString alloc] initWithHTMLData:data options:optionsDic documentAttributes:nil];
    _timeDtLabel.attributedString = percentString;
}
-(void)setStartBuy:(NSInteger)price
{
    _priceLabel.text = [NSString stringWithFormat:@"%d元起购",price];
}
-(void)setInfoDic:(NSDictionary *)dic
{

    self.productId = [dic objectForKeyWithoutNull:@"id"];
    self.profitLabel.text = [NSString stringWithFormat:@"%.2f%%",[[dic objectForKeyWithoutNull:@"nhsy"] floatValue]];
    self.nameLabel.text = [dic objectForKeyWithoutNull:@"proName"];
    if ([[dic objectForKeyWithoutNull:@"tip"] isKindOfClass:[NSNull class]]) {
        self.typeLabel.text = @"";
    }else{
        self.typeLabel.text = [dic objectForKeyWithoutNull:@"tip"];
    }
//    if ([[dic objectForKey:@"state"] integerValue] == 1 ) {
        [self setPercent:[[dic objectForKeyWithoutNull:@"percent"] floatValue]];
        [self setStartBuy:[[dic objectForKeyWithoutNull:@"startBuy"] integerValue]];
        NSString* timeStr = [NSString stringWithFormat:@"<span  style=\" color:green;\">限</span>%@个月起",[dic objectForKeyWithoutNull:@"timeLimit"]];
        [self setTimeWithString:timeStr];
//    }
//    else if([[dic objectForKey:@"state"] integerValue] == 2){
//        [self setTimeWithString:@"最近还款日"];
//        [_percentView setProgress:0 animated:NO];
//        NSString* htmlStr = [NSString stringWithFormat:@"<span  style=\" text-align:center; \">%@</span> ",[dic objectForKey:@"percent"]];
//        htmlStr = [htmlStr stringByReplacingOccurrencesOfString:@"\n" withString:@"<p></p>"];
//        NSData *data = [htmlStr dataUsingEncoding:NSUTF8StringEncoding];
//        NSDictionary* optionsDic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:kCTTextAlignmentCenter],DTDefaultTextAlignment, nil];
//        NSAttributedString *percentString = [[NSAttributedString alloc] initWithHTMLData:data options:optionsDic documentAttributes:nil];
//        _percentDtlabel.attributedString = percentString;
//        CGRect frame = _percentDtlabel.frame;
//        CGSize size = [_percentDtlabel suggestedFrameSizeToFitEntireStringConstraintedToWidth:60.0];
//        frame.size.height = size.height+2;
//        _percentDtlabel.frame = frame;
//        _percentDtlabel.center = _pieImage.center;
//        _priceLabel.text = [dic objectForKey:@"startTime"];
//    }else if ([[dic objectForKey:@"state"] integerValue] == 3)
//    {
//        [self setPercent:[[dic objectForKey:@"percent"] floatValue]];
//        [self setStartBuy:[[dic objectForKey:@"startBuy"] integerValue]];
//        NSString* htmlStr = [NSString stringWithFormat:@"<span  style=\" text-align:center; \">%@</span> ",[dic objectForKey:@"percent"]];
//        htmlStr = [htmlStr stringByReplacingOccurrencesOfString:@"\n" withString:@"<p></p>"];
//        NSData *data = [htmlStr dataUsingEncoding:NSUTF8StringEncoding];
//        NSDictionary* optionsDic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:kCTTextAlignmentCenter],DTDefaultTextAlignment, nil];
//        NSAttributedString *percentString = [[NSAttributedString alloc] initWithHTMLData:data options:optionsDic documentAttributes:nil];
//        _percentDtlabel.attributedString = percentString;
//        CGRect frame = _percentDtlabel.frame;
//        CGSize size = [_percentDtlabel suggestedFrameSizeToFitEntireStringConstraintedToWidth:_percentDtlabel.frame.size.width];
//        frame.size.height = size.height;
//        _percentDtlabel.frame = frame;
//        _percentDtlabel.center = _pieImage.center;
//
//    }

}
@end
