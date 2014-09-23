//
//  ManagerUtil.m
//  ManagerDemo
//
//  Created by xmfish on 14-8-12.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "ManagerUtil.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import <CommonCrypto/CommonDigest.h>
@implementation ManagerUtil


+(void)presentLoginView
{
    LoginViewController *login = [[LoginViewController alloc] init];
    UINavigationController *nav =[[UINavigationController alloc]initWithRootViewController:login];
    
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    [app.mainViewController presentViewController:nav animated:YES completion:^{
        
    }];
    
}
+(void)SetSubViewExternNone:(UIViewController *)viewController
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
    if ( IOS7_OR_LATER )
    {
        viewController.edgesForExtendedLayout = UIRectEdgeNone;
        viewController.extendedLayoutIncludesOpaqueBars = NO;
        viewController.modalPresentationCapturesStatusBarAppearance = NO;
        viewController.navigationController.navigationBar.translucent = NO;
        viewController.tabBarController.tabBar.translucent = NO;
//        viewController.navigationController.navigationBar.tintColor = [UIColor blackColor];
//        viewController.navigationController.navigationBar.backgroundColor = [UIColor blackColor];
    }
#endif  // #if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
}

+ (void)removeAllSubView:(UIView*) view {
    for (UIView* subview in view.subviews) {
        if ([subview.subviews count]) {
            [self removeAllSubView:subview];
        }
        [subview removeFromSuperview];
    }
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
+(UIView*)selectBackgroudViewWithFrame:(CGRect)frame
{
    UIView* selectBackgroudView = [[UIView alloc] initWithFrame:frame];
    selectBackgroudView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.1];
    return selectBackgroudView;
}
+ (UIImage *) buttonImageFromColor:(UIColor *)color withFrame:(CGRect)frame{
    CGRect rect = CGRectMake(0, 0, frame.size.width, frame.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
+(UIViewController *)getCurrentViewControllerWithView:(UIView *)view
{
    for (UIView* next = [view superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}
+(UIViewController *)getCurrentRootViewController {
    
    
    UIViewController *result;

    UIWindow *topWindow = [[UIApplication sharedApplication] keyWindow];
    
    if (topWindow.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        
        for(topWindow in windows)
        {
            if (topWindow.windowLevel == UIWindowLevelNormal)
                break;
        }
    }
    
    UIView *rootView = [[topWindow subviews] objectAtIndex:0];
    
    id nextResponder = [rootView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        
        result = nextResponder;
    else if ([topWindow respondsToSelector:@selector(rootViewController)] && topWindow.rootViewController != nil)
        result = topWindow.rootViewController;
    else
        NSAssert(NO, @"ShareKit: Could not find a root view controller.  You can assign one manually by calling [[SHK currentHelper] setRootViewController:YOURROOTVIEWCONTROLLER].");
    return result;    
    
    
}

/*手机号码验证 MODIFIED BY HELENSONG*/
+(BOOL) isValidateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

+ (CATransition*)animationLayer:(NSString *)type subType:(NSString *)subType
{
    CATransition *transition = [CATransition animation]; //定义过度动画
    transition.duration = 1; //持续时间
    transition.type = type;   //动画样式
    transition.subtype = subType;  //方向
    
    return transition;
}
+ (void)animationFromLayer:(CALayer *) layer type:(NSString *)type subType:(NSString *)subType duration:(double) duration {
    CAAnimation* animation = [ManagerUtil animationLayer:type subType:subType];
    animation.duration = duration;
    [layer addAnimation:animation forKey:@"animationFromLayer"];
}

+(NSString*)timeFromtimeSp:(NSString*)timeSp
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateStyle:NSDateFormatterMediumStyle];
//    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:MM"];
//    NSDate *date = [formatter dateFromString:@"1231312312"];
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:[timeSp floatValue]];
    return [formatter stringFromDate:date];
}

+ (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ]; 
}
@end
