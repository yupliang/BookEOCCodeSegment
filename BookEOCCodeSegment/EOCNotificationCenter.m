//
//  EOCNotificationCenter.m
//  BookEOCCodeSegment
//
//  Created by app-01 on 2017/1/31.
//  Copyright © 2017年 owspace. All rights reserved.
//

#import "EOCNotificationCenter.h"
#import <objc/runtime.h>

id lowercaseStr (id self, SEL _cmd) {
    return @"Hi i am lowercaseString method";
}

@implementation EOCNotificationCenter
+ (id)sharedInstanceSynchronized {
    static EOCNotificationCenter *sharedInstance = nil;
    @synchronized (self) {
        if (!sharedInstance) {
            sharedInstance = [[self alloc] init];
        }
    }
    return sharedInstance;
}
+ (id)sharedInstanceOnceToken {
    static EOCNotificationCenter *sharedInstance1 = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!sharedInstance1) {
            sharedInstance1 = [[self alloc] init];
        }
    });
    return sharedInstance1;
}
- (void)doesNotRecognizeSelector:(SEL)aSelector {
    NSLog(@"%s",__FUNCTION__);
    [super doesNotRecognizeSelector:aSelector];
}
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    NSString *selectorString = NSStringFromSelector(sel);
    if ([selectorString isEqualToString:@"lowercaseString"]) {
        class_addMethod(self, sel, (IMP)lowercaseStr, "@@:");
    }
    return YES;
}
+ (EOCNotificationCenter *)newCenter {
    EOCNotificationCenter *center = [[EOCNotificationCenter alloc] init];
    return center;
}
+ (EOCNotificationCenter *)someCenter {
    EOCNotificationCenter *center = [[EOCNotificationCenter alloc] init];
    return center;
}
@end
