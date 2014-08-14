//
//  MoveSocialCellView.h
//  ManagerDemo
//  更多界面的社交cell
//  Created by xmfish on 14-8-14.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoveSocialCellView : UIView
@property (weak, nonatomic) IBOutlet UIButton *friendBtn;
@property (weak, nonatomic) IBOutlet UIButton *attentionBtn;
@property (weak, nonatomic) IBOutlet UIButton *suggestBtn;
@property (weak, nonatomic) IBOutlet UIButton *markBtn;

- (IBAction)friendBtnClick:(id)sender;
- (IBAction)attentionBtnClick:(id)sender;
- (IBAction)suggestBtnClick:(id)sender;
- (IBAction)markBtnClick:(id)sender;

@end
