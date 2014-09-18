//
//  ToolBarView.h
//  ManagerDemo
//
//  Created by xmfish on 14-8-27.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TollBarViewDelegate <NSObject>

-(void)caculateProfit;
-(void)buyFund;
@end

@interface ToolBarView : UIView
{
    __weak id<TollBarViewDelegate> _delegate;
}
@property (weak, nonatomic)id<TollBarViewDelegate> delegate;
-(void)setEnable:(BOOL)enable;
@end
