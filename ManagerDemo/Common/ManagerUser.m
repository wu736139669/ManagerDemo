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

-(void)setIsGesturePsw:(BOOL)isGesturePsw
{
    _isGesturePsw = isGesturePsw;
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:_isGesturePsw] forKey:@"GesturePswState"];
}
-(BOOL)isGesturePsw
{
    _isGesturePsw = [[[NSUserDefaults standardUserDefaults] objectForKey:@"GesturePswState"] boolValue];
    return _isGesturePsw;
}
-(void)setGesturePsw:(NSString *)gesturePsw
{
    _gesturePsw = gesturePsw;
    [[NSUserDefaults standardUserDefaults] setObject:_gesturePsw forKey:@"GesturePsw"];
}
-(NSString*)gesturePsw
{
    _gesturePsw = [[NSUserDefaults standardUserDefaults] objectForKey:@"GesturePsw"] ;
    return _gesturePsw;
}
-(void)setIsLogin:(BOOL)isLogin
{
    _isLogin = isLogin;
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:_isLogin] forKey:@"LoginState"];
}
-(BOOL)isLogin
{
    _isLogin = [[[NSUserDefaults standardUserDefaults] objectForKey:@"LoginState"] boolValue];
    return _isLogin;
}
-(void)setToken:(NSString *)token
{
    _token = token;
    [[NSUserDefaults standardUserDefaults] setObject:_token forKey:@"Token"];
}
-(NSString*)token
{
    _token = [[NSUserDefaults standardUserDefaults] objectForKey:@"Token"] ;
    return _token;
}
-(void)setUserId:(NSString *)userId
{
    _userId = userId;
    [[NSUserDefaults standardUserDefaults] setObject:_userId forKey:@"UserId"];
}
-(NSString*)userId
{
    _userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserId"] ;
    return _userId;
}
-(void)setTradePsw:(NSString *)tradePsw
{
    _tradePsw = tradePsw;
    [[NSUserDefaults standardUserDefaults] setObject:_tradePsw forKey:@"TradePsw"];
}
-(NSString*)tradePsw
{
    _tradePsw = [[NSUserDefaults standardUserDefaults] objectForKey:@"TradePsw"] ;
    return _tradePsw;
}
@end
