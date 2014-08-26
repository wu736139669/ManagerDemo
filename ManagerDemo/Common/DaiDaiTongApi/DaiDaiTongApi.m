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
    return [self operationWithPath:path params:params httpMethod:@"GET" ssl:YES];
}
-(MKNetworkOperation*)postWithPath:(NSString*)path params:(NSDictionary *)params
{
    return [self operationWithPath:path params:params httpMethod:@"POST" ssl:YES];
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
@end
