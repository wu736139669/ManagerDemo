//
//  HomeAdView.h
//  ManagerDemo
//
//  Created by xmfish on 14-8-8.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HDScrollview.h"
#import "ImagePlayerView.h"
@interface HomeAdView : UIView<HDScrollviewDelegate,UIScrollViewDelegate,ImagePlayerViewDelegate>
{
    HDScrollview* _scrollview;
}
@property(strong, nonatomic)HDScrollview* scrollview;
@end
