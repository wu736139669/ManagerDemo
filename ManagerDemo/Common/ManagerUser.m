//
//  ManagerUser.m
//  ManagerDemo
//
//  Created by xmfish on 14-9-2.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "ManagerUser.h"

@implementation ManagerUser

+(ManagerUser*)shareInstance
{
    static ManagerUser* shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[super alloc] init];
    });
    return shareInstance;
}
@end
