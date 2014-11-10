//
//  IPGet.h
//  ManagerDemo
//
//  Created by xmfish on 14/11/10.
//  Copyright (c) 2014年 ash. All rights reserved.
//

#ifndef __ManagerDemo__IPGet__
#define __ManagerDemo__IPGet__

#include <iostream>
#define MAXADDRS    32

extern char *if_names[MAXADDRS];
extern char *ip_names[MAXADDRS];
extern char *hw_addrs[MAXADDRS];
extern unsigned long ip_addrs[MAXADDRS];

// Function prototypes

void InitAddresses();
void FreeAddresses();
void GetIPAddresses();
void GetHWAddresses();
#endif /* defined(__ManagerDemo__IPGet__) */
