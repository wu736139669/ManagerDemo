//
//  ManagerConstants.h
//  ManagerDemo
//
//  Created by xmfish on 14-8-8.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#ifndef ManagerDemo_ManagerConstants_h
#define ManagerDemo_ManagerConstants_h

/**
 *  系统版本
 */
#define IOS_VERSION     ( [[UIDevice currentDevice].systemVersion floatValue] )
#define IOS7_OR_LATER   ( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )
#define DEVICE_IS_IPHONE5 ([[UIScreen mainScreen] bounds].size.height == 568)
/**
 *  获取当前window宽高
 */
#define ScreenWidth           [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight          [[UIScreen mainScreen] bounds].size.height

/**
 * 系统字体
 */
#define Font_Black(fontsize) [UIFont fontWithName:@"HelveticaNeue-Bold" size:fontsize];
#endif
