//
//  DaiDaiTongTestApi.h
//  ManagerDemo
//
//  Created by xmfish on 14-9-18.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "MKNetworkEngine.h"

@interface DaiDaiTongTestApi : MKNetworkEngine

typedef void (^CompletionBlock) (id jsonRes);
typedef void (^FailedBlock) (NSError *error);

+(DaiDaiTongTestApi*)shareInstance;


/**
 *  api
 *  @param param           参数
 *  @param apiType         api接口
 *  @param completionBlock 请求完成
 *  @param failedBlock     请求失败
 *                  post请求
 *  @return MKNetworkOperation
 */
-(MKNetworkOperation*)postApiWithParam:(NSDictionary*)param withApiType:(NSString*) apiType completionBlock:(CompletionBlock) completionBlock failedBlock:(FailedBlock)failedBlock;
///**
// *  api
// *  @param param           参数
// *  @param apiType         api接口
// *  @param completionBlock 请求完成
// *  @param failedBlock     请求失败
// *              get请求
// *  @return MKNetworkOperation
// */
-(MKNetworkOperation*)getApiWithParam:(NSDictionary*)param withApiType:(NSString*) apiType completionBlock:(CompletionBlock) completionBlock failedBlock:(FailedBlock)failedBlock;
@end
