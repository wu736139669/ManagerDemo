//
//  HomeAdView.m
//  ManagerDemo
//
//  Created by xmfish on 14-8-8.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "HomeAdView.h"
#import "HDScrollview.h"
@implementation HomeAdView
{
    NSArray *imageArray;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    imageArray=@[[UIImage imageNamed:@"ad1"],[UIImage imageNamed:@"ad2"],[UIImage imageNamed:@"ad3"],[UIImage imageNamed:@"ad4"]];
    NSMutableArray* imageViewArray = [[NSMutableArray alloc] init];
    for (int i=0; i<imageArray.count; i++) {
        UIImageView *imageview=[[UIImageView alloc]init];
        imageview.image=[imageArray objectAtIndex:i];
        imageview.contentMode=UIViewContentModeScaleAspectFit;
        [imageViewArray addObject:imageview];
    }
    
    ImagePlayerView* imagePlayerView = [[ImagePlayerView alloc] init];
    imagePlayerView.frame = frame;
    [imagePlayerView initWithCount:4 delegate:self];
//
    [self addSubview:imagePlayerView];
    //    _scrollview=[[HDScrollview alloc]initLoopScrollWithFrame:frame withImageView:imageViewArray];
//    _scrollview.delegate=self;
//    _scrollview.HDdelegate=self;
//    [self addSubview:_scrollview];
//    _scrollview.pagecontrol.frame=CGRectMake(0, _scrollview.pagecontrol.frame.origin.y+_scrollview.frame.size.height-10, 320, 10);
//    _scrollview.pagecontrol.currentcolor=[UIColor brownColor];
//    _scrollview.pagecontrol.othercolor=[UIColor whiteColor];
//    _scrollview.pagecontrol.currentPage=0;
//    [_scrollview setScrollInterval:5];
//    [self addSubview:_scrollview.pagecontrol];
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark ==========UIScrollViewDelegate============

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    // disable v direction scroll

    [_scrollview HDscrollViewDidScroll];

    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)_scrollView
{
    [_scrollview HDscrollViewDidEndDecelerating];
}
-(void)TapView:(int)index
{
    DLog(@"点击了第%d个页面",index);
    //下面可以根据自己的需求操作
    //Example

}
#pragma mark ImagePlayerDelegate
- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView loadImageForImageView:(UIImageView *)imageView index:(NSInteger)index
{
    [imageView setImage:[imageArray objectAtIndex:index]];
}
@end
