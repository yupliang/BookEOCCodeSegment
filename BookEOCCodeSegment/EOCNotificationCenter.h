//
//  EOCNotificationCenter.h
//  BookEOCCodeSegment
//
//  Created by app-01 on 2017/1/31.
//  Copyright © 2017年 owspace. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EOCNotificationCenter : NSObject
+ (id)sharedInstanceSynchronized;
+ (id)sharedInstanceOnceToken;
- (void)equalNameSelector;
- (void)equalNameSelector:(NSInteger)p;
+ (EOCNotificationCenter *)newCenter;
+ (EOCNotificationCenter *)someCenter;
@end
