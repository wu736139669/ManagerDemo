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
    NSString* _userId;
    NSString* _token;
}
@property(nonatomic, assign)BOOL isLogin;
@property(nonatomic, strong)NSString* userId;
@property(nonatomic, strong)NSString* token;
+(ManagerUser*)shareInstance;
@end
