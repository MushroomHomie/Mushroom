//
//  MushroomBaseApi.m
//  Mushroom
//
//  Created by 中原管家 on 2017/10/18.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "MushroomBaseApi.h"

#define RequestHeader  @{@"app-id":@"10201026",\
@"device-id":@"f850f42b9702326817be2db897127319",\
@"Authorization":@"Basic MTAyMDE6ODZmMjYyOWFlMjMwMzhkZTI3ZGE1NjI5MTgxZjE3OTM=",\
@"DeviceInfo":@"deviceinfo=%7B%22aid%22%3A%2210201026%22%2C%22os%22%3A%22Android%22%2C%22ov%22%3A%224.2.1%22%2C%22rn%22%3A%22480*800%22%2C%22dn%22%3A%22M040%22%2C\%22cr%22%3A%2246002%22%2C%22as%22%3A%22WIFI%22%2C%22uid%22%3A%22f850f42b9702326817be2db897127319%22%2C%22clid%22%3A100001000%7D",\
@"Device-N":@"JUU0JUI4JUFEJUU1JTlCJUJEJUU3JUE3JUJCJUU1JThBJUE4XyUyMldJRkklMjJfJTIyamFtZXMlMjI=",\
@"Device-V":@"QW5kcm9pZF80LjIuMV84MDAqMTI4MF8xMDAwMDEwMDA=",\
@"tt":@"f445048914b4dffbc423a70c548bfc87",\
@"pp":@"559dc431e61cf35eb1decbfdc0b7c080",\
@"Host":@"mapi.yinyuetai.com",\
@"Connection":@"Keep-Alive",\
@"User-Agent":@"Mozilla/5.0(Linux;U; Android 2.2.1; en-us; Nexus One Build/FRG83) AppleWebKit/533.1(KHTML,like Gecko) Version/4.0 Mobile Safari/533.1",\
@"Cookie":@"route=95f0b44eeadc95313b008be0d3f8f669; JSESSIONID=aaaWCoBfrH4I-a-JXU-Nu"\
}
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
