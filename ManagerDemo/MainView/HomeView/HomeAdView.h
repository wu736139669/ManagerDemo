//
//  HomeAdView.h
//  ManagerDemo
//
//  Created by xmfish on 14-8-8.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HDScrollview.h"
@interface HomeAdView : UIView<HDScrollviewDelegate,UIScrollViewDelegate>
{
    HDScrollview* _scrollview;
}
@end
