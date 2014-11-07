//
//  ManagerUtil.h
//  ManagerDemo
//
//  Created by xmfish on 14-8-12.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ManagerUtil : NSObject



/**
 *  跳转到手势页面
 *
 *  @param type type description
 */
+(void)presentGesturePsw;
/**
 *  跳转到登录页面
 *
 *  @param type type description
 */
+(void)presentLoginView;
//获取view的viewcontroller
+(UIViewController*)getCurrentViewControllerWithView:(UIView*)view;
//获取当前viewcontroller
+(UIViewController*)getCurrentRootViewController;
//删除参数view所有的subview
+ (void)removeAllSubView:(UIView*) view;
/**
 *  ios7的匹配问题
 */
+(void)SetSubViewExternNone:(UIViewController *)viewController;


/**
 *   十六进制color转为UIColor
 */
+ (UIColor *) colorWithHexString: (NSString *) stringToConvert alpha:(CGFloat)alpha;


/**
 *
 */
+(UIView*)dottedlinewithFrame:(CGRect)frame;

+(UIView*)lineWithColor:(UIColor*)color withAlpha:(CGFloat)alpha withFrame:(CGRect)frame;

+(UIView*)selectBackgroudViewWithFrame:(CGRect)frame;

+(UIImage*) buttonImageFromColor:(UIColor *)color withFrame:(CGRect)frame;

/**
*   手机号码验证
*/
+(BOOL) isValidateMobile:(NSString *)mobile;

//创建动画
+ (void)animationFromLayer:(CALayer *) layer type:(NSString *)type subType:(NSString *)subType duration:(double) duration;

//时间戳转时间
+(NSString*)timeFromtimeSp:(NSString*)timeSp;
//md5加密
+(NSString*)md5:(NSString *)str;
@end
