//
//  MessageCenterTableViewCell.h
//  ManagerDemo
//
//  Created by xmfish on 14-9-3.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageCenterTableViewCell : UITableViewCell
{
    NSString* _msgId;
    NSInteger _msgState;
}
@property (strong, nonatomic)NSString* msgId;
@property (assign, nonatomic)NSInteger msgState;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;


@end
