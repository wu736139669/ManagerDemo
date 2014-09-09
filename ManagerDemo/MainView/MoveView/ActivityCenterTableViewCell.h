//
//  ActivityCenterTableViewCell.h
//  ManagerDemo
//
//  Created by xmfish on 14-9-1.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityCenterTableViewCell : UITableViewCell
{
    NSString* _activeUrl;
    NSString* _state;
    NSString* _activeTitle;
    NSInteger _activeType;
}
@property (strong, nonatomic) NSString* activeUrl;
@property (strong, nonatomic) NSString* state;
@property (strong, nonatomic) NSString* activeTitle;
@property (assign, nonatomic) NSInteger activeType;
@property (weak, nonatomic) IBOutlet UIImageView *infoImageView;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

@end
