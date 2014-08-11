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
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet MRCircularProgressView *percentView;
- (IBAction)percentBtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet DTAttributedLabel *percentLabel;
@property (weak, nonatomic) IBOutlet DTAttributedLabel *expectLabel;
@property (weak, nonatomic) IBOutlet DTAttributedLabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
- (IBAction)sureBtnClick:(id)sender;

@end
