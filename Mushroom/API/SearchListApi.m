//
//  SearchListApi.m
//  Mushroom
//
//  Created by 王雅琦 on 2017/11/2.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "SearchListApi.h"
#import "SearchListModel.h"

@implementation SearchListApi

- (NSDictionary *)getBody
{
    if (!_keyWord)
    {
        _keyWord = @"";
    }
    
    NSString *newKeyWord =  (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)_keyWord, NULL, NULL,  kCFStringEncodingUTF8 ));
    
    return @{
             @"keyword":newKeyWord,
             @"type":@"Mv"
             };
}

- (NSString *)getPath
{
    return @"search/suggest.json";
}

- (Class)getRespClass
{
    return SearchListModel.class;
}

- (int)getRequestMethod
{
    return RequestMethodGET;
}

@end
