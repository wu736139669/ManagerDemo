//
//  ProFitCaculateViewController.h
//  ManagerDemo
//
//  Created by xmfish on 14-9-17.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProFitCaculateViewController : UIViewController<UITextFieldDelegate,UITableViewDelegate, UITableViewDataSource>
{
    NSString* _total;
    NSString* _productCode;
    NSString* _name;
    NSString* _time;
}
@property (strong, nonatomic)NSString* name;
@property (strong, nonatomic)NSString* time;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic)NSString* productCode;
@property (strong, nonatomic)NSString* total;
@property (strong, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *totalAmount;
@property (weak, nonatomic) IBOutlet UITextField *amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *exceptLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
- (IBAction)cacluteBtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *caculateBtn;

-(void)initWithTotal:(NSString*)total withCode:(NSString*)productCode withTime:(NSString*)time withName:(NSString*)name;
@end
