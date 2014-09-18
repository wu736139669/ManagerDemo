//
//  SetPassWordViewController.h
//  ManagerDemo
//
//  Created by xmfish on 14-9-18.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "ViewController.h"

@interface SetPassWordViewController : ViewController<UITextFieldDelegate>
{
    NSInteger _type;
}
@property (assign, nonatomic)NSInteger type;
@property (weak, nonatomic) IBOutlet UITextField *passWordTextField;
@property (weak, nonatomic) IBOutlet UITextField *surePassWordTextField;
- (IBAction)completeBtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *completeBtn;

@end
