//
//  HomeAdView.m
//  ManagerDemo
//
//  Created by xmfish on 14-8-8.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "HomeAdView.h"

@implementation HomeAdView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    ImagePlayerView* imagePlayerView = [[ImagePlayerView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    imagePlayerView.autoScroll = YES;
    imagePlayerView.scrollInterval = 5;
    [imagePlayerView setPageControlPosition:ICPageControlPosition_BottomCenter];
    [imagePlayerView initWithCount:3 delegate:self];
    [self addSubview:imagePlayerView];
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
#pragma mark ImagePlayerViewDelegate
-(void)imagePlayerView:(ImagePlayerView *)imagePlayerView loadImageForImageView:(UIImageView *)imageView index:(NSInteger)index{
    
    [imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"ad%ld",index+1]]];
}
-(void)imagePlayerView:(ImagePlayerView *)imagePlayerView didTapAtIndex:(NSInteger)index{
    
}
@end
