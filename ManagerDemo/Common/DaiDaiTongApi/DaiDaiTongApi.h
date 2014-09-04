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

/**
 *  快速登录
 *
 *  @param completionBlock 请求完成
 *  @param failedBlock     请求失败
 *  @param phoneNum        手机号码
 *  @param password        登录密码
 *  @return MKNetworkOperation
 */
-(MKNetworkOperation*)loginWithPhone:(NSString*)phoneNum withPassWord:(NSString*)password withCompletionBlock:(CompletionBlock)completionBlock failedBlock:(FailedBlock)failedBlock;
/**
 *  获取列表
 *
 *  @param completionBlock 请求完成
 *  @param failedBlock     请求失败
 *  @param type            类型
 *  @param pageNum         页数
 *  @return MKNetworkOperation
 */
-(MKNetworkOperation*)productListForType:(NSString*)type withPageNum:(NSInteger)pageNum withCompletionBlock:(CompletionBlock)completionBlock failedBlock:(FailedBlock)failedBlock;

/**
 *  获取个人信息
 *
 *  @param completionBlock 请求完成
 *  @param failedBlock     请求失败
 *
 *  @return MKNetworkOperation
 */
-(MKNetworkOperation*)getAccountInfoWithcompletionBlock:(CompletionBlock)completionBlock failedBlock:(FailedBlock)failedBlock;

/**
 *  获取消息
 *
 *  @param completionBlock 请求完成
 *  @param failedBlock     请求失败
 *  @param pageNum         页数
 *  @return MKNetworkOperation
 */
-(MKNetworkOperation*)getMsgwithPageNum:(NSInteger)pageNum withCompletionBlock:(CompletionBlock)completionBlock failedBlock:(FailedBlock)failedBlock;

/**
 *  标记消息已读
 *
 *  @param completionBlock 请求完成
 *  @param failedBlock     请求失败
 *
 *  @return MKNetworkOperation
 */
-(MKNetworkOperation*)readMsgWithcompletionBlock:(CompletionBlock)completionBlock failedBlock:(FailedBlock)failedBlock;

/**
 *  读取消息详情
 *
 *  @param completionBlock 请求完成
 *  @param failedBlock     请求失败
 *  @param msgId           消息id
 *  @return MKNetworkOperation
 */
-(MKNetworkOperation*)getMsgDetailwithPageNum:(NSString*)msgId withCompletionBlock:(CompletionBlock)completionBlock failedBlock:(FailedBlock)failedBlock;

/**
 *  获取个人详细信息
 *
 *  @param completionBlock 请求完成
 *  @param failedBlock     请求失败
 *
 *  @return MKNetworkOperation
 */
-(MKNetworkOperation*)getPersonDetailWithcompletionBlock:(CompletionBlock)completionBlock failedBlock:(FailedBlock)failedBlock;

/**
 *  获取每日收益信息
 *
 *  @param completionBlock 请求完成
 *  @param failedBlock     请求失败
 *
 *  @return MKNetworkOperation
 */
-(MKNetworkOperation*)getProfitDatedetailWithcompletionBlock:(CompletionBlock)completionBlock failedBlock:(FailedBlock)failedBlock;

/**
 *  读取有页数的列表
 *
 *  @param completionBlock 请求完成
 *  @param failedBlock     请求失败
 *  @param pageNum           页数
 *  @param typeStr         列表类型
 *  @param param            附加参数
 *  @return MKNetworkOperation
 */
-(MKNetworkOperation*)getListwithPageNum:(NSInteger)pageNum  withType:(NSString*)typeStr withParam:(NSDictionary*)param withCompletionBlock:(CompletionBlock)completionBlock failedBlock:(FailedBlock)failedBlock;
@end
