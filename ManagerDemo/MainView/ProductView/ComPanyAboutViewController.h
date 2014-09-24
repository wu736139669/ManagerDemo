//
//  ComPanyAboutViewController.h
//  ManagerDemo
//
//  Created by xmfish on 14-9-24.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComPanyAboutViewController : UIViewController
{
    NSString* _comPanyName;
    NSString* _jjComPanyNameStr;
    NSString* _xsComPanyNameStr;
    NSString* _fundStateStr;
    NSString* _fundTypeStr;
    NSString* _detailInfo1;
    NSString* _detailInfo2;
    NSString* _detailInfo3;
    NSString* _iconUrlStr;
}
@property (strong, nonatomic)NSString* comPanyName;
@property (strong, nonatomic)NSString* jjComPanyNameStr;
@property (strong, nonatomic)NSString* xsComPanyNameStr;
@property (strong, nonatomic)NSString* fundStateStr;
@property (strong, nonatomic)NSString* fundTypeStr;
@property (strong, nonatomic)NSString* detailInfo1;
@property (strong, nonatomic)NSString* detailInfo2;
@property (strong, nonatomic)NSString* detailInfo3;
@property (strong, nonatomic)NSString* iconUrlStr;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *jjComPanyName;
@property (weak, nonatomic) IBOutlet UILabel *xsComPanyName;
@property (weak, nonatomic) IBOutlet UILabel *fundState;
@property (weak, nonatomic) IBOutlet UILabel *fundType;

@property (weak, nonatomic) IBOutlet UILabel *infoLabel1;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel2;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel3;
@property (weak, nonatomic) IBOutlet UIImageView *comPanyIcon;
@end
