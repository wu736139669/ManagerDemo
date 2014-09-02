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
 *  跳转到登录页面
 *
 *  @param type type description
 */
+(void)presentLoginView;
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
+(UIView*)lineWithColor:(UIColor*)color withAlpha:(CGFloat)alpha withFrame:(CGRect)frame;

+(UIView*)selectBackgroudViewWithFrame:(CGRect)frame;

+(UIImage*) buttonImageFromColor:(UIColor *)color withFrame:(CGRect)frame;
+(UIViewController *)getCurrentRootViewController;
@end
