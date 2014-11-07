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
    BOOL _isGesturePsw;
    NSString* _userId;
    NSString* _token;
    NSString* _tradePsw;
    NSString* _gesturePsw;
}
@property(nonatomic, strong)NSString* gesturePsw;
@property(nonatomic, strong)NSString* tradePsw;
@property(nonatomic, assign)BOOL isLogin;
@property(nonatomic, assign)BOOL isGesturePsw;
@property(nonatomic, strong)NSString* userId;
@property(nonatomic, strong)NSString* token;
+(ManagerUser*)shareInstance;
@end
