//
//  HdScrollView.h
//  ScrollView
//
//  Created by Hu Di on 13-10-11.
//  Copyright (c) 2013年 Sanji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HdPageControl.h"
@protocol HDScrollviewDelegate <NSObject>
-(void)TapView:(int)index;
@end

@interface HDScrollview : UIScrollView<UIScrollViewDelegate>

@property (nonatomic, strong) NSTimer *autoScrollTimer;
@property (nonatomic,strong) HdPageControl *pagecontrol;
@property (nonatomic,assign) NSInteger currentPageIndex;
@property (assign,nonatomic) id<HDScrollviewDelegate> HDdelegate;
@property (nonatomic, assign) BOOL autoScroll;  // default is YES, set NO to turn off autoScroll
@property (nonatomic, assign) NSUInteger scrollInterval;
/**
 *	@brief	不循环
 */
-(id)initWithFrame:(CGRect)frame withImageView:(NSMutableArray *)imageview;

/**
 *	@brief	循环滚动
 */
-(id)initLoopScrollWithFrame:(CGRect)frame withImageView:(NSMutableArray *)imageview;
-(void)HDscrollViewDidScroll;
-(void)HDscrollViewDidEndDecelerating;
@end

@interface UIImageView (CopyImageview)<NSCoding>
@end


