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
@end
