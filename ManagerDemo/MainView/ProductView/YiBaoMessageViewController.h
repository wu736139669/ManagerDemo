//
//  YiBaoMessageViewController.h
//  ManagerDemo
//
//  Created by xmfish on 14/11/10.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YiBaoMessageViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *orderId;
@property (weak, nonatomic) IBOutlet UITextField *ybVerCode;
- (IBAction)completeBtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *completeBtn;

@end
