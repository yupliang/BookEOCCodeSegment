//
//  EOCChapter5Spec.m
//  BookEOCCodeSegment
//
//  Created by app-01 on 2017/2/1.
//  Copyright 2017年 owspace. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "EOCNotificationCenter.h"
#import <Foundation/Foundation.h>
SPEC_BEGIN(EOCChapter5Spec)

describe(@"EOCChapter5", ^{
    __block EOCNotificationCenter *center;
    context(@"create object with method prefix 'new'", ^{
        
        center = [EOCNotificationCenter newCenter];
        
    });
});

SPEC_END
