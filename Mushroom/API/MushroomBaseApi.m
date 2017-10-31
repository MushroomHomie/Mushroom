//
//  MushroomBaseApi.m
//  Mushroom
//
//  Created by 王雅琦 on 2017/10/18.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "MushroomBaseApi.h"

@implementation MushroomBaseApi


- (NSString *)getRootUrl
{
    return @"http://mapiv2.yinyuetai.com/";
}

- (NSMutableDictionary *)getBaseBody
{
    NSMutableDictionary *mdic = [NSMutableDictionary dictionary];
    return mdic;
}

- (int)getTimeOut
{
    return 10;
}

- (NSDictionary *)getBaseHeader
{
    NSMutableDictionary *headerDic = [NSMutableDictionary dictionary];
    
    [headerDic setValue:@"10101054" forKey:@"app-id"];
    [headerDic setValue:@"970ad236653c5a4920f653dddb9fdd7f" forKey:@"tt"];
    [headerDic setValue:@"35f96543ab8d54e24c176e5737eb2244" forKey:@"pp"];
    [headerDic setValue:@"17eae067daa9a0ca564b59e87b5bcbbc" forKey:@"yinyuetai_uid"];
    [headerDic setValue:@"Basic MTAxMDE6NzFmZjI1Y2RmOGNjYzAzN2Y1MmU3ZmRkNTdjYWY5MjM=" forKey:@"Authorization"];
    [headerDic setValue:@"598A7260-EF7D-4F91-AD32-C1001A0FAB3D" forKey:@"idfa"];
    
    [headerDic setValue:@"17eae067daa9a0ca564b59e87b5bcbbc" forKey:@"Device-Id"];
    [headerDic setValue:@"aU9TXzEwLjEuMV83NTAqMTMzNF8xMDAwMDEwMDBfaVBob25lOSwx" forKey:@"Device-V"];
    [headerDic setValue:@"5Lit5Zu96IGU6YCaX1dJRkk=" forKey:@"Device-N"];
    [headerDic setValue:@"Mozilla/5.0 (iPhone; CPU iPhone OS 10_1_1 like Mac OS X) AppleWebKit/602.2.14 (KHTML, like Gecko) Mobile/14B100" forKey:@"User-Agent"];
    [headerDic setValue:@"Keep-Alive" forKey:@"Connection"];
    [headerDic setValue:@"route=e05a37cb4fddfbf5754e17c37aa7e634; JSESSIONID=aaaWCoBfrH4I-a-JXU-Nu" forKey:@"Cookie"];
    
    return (NSDictionary *)headerDic;
}


@end
