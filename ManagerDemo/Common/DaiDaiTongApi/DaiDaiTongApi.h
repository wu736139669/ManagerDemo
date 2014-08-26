//
//  DaiDaiTongApi.h
//  ManagerDemo
//
//  Created by xmfish on 14-8-26.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "MKNetworkEngine.h"

@interface DaiDaiTongApi : MKNetworkEngine

typedef void (^CompletionBlock) (id jsonRes);
typedef void (^FailedBlock) (NSError *error);

+(DaiDaiTongApi*)shareInstance;

/**
 *  获取首页广告
 *
 *  @param completionBlock 请求完成
 *  @param failedBlock     请求失败
 *
 *  @return MKNetworkOperation
 */
-(MKNetworkOperation*)getBannerInfoWithcompletionBlock:(CompletionBlock) completionBlock failedBlock:(FailedBlock)failedBlock;

/**
 *  获取首页推荐
 *
 *  @param completionBlock 请求完成
 *  @param failedBlock     请求失败
 *
 *  @return MKNetworkOperation
 */
-(MKNetworkOperation*)getFundRecommendWithcompletionBlock:(CompletionBlock)completionBlock failedBlock:(FailedBlock)failedBlock;
@end