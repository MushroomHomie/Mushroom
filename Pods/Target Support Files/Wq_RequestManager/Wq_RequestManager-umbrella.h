#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "AbsApi.h"
#import "ApiDelegate.h"
#import "BaseApi.h"
#import "BaseServiceManager.h"
#import "RequestManager.h"

FOUNDATION_EXPORT double Wq_RequestManagerVersionNumber;
FOUNDATION_EXPORT const unsigned char Wq_RequestManagerVersionString[];

