//
//  AdjustableUILable.m
//  ManagerDemo
//
//  Created by xmfish on 14-8-12.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "AdjustableUILable.h"

@implementation AdjustableUILable

@synthesize characterSpacing;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}


- (void)drawTextInRect:(CGRect)rect
{
    if (characterSpacing)
    {
        // Drawing code
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGFloat size = self.font.pointSize;
        CGContextSelectFont (context, [self.font.fontName UTF8String], size, kCGEncodingMacRoman);
        CGContextSetCharacterSpacing (context, characterSpacing);
        CGContextSetTextDrawingMode (context, kCGTextFill);
        
        // Rotate text to not be upside down
        CGAffineTransform xform = CGAffineTransformMake(1.0, 0.0, 0.0, -1.0, 0.0, 0.0);
        CGContextSetTextMatrix(context, xform);
        const char *cStr = [self.text UTF8String];
        CGContextShowTextAtPoint (context, rect.origin.x, rect.origin.y + size, cStr, strlen(cStr));
    }
    else
    {
        // no character spacing provided so do normal drawing
        [super drawTextInRect:rect];
    }
}

@end
