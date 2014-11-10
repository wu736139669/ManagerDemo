//
//  OrderPassWordViewController.h
//  ManagerDemo
//
//  Created by xmfish on 14-9-18.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "ViewController.h"
#import "UPPayPlugin.h"
@interface OrderPassWordViewController : ViewController<UITextFieldDelegate,UPPayPluginDelegate>
{
    NSInteger _amount;
    NSString* _proId;
}
@property (assign, nonatomic)NSInteger amount;
@property (strong, nonatomic)NSString* proId;
@property (strong, nonatomic)NSString* cardNo;
@property (assign, nonatomic)NSInteger type;
@property (assign, nonatomic)NSInteger bindid;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UILabel *cardNoLabel;
- (IBAction)completeBtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *completeBtn;

@end
