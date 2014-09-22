//
//  NSDictionary+ChangeNull.m
//  ManagerDemo
//
//  Created by xmfish on 14-9-19.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import "NSDictionary+ChangeNull.h"

@implementation NSDictionary (ChangeNull)

-(id)objectForKeyWithoutNull:(id)aKey
{
    id result = [self objectForKey:aKey];
    if ([result isKindOfClass:[NSNull class]]) {
        result = @"";
    }
    if ([result isKindOfClass:[NSNumber class]]) {
        return [result stringValue];
    }
    return result;
}
@end
