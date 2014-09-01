//
//  HomeAdView.h
//  ManagerDemo
//
//  Created by xmfish on 14-8-8.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImagePlayerView.h"
@interface HomeAdView : UIView<UIScrollViewDelegate,ImagePlayerViewDelegate>
{
    NSMutableArray* _bannerInfo;
    __weak UIViewController* _superViewController;
}
@property(nonatomic,strong)NSMutableArray* bannerInfo;
@property(nonatomic, weak)UIViewController* superViewController;
@end
