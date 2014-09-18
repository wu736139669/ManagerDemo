//
//  DaiDaiTongTestApi.m
//  ManagerDemo
//
//  Created by xmfish on 14-9-18.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "DaiDaiTongTestApi.h"

@implementation DaiDaiTongTestApi

+(DaiDaiTongTestApi*)shareInstance
{
    static DaiDaiTongTestApi* shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSMutableDictionary *postHeaderFields = [NSMutableDictionary dictionary];
        [postHeaderFields setValue:@"application/json;charset=utf-8" forKey:@"Content-Type"];
        [postHeaderFields setValue:@"gzip,deflate" forKey:@"Accept-Encoding"];
        shareInstance = [[super alloc] initWithHostName:DaiDaiTong_Api_Test_URL customHeaderFields:postHeaderFields];
    });
    return shareInstance;
}

-(MKNetworkOperation*)getWithPath:(NSString*)path params:(NSDictionary *)params
{
    NSMutableDictionary* dic = nil;
    if (params) {
        dic = [[NSMutableDictionary alloc] initWithDictionary:params];
    }else{
        dic = [[NSMutableDictionary alloc] init];
    }
    NSDate* timeDate = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval timeInterval =[timeDate timeIntervalSince1970]*1000;
    NSString *timeString = [NSString stringWithFormat:@"%f", timeInterval];//转为字符型
    [dic setObject:timeString forKey:@"timeStamp"];
    if ([ManagerUser shareInstance].token.length > 0) {
        [dic setObject:[ManagerUser shareInstance].token forKey:@"token"];
    }
    if ([ManagerUser shareInstance].userId.length > 0) {
        [dic setObject:[ManagerUser shareInstance].userId forKey:@"userid"];
    }
    NSError *parseError = nil;
    NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    NSString* tempStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSDictionary* tempDic = [NSDictionary dictionaryWithObject:tempStr forKey:@"jsonData"];
    return [self operationWithPath:path params:tempDic httpMethod:@"GET" ssl:NO];;
}
-(MKNetworkOperation*)postWithPath:(NSString*)path params:(NSDictionary *)params
{
    NSMutableDictionary* dic = nil;
    if (params) {
        dic = [[NSMutableDictionary alloc] initWithDictionary:params];
    }else{
        dic = [[NSMutableDictionary alloc] init];
    }
    NSDate* timeDate = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval timeInterval =[timeDate timeIntervalSince1970]*1000;
    NSString *timeString = [NSString stringWithFormat:@"%f", timeInterval];//转为字符型
    [dic setObject:timeString forKey:@"timeStamp"];
    NSError *parseError = nil;
    NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    NSString* tempStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSDictionary* tempDic = [NSDictionary dictionaryWithObject:tempStr forKey:@"jsonData"];
    return [self operationWithPath:path params:tempDic httpMethod:@"POST" ssl:NO];
}
-(MKNetworkOperation*)getApiWithParam:(NSDictionary *)param withApiType:(NSString *)apiType completionBlock:(CompletionBlock)completionBlock failedBlock:(FailedBlock)failedBlock
{
    MKNetworkOperation* op = [self getWithPath:apiType params:param];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        completionBlock(completedOperation.responseJSON);
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        DLog(@"%@", error);
        
        failedBlock(error);
    }];
    
    [self enqueueOperation:op forceReload:YES];
    
    return op;
}
-(MKNetworkOperation*)postApiWithParam:(NSDictionary *)param withApiType:(NSString *)apiType completionBlock:(CompletionBlock)completionBlock failedBlock:(FailedBlock)failedBlock
{
    MKNetworkOperation* op = [self postWithPath:apiType params:param];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        completionBlock(completedOperation.responseJSON);
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        DLog(@"%@", error);
        failedBlock(error);
    }];
    
    [self enqueueOperation:op forceReload:YES];
    
    return op;
}
@end
