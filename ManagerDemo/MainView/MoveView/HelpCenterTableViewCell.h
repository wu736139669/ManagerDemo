//
//  HelpCenterTableViewCell.h
//  ManagerDemo
//
//  Created by xmfish on 14-9-1.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelpCenterTableViewCell : UITableViewCell
{
    BOOL _top;
    NSString* _helpUrl;
}
@property (strong, nonatomic)NSString* helpUrl;
@property (assign, nonatomic)BOOL top;
@property (weak, nonatomic) IBOutlet UITextView *infoTextView;
@property (weak, nonatomic) IBOutlet UILabel *helpTitle;

@end
