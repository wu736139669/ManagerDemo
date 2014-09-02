//
//  DaiDaiTongApi.m
//  ManagerDemo
//
//  Created by xmfish on 14-8-26.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "DaiDaiTongApi.h"

@implementation DaiDaiTongApi

+(DaiDaiTongApi*)shareInstance
{
    static DaiDaiTongApi* shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSMutableDictionary *postHeaderFields = [NSMutableDictionary dictionary];
        [postHeaderFields setValue:@"application/json;charset=utf-8" forKey:@"Content-Type"];
        [postHeaderFields setValue:@"gzip,deflate" forKey:@"Accept-Encoding"];
        shareInstance = [[super alloc] initWithHostName:DaiDaiTong_API_URL customHeaderFields:postHeaderFields];
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
//    [dic setObject:@"1408971073.153750" forKey:@"_"];
//    [dic setObject:@"211d9ede2548c40e5d18e47358835b16" forKey:@"sign"];
//    [dic setObject:@"MD5" forKey:@"sign_t"];
//    [dic setObject:@"f241caa3534d751598871852a2f5205f4927fcf8" forKey:@"token"];
//    [dic setObject:@"2.5.0" forKey:@"ver"];
//    [dic setObject:@"IOS" forKey:@"vjson"];
    
    
    return [self operationWithPath:path params:dic httpMethod:@"GET" ssl:YES];
}
-(MKNetworkOperation*)postWithPath:(NSString*)path params:(NSDictionary *)params
{
    NSMutableDictionary* dic = nil;
    if (params) {
        dic = [[NSMutableDictionary alloc] initWithDictionary:params];
    }else{
        dic = [[NSMutableDictionary alloc] init];
    }
    return [self operationWithPath:path params:dic httpMethod:@"POST" ssl:YES];
}
-(MKNetworkOperation*)getBannerInfoWithcompletionBlock:(CompletionBlock)completionBlock failedBlock:(FailedBlock)failedBlock
{
    MKNetworkOperation* op = [self postWithPath:@"bannerInfo.do" params:nil];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        completionBlock(completedOperation.responseJSON);
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        DLog(@"%@", error);
        failedBlock(error);
    }];
    
    [self enqueueOperation:op forceReload:YES];
    
    return op;
}

-(MKNetworkOperation*)getFundRecommendWithcompletionBlock:(CompletionBlock)completionBlock failedBlock:(FailedBlock)failedBlock
{
    MKNetworkOperation* op = [self postWithPath:@"fundRecommend.do" params:nil];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        completionBlock(completedOperation.responseJSON);
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        DLog(@"%@", error);
        failedBlock(error);
    }];
    
    [self enqueueOperation:op forceReload:YES];
    
    return op;
}
-(MKNetworkOperation*)loginWithPhone:(NSString *)phoneNum withPassWord:(NSString *)password withCompletionBlock:(CompletionBlock)completionBlock failedBlock:(FailedBlock)failedBlock
{
    NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:phoneNum, @"cell", password, @"loginPwd",nil];
    MKNetworkOperation* op = [self postWithPath:@"fastlogin.do" params:dic];
    
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
