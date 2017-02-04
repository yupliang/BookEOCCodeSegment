//
//  EOCChapter16Spec.m
//  BookEOCCodeSegment
//
//  Created by app-01 on 2017/1/30.
//  Copyright 2017年 owspace. All rights reserved.
//

#import <Kiwi/Kiwi.h>

SPEC_BEGIN(EOCChapter16Spec)

describe(@"EOCChapter16", ^{
    context(@"give a number and a block", ^{
        __block int additional;
        __block int (^addBlock) (int a, int b);
        beforeEach(^{
            additional = 5;
            addBlock = ^(int a, int b) {
                return a + b + additional;
            };
        });
        it(@"should return 12", ^{
            [[theValue(addBlock(2,5)) should] equal:theValue(12)];
        });
    });
    context(@"give an array (numbers)", ^{
        NSArray *array = @[@0, @1, @2, @3, @4];
        __block NSInteger count = 0;
        it(@"should equal 2, when test number for count > 2", ^{
            [array enumerateObjectsUsingBlock:^(NSNumber *number, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([number compare:@2] == NSOrderedAscending) { count ++;}
            }];
            [[theValue(count) should] equal:theValue(2)];
        });
    });
    context(@"create a block in IF-ELSE SCOPE", ^{
        NSString * (^block)();
        if (TRUE) {
            block = ^{
                return @"Hi";
            };
        } else {}
        it(@"should equal 'Hi'", ^{
            [[block() should] equal:@"Hi"];
        });
    });
});

SPEC_END
