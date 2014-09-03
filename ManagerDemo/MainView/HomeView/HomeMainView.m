//
//  HomeMainView.m
//  ManagerDemo
//
//  Created by xmfish on 14-8-11.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "HomeMainView.h"
#import "MBProgressHUD+Util.h"
@implementation HomeMainView
{
    CGFloat progressPercent;
}
+(HomeMainView*)instanceHomeMainView
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"HomeMainView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code

    }
    return self;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    
    progressPercent = 0.0;
    //进度条
    _percentView.delegate = self;
    _percentView.wrapperColor = [UIColor clearColor];
    _percentView.progressColor = [UIColor redColor];
    _percentView.progressArcWidth = 10.0f;
    
    //旋转
    _typeLabel.transform = CGAffineTransformMakeRotation( M_PI/4 );
}


- (IBAction)percentBtnClick:(id)sender {
    DLog("首页点击");
    [_percentView setProgress:0.00 animated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC*0.2),
                   dispatch_get_main_queue(), ^(){
                       [_percentView setProgress:progressPercent duration:1.0];
                   
                   });
    
}
- (IBAction)sureBtnClick:(id)sender {
    [MBProgressHUD errorHudWithView:self label:@"点我没用" hidesAfter:1.0];
    DLog(@"确认");
}

-(void)setName:(NSString *)name
{
    [_nameLabel setText:name];
}
-(void)setpercent:(float)percent
{
    progressPercent = percent;
    [_percentView setProgress:percent duration:1.0];
    //中间文字
    NSString* htmlStr = [NSString stringWithFormat:@"<span  style=\"font-size:40px; color:red; text-align:center; \">%d</span>%%",(int)(percent*100.0)];
    NSData *data = [htmlStr dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary* optionsDic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:kCTTextAlignmentCenter],DTDefaultTextAlignment, nil];
    NSAttributedString *percentString = [[NSAttributedString alloc] initWithHTMLData:data options:optionsDic documentAttributes:nil];
    _percentLabel.attributedString = percentString;
}
-(void)setExpect:(float)expect
{
    //预期
    NSString* htmlStr = [NSString stringWithFormat:@"<span  style=\"font-size:11px;text-align:center; \">预期年化<span  style=\"font-size:13px; color:red;\">%.2f%%</span></span>",expect];
    NSData* data = [htmlStr dataUsingEncoding:NSUTF8StringEncoding];
    NSAttributedString* percentString = [[NSAttributedString alloc] initWithHTMLData:data documentAttributes:NULL];
    _expectLabel.attributedString = percentString;
}
-(void)setTime:(NSString*)time withStartBuy:(NSInteger)money
{

    NSCharacterSet* nonDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    time = [time stringByReplacingOccurrencesOfString:[time stringByTrimmingCharactersInSet:nonDigits] withString:[NSString stringWithFormat:@"<span  style=\"font-size:13px; color:red;\">%@</span>",[time stringByTrimmingCharactersInSet:nonDigits]]];
    //时间
    NSString* htmlStr = [NSString stringWithFormat:@"<span style=\"font-size:11px;text-align:center; \">%@<span  style=\"font-size:13px; color:red;\">%d</span>起购</span>",time,money];
    NSData* data = [htmlStr dataUsingEncoding:NSUTF8StringEncoding];
    NSAttributedString* percentString = [[NSAttributedString alloc] initWithHTMLData:data documentAttributes:NULL];
    _timeLabel.attributedString = percentString;
}
-(void)setType:(NSString *)type
{
    [_typeLabel setText:type];
}
-(void)setInfo:(NSString *)info
{
    [_infoLabel setText:info];
}
-(void)setSecurityDesc:(NSString *)securityDesc
{
    [_securityDescLabel setText:securityDesc];
}
#pragma mark - CABasicAnimationDelegate

- (void)animationDidStart:(CAAnimation *)theAnimation
{
    DLog(@"Animation started");
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag
{
    DLog(@"Animation stopped");
}
@end
