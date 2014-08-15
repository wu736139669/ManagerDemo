//
//  HdScrollView.m
//  ScrollView
//
//  Created by Hu Di on 13-10-11.
//  Copyright (c) 2013年 Sanji. All rights reserved.
//

#import "HDScrollview.h"
@interface HDScrollview()
{
    BOOL loop;
    NSMutableArray *imageArray;
}
@end
@implementation HDScrollview

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.scrollsToTop = NO;
        self.pagingEnabled=YES;
        self.bounces=NO;
        self.userInteractionEnabled=YES;
        [self setContentOffset:CGPointMake(0, 0)];
        [self setContentOffset:CGPointMake(self.frame.size.width, 0)];
        UITapGestureRecognizer *Recognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
        Recognizer.numberOfTapsRequired=1;
        [self addGestureRecognizer:Recognizer];
        
        if (!self.pagecontrol) {
            self.pagecontrol=[[HdPageControl alloc]init];
            self.pagecontrol.currentPage=0;//当前页数
            self.pagecontrol.userInteractionEnabled = YES;
            [self.pagecontrol addTarget:self action:@selector(pageTurn:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame withImageView:(NSMutableArray *)imageviewarr
{
    self = [self initWithFrame:frame];
    if (self)
    {
    }
    imageArray=[[NSMutableArray alloc] initWithArray:imageviewarr];
    loop=NO;
    NSUInteger pageCount=[imageviewarr count];
    [self setContentSize:CGSizeMake(self.frame.size.width*pageCount, self.frame.size.height)];
    
    CGRect bounds=self.frame;
    for (int i=0; i<pageCount; i++) {
        bounds.origin.x=bounds.size.width*i;
        UIImageView *imageview=[imageviewarr objectAtIndex:i];
        imageview.userInteractionEnabled=YES;
        imageview.frame=bounds;
        [self addSubview:imageview];
    }
    
    self.pagecontrol.numberOfPages=pageCount;//总的图片页数
    [self.pagecontrol addObserver:self forKeyPath:@"currentPage" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
    return self;
}

-(id)initLoopScrollWithFrame:(CGRect)frame withImageView:(NSMutableArray *)ArrImageView
{
    self = [self initWithFrame:frame];
    if (self)
    {
        
    }
    loop=YES;
    imageArray=ArrImageView;
    NSMutableArray *tempArray=[NSMutableArray arrayWithArray:ArrImageView];
    //深拷贝imageview上的控件
    UIImageView *imageview1=[ArrImageView objectAtIndex:([ArrImageView count]-1)];
    UIImageView *imageview2=[ArrImageView objectAtIndex:0];
    NSData *data1=[NSKeyedArchiver archivedDataWithRootObject:imageview1];
    NSData *data2=[NSKeyedArchiver archivedDataWithRootObject:imageview2];
    UIImageView *imageview3=[NSKeyedUnarchiver unarchiveObjectWithData:data1];
    UIImageView *imageview4=[NSKeyedUnarchiver unarchiveObjectWithData:data2];
    [tempArray insertObject:imageview3 atIndex:0];
    [tempArray addObject:imageview4];
    NSUInteger pageCount=[tempArray count];
    [self setContentSize:CGSizeMake(self.frame.size.width*pageCount, self.frame.size.height)];
    
    CGRect bounds=self.frame;
    for (int i=0; i<pageCount; i++) {
        bounds.origin.x=bounds.size.width*i;
        UIImageView *imageview=[tempArray objectAtIndex:i];
        imageview.userInteractionEnabled=YES;
        imageview.frame=bounds;
        imageview.contentMode = UIViewContentModeScaleToFill;
        imageview.clipsToBounds = YES;
        [self addSubview:imageview];
    }
    self.pagecontrol.numberOfPages=pageCount-2;//总的图片页数
    [self.pagecontrol addObserver:self forKeyPath:@"currentPage" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
    self.currentPageIndex = 1;
    return self;
}

- (void)setScrollInterval:(NSUInteger)scrollInterval
{
    _scrollInterval = scrollInterval;
    
    if (self.autoScrollTimer && self.autoScrollTimer.isValid) {
        [self.autoScrollTimer invalidate];
        self.autoScrollTimer = nil;
    }
    
    self.autoScrollTimer = [NSTimer scheduledTimerWithTimeInterval:self.scrollInterval target:self selector:@selector(handleScrollTimer:) userInfo:nil repeats:YES];
}

- (void)handleScrollTimer:(NSTimer *)timer
{
    if (self.pagecontrol.numberOfPages == 0) {
        return;
    }
    self.currentPageIndex++;
    [self autoTurn];


}

-(void)pageTurn:(UIPageControl *)sender
{
    CGSize viewSize = self.frame.size;
    CGRect rect;
    if (loop) {
        rect = CGRectMake((sender.currentPage+1) * viewSize.width, 0, viewSize.width, viewSize.height);
    }
    else
    {
        rect = CGRectMake(sender.currentPage * viewSize.width, 0, viewSize.width, viewSize.height);
    }
    [self scrollRectToVisible:rect animated:YES];
}
-(void)autoTurn
{
    CGSize viewSize = self.frame.size;
    CGRect rect = CGRectMake(self.currentPageIndex * viewSize.width, 0, viewSize.width, viewSize.height);
    
    [self scrollRectToVisible:rect animated:YES];
    [self HDscrollViewDidScroll];
    [self HDscrollViewDidEndDecelerating];
    
}
-(void)HDscrollViewDidScroll
{
    if (self.contentOffset.y > 0) {
        [self setContentOffset:CGPointMake(self.contentOffset.x, 0)];
        return;
    }
    if (loop) {
        CGFloat pageWidth = self.frame.size.width;
        int page = floor((self.contentOffset.x - pageWidth / 2) / pageWidth)+1;
        self.currentPageIndex=page;
        if (self.currentPageIndex == 5) {
            page = 1;
        }
        self.pagecontrol.currentPage=(page-1);
    }
}

-(void)HDscrollViewDidEndDecelerating
{
    if (self.autoScrollTimer && self.autoScrollTimer.isValid) {
        [self.autoScrollTimer invalidate];
    }
    self.autoScrollTimer = [NSTimer scheduledTimerWithTimeInterval:self.scrollInterval target:self selector:@selector(handleScrollTimer:) userInfo:nil repeats:YES];
    if (loop) {
        if (0==self.currentPageIndex) {
            [self setContentOffset:CGPointMake([imageArray count]*self.bounds.size.width, 0)];
        }
        if (([imageArray count]+1)==self.currentPageIndex) {
            [self setContentOffset:CGPointMake(self.bounds.size.width, 0)];
            [self HDscrollViewDidScroll];
            
        }
    }
    else
    {
        //更新UIPageControl的当前页
        CGPoint offset = self.contentOffset;
        CGRect bounds = self.frame;
        [self.pagecontrol setCurrentPage:offset.x / bounds.size.width];
    }
}
-(void)tap
{
    [self.HDdelegate TapView:self.pagecontrol.currentPage];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"currentPage"]) {
        [self pageTurn:self.pagecontrol];
        [self.pagecontrol removeObserver:self forKeyPath:@"currentPage"];
    }
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end


@implementation UIImageView (CopyImageview)
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:self.backgroundColor forKey:@"backgroundColor"];
    [aCoder encodeObject:self.image forKey:@"image"];
    [aCoder encodeInt:self.contentMode forKey:@"contentMode"];
    [aCoder encodeInt:self.subviews.count forKey:@"subviewscount"];
    for(int i=0;i<self.subviews.count;i++)
    {
        UIView *view=self.subviews[i];
        [aCoder encodeObject:view forKey:[NSString stringWithFormat:@"view%d",i]];
    }
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super init]) {
        self.backgroundColor=[aDecoder decodeObjectForKey:@"backgroundColor"];
        self.image=[aDecoder decodeObjectForKey:@"image"];
        self.contentMode=[aDecoder decodeIntForKey:@"contentMode"];
        int subviewscount=[aDecoder decodeIntForKey:@"subviewscount"];
        for(int i=0;i<subviewscount;i++)
        {
           UIView* view=[aDecoder decodeObjectForKey:[NSString stringWithFormat:@"view%d",i]];
            [self addSubview:view];
        }
    }
    return self;
}
@end
