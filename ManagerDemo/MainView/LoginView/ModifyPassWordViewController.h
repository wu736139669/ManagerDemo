//
//  ModifyPassWordViewController.h
//  ManagerDemo
//
//  Created by xmfish on 14-9-25.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModifyPassWordViewController : UIViewController<UITextFieldDelegate>
{
    NSInteger _type;
    NSString* _phoneNum;
}
@property (strong, nonatomic)NSString* phoneNum;
@property (weak, nonatomic) IBOutlet UITextField *nameTextFiel;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *idCardTextField;
@property (weak, nonatomic) IBOutlet UIButton *cmsBtn;
- (IBAction)cmsBtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *blackGroudView;
@property (weak, nonatomic) IBOutlet UITextField *cmsNumTextField;
- (IBAction)nextBtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property(assign, nonatomic)NSInteger type;
@end
