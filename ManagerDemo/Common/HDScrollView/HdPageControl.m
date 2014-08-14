//
//  HdPageControl.m
//  ScrollView
//
//  Created by Hu Di on 13-11-20.
//  Copyright (c) 2013年 Sanji. All rights reserved.
//

#import "HdPageControl.h"
#define IOS7 [[UIDevice currentDevice].systemVersion doubleValue]>=7.0
@implementation HdPageControl

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void) updateDots
{
    for (int i = 0; i < [self.subviews count]; i++)
    {
        UIView* pageIcon = [self.subviews objectAtIndex:i];
        pageIcon.layer.cornerRadius=3;
        pageIcon.layer.masksToBounds=YES;
        //NSLog(@"%@",NSStringFromClass([pageIcon class]));
        if ([NSStringFromClass([pageIcon class]) isEqualToString:@"UIImageView"]) {
            if (i == self.currentPage)
            {
                ((UIImageView*)pageIcon).image=[self createImageWithColor:self.currentcolor];
            }
            else
            {
                ((UIImageView*)pageIcon).image=[self createImageWithColor:self.othercolor];
            }
        }
        else
        {
            if (i == self.currentPage)
            {
                pageIcon.backgroundColor=self.currentcolor;
            }
            else
            {
                pageIcon.backgroundColor=self.othercolor;
            }

        }
        
    }
    
}
-(void) setCurrentPage:(NSInteger)page
{
    [super setCurrentPage:page];
    [self updateDots];
}
- (UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
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
