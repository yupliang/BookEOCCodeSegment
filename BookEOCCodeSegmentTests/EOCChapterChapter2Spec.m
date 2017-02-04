//
//  EOCChapterChapter2Spec.m
//  BookEOCCodeSegment
//
//  Created by app-01 on 2017/1/31.
//  Copyright 2017年 owspace. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import <objc/runtime.h>

SPEC_BEGIN(EOCChapterChapter2Spec)

void (^exchangeStringCase)(void) = ^{
    Method lowercase = class_getInstanceMethod([NSString class], @selector(lowercaseString));
    Method uppercase = class_getInstanceMethod([NSString class], @selector(uppercaseString));
    method_exchangeImplementations(uppercase, lowercase);
};

describe(@"EOCChapterChapter2", ^{
    context(@"give a mutable string", ^{
        NSMutableString *string = [[NSMutableString alloc] initWithString:@"Hi"];
        it(@"should not equal to copy", ^{
            NSLog(@"mstring  %p", string);
            NSLog(@"%p", [string copy]);
            [[theValue(string==[string copy]) shouldNot] beTrue];
        });
    });
    context(@"give an UIViewController", ^{
        [[theValue([NSObject class] == [UIViewController class]) shouldNot]beTrue];
    });
    context(@"exchange lowercase and uppercase Method", ^{
        __block NSString *str;
        beforeEach(^{
            str = @"Hi, Hello World!";
            exchangeStringCase();
            NSLog(@"lowercase %@", [str lowercaseString]);
            NSLog(@"uppercase %@", [str uppercaseString]);
        });
        it(@"should equal 'HI, HELLO WORLD!'", ^{
            [[[str lowercaseString] should] equal:@"HI, HELLO WORLD!"];
        });
        it(@"should equal 'hi, hello world!'", ^{
            [[[str uppercaseString] should] equal:@"hi, hello world!"];
        });
    });
});

SPEC_END
