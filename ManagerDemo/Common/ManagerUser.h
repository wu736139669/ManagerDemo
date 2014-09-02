//
//  ManagerUser.h
//  ManagerDemo
//
//  Created by xmfish on 14-9-2.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ManagerUser : NSObject
{
    BOOL _isLogin;
}
@property(nonatomic, assign)BOOL isLogin;
+(ManagerUser*)shareInstance;
@end
