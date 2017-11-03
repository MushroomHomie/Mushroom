//
//  BaseModel.m
//  Mushroom
//
//  Created by 王雅琦 on 2017/9/14.
//  Copyright © 2017年 iOSfghj. All rights reserved.
//

#import "BaseModel.h"
#import "BaseApi.h"
#import "RequestManager.h"

@interface BaseModel ()

@property (nonatomic, strong) RequestManager *manager; // 网络请求对象，每个Model有拥有一个

@end

@implementation BaseModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initData];
    }
    return self;
}

- (void)initData
{
    self.manager = [RequestManager initManagerWithDelegate:self];
}


- (RACSignal *)getRequestWithApi:(BaseApi *)api
{
    @weakify(self)
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
       
        [self.manager sendRequest:api sucBlock:^(id result) {
            
            NSString *errMsg = result[@"msg"];
            if (errMsg && errMsg.length > 0 && ![errMsg isEqualToString:@"SUCCESS"])
            {
                UIViewController *resultVC = [self topViewControllerWithRootViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
                showMessage(errMsg, resultVC);
                
                [subscriber sendCompleted];
            }
            
            [subscriber sendNext:result];
            [subscriber sendCompleted];
            
        } failBlock:^(NSError *error) {
            
            UIViewController *resultVC = [self topViewControllerWithRootViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
            showMessage(error.localizedDescription, resultVC);
        }];
        
        return nil;
    }];

}

- (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController
{
    if ([rootViewController isKindOfClass:[UITabBarController class]])
    {
        UITabBarController* tabBarController = (UITabBarController*)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    }
    else if ([rootViewController isKindOfClass:[UINavigationController class]])
    {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    }
    else if (rootViewController.presentedViewController)
    {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    }
    else
    {
        return rootViewController;
    }
}


@end
