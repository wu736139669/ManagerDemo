//
//  HomeAdView.m
//  ManagerDemo
//
//  Created by xmfish on 14-8-8.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "HomeAdView.h"
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

#pragma mark ImagePlayerDelegate
- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView loadImageForImageView:(UIImageView *)imageView index:(NSInteger)index
{
    [imageView setImage:[imageArray objectAtIndex:index]];
}
@end
