//
//  HomeAdView.m
//  ManagerDemo
//
//  Created by xmfish on 14-8-8.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "HomeAdView.h"
#import "SVWebViewController.h"
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
    [imagePlayerView initWithCount:5 delegate:self];
    [self addSubview:imagePlayerView];
    _superViewController = nil;
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
    if (imagePlayerView) {
        [imagePlayerView removeFromSuperview];
        imagePlayerView = nil;
    }
    imagePlayerView = [[ImagePlayerView alloc] init];
    imagePlayerView.frame = self.frame;
    [self addSubview:imagePlayerView];
    _bannerInfo = bannerInfo;
    [imagePlayerView initWithCount:bannerInfo.count delegate:self];
}
#pragma mark ImagePlayerDelegate
- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView loadImageForImageView:(UIImageView *)imageView index:(NSInteger)index
{
    [imageView sd_setImageWithURL:[[_bannerInfo objectAtIndex:index]objectForKey:@"bannerUrl"] placeholderImage:[UIImage imageNamed:@"adview"]];
}
- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView didTapAtIndex:(NSInteger)index
{

    if (_superViewController) {
        SVWebViewController* webViewController = [[SVWebViewController alloc] initWithURL:[NSURL URLWithString:[[_bannerInfo objectAtIndex:index] objectForKey:@"contUrl"]]];
        webViewController.hidesBottomBarWhenPushed = YES;
        [_superViewController.navigationController pushViewController:webViewController animated:YES];
    }
}
@end
