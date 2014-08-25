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
    _progressView.transform = CGAffineTransformMakeScale(1.0f,5.0f);
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
    
    NSString* htmlStr = [NSString stringWithFormat:@"剩余:  <font color=\"red\">%d</font> 元",money];
    NSData *data = [htmlStr dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary* optionsDic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:kCTTextAlignmentRight],DTDefaultTextAlignment, [NSNumber numberWithInt:11],DTDefaultFontSize, nil];
    NSAttributedString *percentString = [[NSAttributedString alloc] initWithHTMLData:data options:optionsDic documentAttributes:nil];
    _leftMoney.attributedString = percentString;
}
@end
