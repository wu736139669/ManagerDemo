//
//  ManagerUtil.m
//  ManagerDemo
//
//  Created by xmfish on 14-8-12.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "ManagerUtil.h"

@implementation ManagerUtil


+(void)SetSubViewExternNone:(UIViewController *)viewController
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    if ( IOS7_OR_LATER )
    {
        viewController.edgesForExtendedLayout = UIRectEdgeNone;
        viewController.extendedLayoutIncludesOpaqueBars = NO;
        viewController.modalPresentationCapturesStatusBarAppearance = NO;
        viewController.navigationController.navigationBar.translucent = NO;
//        viewController.navigationController.navigationBar.tintColor = [UIColor blackColor];
//        viewController.navigationController.navigationBar.backgroundColor = [UIColor blackColor];
    }
#endif  // #if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
}

+ (UIColor *) colorWithHexString: (NSString *) stringToConvert alpha:(CGFloat)alpha
{
	NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
	
	// String should be 6 or 8 characters
	if ([cString length] < 6) return [UIColor blackColor];
	
	// strip 0X if it appears
	if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] != 6) return [UIColor blackColor];
	// Separate into r, g, b substrings
	NSRange range;
	range.location = 0;
	range.length = 2;
	NSString *rString = [cString substringWithRange:range];
	
	range.location = 2;
	NSString *gString = [cString substringWithRange:range];
	
	range.location = 4;
	NSString *bString = [cString substringWithRange:range];
	
	// Scan values
	unsigned int r, g, b;
	[[NSScanner scannerWithString:rString] scanHexInt:&r];
	[[NSScanner scannerWithString:gString] scanHexInt:&g];
	[[NSScanner scannerWithString:bString] scanHexInt:&b];
	
	return [UIColor colorWithRed:((float) r / 255.0f)
						   green:((float) g / 255.0f)
							blue:((float) b / 255.0f)
						   alpha:alpha];
}
+(UIView*)lineWithColor:(UIColor*)color withAlpha:(CGFloat)alpha withFrame:(CGRect)frame
{
    UIView* lineView = [[UIView alloc] initWithFrame:frame];
    lineView.alpha = alpha;
    [lineView setBackgroundColor:color];
    return lineView;
}
@end
