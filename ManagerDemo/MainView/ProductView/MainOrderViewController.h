//
//  MainOrderViewController.h
//  ManagerDemo
//
//  Created by xmfish on 14-9-18.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "ViewController.h"

@interface MainOrderViewController : ViewController<UITextFieldDelegate>
{
    NSString* _productId;
    NSString* _productName;
    NSInteger _timeLimitNum;
    NSInteger _startBuy;
    NSInteger _type;
}
@property (assign, nonatomic)NSInteger type;
@property (strong, nonatomic)NSString* productId;
@property (assign, nonatomic)NSInteger timeLimitNum;
@property (assign, nonatomic)NSInteger startBuy;
@property (strong, nonatomic)NSString* productName;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *startBuyLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLimit;
@property (weak, nonatomic) IBOutlet UITextField *orderAmountTextField;
@property (weak, nonatomic) IBOutlet UIView *backgroudView;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UIButton *completeBtn;
- (IBAction)completeBtnClick:(id)sender;

@end
