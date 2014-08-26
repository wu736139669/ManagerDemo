//
//  HomeAdView.m
//  ManagerDemo
//
//  Created by xmfish on 14-8-8.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "HomeAdView.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation HomeAdView
{
    ImagePlayerView* imagePlayerView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    imagePlayerView = [[ImagePlayerView alloc] init];
    imagePlayerView.frame = frame;
    [imagePlayerView initWithCount:4 delegate:self];
    [self addSubview:imagePlayerView];
    
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code

}

-(void)setBannerInfo:(NSMutableArray *)bannerInfo
{
    _bannerInfo = bannerInfo;
    [imagePlayerView initWithCount:bannerInfo.count delegate:self];
}
#pragma mark ImagePlayerDelegate
- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView loadImageForImageView:(UIImageView *)imageView index:(NSInteger)index
{
    [imageView sd_setImageWithURL:[[_bannerInfo objectAtIndex:index]objectForKey:@"url"] placeholderImage:[UIImage imageNamed:@"ad1"]];
}
- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView didTapAtIndex:(NSInteger)index
{
    DLog(@"%@",[_bannerInfo objectAtIndex:index]);
}
@end
