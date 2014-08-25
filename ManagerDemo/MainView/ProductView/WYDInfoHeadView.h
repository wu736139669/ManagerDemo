//
//  WYDInfoHeadView.h
//  ManagerDemo
//
//  Created by xmfish on 14-8-15.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WYDInfoHeadView : UIView
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet DTAttributedLabel *hasPercent;
@property (weak, nonatomic) IBOutlet DTAttributedLabel *leftMoney;


-(void)setProgress:(CGFloat)progress;
-(void)setLeftMoneyAccount:(NSInteger)money;
@end
