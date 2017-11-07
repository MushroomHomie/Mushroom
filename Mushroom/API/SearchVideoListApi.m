//
//  SearchVideoListApi.m
//  Mushroom
//
//  Created by 王雅琦 on 2017/11/6.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "SearchVideoListApi.h"
#import "SearchVideoModel.h"

@implementation SearchVideoListApi

- (NSDictionary *)getBody
{
    if (!_keyword)
    {
        _keyword = @"";
    }
    
    NSString *newKeyWord = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)_keyword, NULL, NULL, kCFStringEncodingUTF8 ));
    
    return @{
             @"keyword":newKeyWord,
             @"offset":_offset,
             @"size":@"20"
             };
}

- (NSString *)getPath
{
    return @"search/video_new.json";
}

- (Class)getRespClass
{
    return SearchVideoModel.class;
}

- (int)getRequestMethod
{
    return RequestMethodGET;
}

@end
