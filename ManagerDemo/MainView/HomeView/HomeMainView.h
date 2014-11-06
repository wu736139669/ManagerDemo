//
//  HomeMainView.h
//  ManagerDemo
//
//  Created by xmfish on 14-8-11.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MRCircularProgressView.h"
@interface HomeMainView : UIView
{
    NSString* _fundCode;
    __weak UIViewController* _delegate;
}
@property (weak, nonatomic)UIViewController* delegate;
@property (strong, nonatomic)NSString* fundCode;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UILabel *baoLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet MRCircularProgressView *percentView;
- (IBAction)percentBtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet DTAttributedLabel *percentLabel;
@property (weak, nonatomic) IBOutlet DTAttributedLabel *expectLabel;
@property (weak, nonatomic) IBOutlet DTAttributedLabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
- (IBAction)sureBtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *securityDescLabel;
@property (weak, nonatomic) IBOutlet UIImageView *tipImg;



+(HomeMainView*) instanceHomeMainView;
-(void)setName:(NSString*)name;
-(void)setpercent:(float)percent;
-(void)setExpect:(float)expect;
-(void)setType:(NSString*)type;
-(void)setInfo:(NSString*)info;
-(void)setSecurityDesc:(NSString*)securityDesc;
-(void)setTime:(NSString*)time withStartBuy:(NSInteger)money;
-(void)setTipColor:(NSString*)tipColor;

@end
