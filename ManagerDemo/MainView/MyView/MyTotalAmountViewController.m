//
//  MyTotalAmountViewController.m
//  ManagerDemo
//
//  Created by xmfish on 14-9-10.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "MyTotalAmountViewController.h"

@interface MyTotalAmountViewController ()

@end

@implementation MyTotalAmountViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _totalAmount = 0.0;
        _holdAmount = 0.0;
        _accBalance = 0.0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _holdAmountView.progressColor = [UIColor redColor];
    _holdAmountView.wrapperColor = Touch_BackGroudColor;
    _holdAmountView.wrapperArcWidth = 5.0;
    _holdAmountView.progressArcWidth = 5.0;
    _accBalanceView.progressColor = [UIColor redColor];
    _accBalanceView.wrapperColor = Touch_BackGroudColor;
    _accBalanceView.wrapperArcWidth = 5.0;
    _accBalanceView.progressArcWidth = 5.0;
    [self setTotalAmount:_totalAmount withHoldAmount:_holdAmount withAccBalance:_accBalance];
}
-(void)setTotalAmount:(float)totalAmount withHoldAmount:(float)holdAmount withAccBalance:(float)accBalance
{
    _totalAmount = totalAmount;
    _holdAmount = holdAmount;
    _accBalance = accBalance;
    _holdAmountLabel.attributedString = [self getPercentStr:holdAmount/totalAmount withColor:@"red"];
    _accBalanceLabel.attributedString = [self getPercentStr:accBalance/totalAmount withColor:@"red"];
    [_holdAmountView setProgress:holdAmount/totalAmount animated:YES];
    [_accBalanceView setProgress:accBalance/totalAmount animated:YES];
}

-(NSAttributedString*)getPercentStr:(float)percent withColor:(NSString*)colorStr
{
    if (percent <=0 ) {
        colorStr = @"lightgray";
    }
    NSString* htmlStr = [NSString stringWithFormat:@"<span  style=\"font-size:40px; color:%@; text-align:center; \">%d</span>%%",colorStr,(int)(percent*100.0)];
    NSData *data = [htmlStr dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary* optionsDic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:kCTTextAlignmentCenter],DTDefaultTextAlignment, nil];
    NSAttributedString *percentString = [[NSAttributedString alloc] initWithHTMLData:data options:optionsDic documentAttributes:nil];
    return percentString;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
