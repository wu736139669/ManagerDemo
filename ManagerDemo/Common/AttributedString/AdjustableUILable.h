//
//  AdjustableUILable.h
//  ManagerDemo
//
//  Created by xmfish on 14-8-12.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdjustableUILable : UILabel
{
    CGFloat _characterSpacing;
}

@property(nonatomic, assign) CGFloat characterSpacing;
@end
