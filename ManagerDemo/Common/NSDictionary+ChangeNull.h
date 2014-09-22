//
//  NSDictionary+ChangeNull.h
//  ManagerDemo
//
//  Created by xmfish on 14-9-19.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (ChangeNull)

- (id)objectForKeyWithoutNull:(id)aKey;
@end
