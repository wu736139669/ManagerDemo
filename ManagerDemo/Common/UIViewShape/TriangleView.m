//
//  TriangleView.m
//  ManagerDemo
//
//  Created by xmfish on 14-8-12.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "TriangleView.h"

@implementation TriangleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
-
(void)drawRect:(CGRect)rect

{
    
    //设置背景颜色
    
    [[UIColor whiteColor]set];
    
    UIRectFill([self bounds]);
    
    //拿到当前视图准备好的画板
    
    CGContextRef
    context = UIGraphicsGetCurrentContext();
    
    //利用path进行绘制三角形
    
    CGContextBeginPath(context);//标记
    
    CGContextMoveToPoint(context,0, 0);//设置起点
    
    CGContextAddLineToPoint(context,165, 0);
    
    CGContextAddLineToPoint(context,165, 105);
    
    CGContextClosePath(context);//路径结束标志，不写默认封闭
    
    [[UIColor redColor] setFill]; //设置填充色
    
    [[UIColor blueColor] setStroke]; //设置边框颜色
    
    CGContextDrawPath(context,kCGPathFillStroke);//绘制路径path
    
}


@end
