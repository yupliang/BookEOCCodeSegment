//
//  EOCPerformance.m
//  BookEOCCodeSegment
//
//  Created by app-01 on 2017/1/31.
//  Copyright © 2017年 owspace. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "EOCNotificationCenter.h"
#import "AppDelegate.h"
@interface EOCPerformance : XCTestCase

@end

typedef id (* autoDictionaryGetter)(id self, SEL _cmd);

@implementation EOCPerformance

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}
-  (void)testDeepCopy {
    
    EOCNotificationCenter *eocCenter = [[EOCNotificationCenter alloc] init];
    NSLog(@"%@", testStrN);
    NSArray *array = [NSArray arrayWithObject:eocCenter];
    NSMutableArray *m_array = [array mutableCopy];
    XCTAssertTrue([array objectAtIndex:0] == [m_array objectAtIndex:0]);
}
- (void)testCopy {
    NSMutableArray *array = [NSMutableArray new];
    NSLog(@"__class__ %@ %@ %@", [[NSArray new] class], [NSArray class], [[NSArray arrayWithObjects:@"", nil] class]);
    XCTAssert([[EOCNotificationCenter new] isMemberOfClass:[EOCNotificationCenter  class]]);
}

- (void)testAutoreleasePool {
   __weak EOCNotificationCenter *centerOne;
   __weak EOCNotificationCenter *centerTwo;
    @autoreleasepool {
        centerOne = [EOCNotificationCenter newCenter];
        centerTwo = [EOCNotificationCenter someCenter];
    }
    XCTAssertNil(centerTwo);
    XCTAssertNotNil(centerOne);
}

- (void)testExample {
    NSLog(@"encoding %s", @encode(NSArray));
    NSString *str = (NSString *)[EOCNotificationCenter sharedInstanceOnceToken];
    NSLog(@"lower case %@", [str lowercaseString]);
    XCTAssertTrue(TRUE);
}
- (void)testBarrierBlock {
//   [self measureBlock:^{
        dispatch_queue_t queue = dispatch_queue_create("concurrent queue", NULL);
//        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(queue, ^{
            for (int i=0; i<5; i++) {
                NSLog(@"1");
            }
        });
        dispatch_sync(queue, ^{
            for (int i=0; i<5; i++) {
                NSLog(@"2");
                
            }
        });
        dispatch_barrier_async(queue, ^{
            for (int i=0; i<5; i++) {
                NSLog(@"barrier 3");
            }
        });
        dispatch_barrier_async(queue, ^{
            for (int i=0; i<5; i++) {
                NSLog(@"barrier 5");
            }
        });
        dispatch_async(queue, ^{
            for (int i=0; i<5; i++) {
                NSLog(@"4");
            }
            
        });
    XCTestExpectation *expectation = [self expectationWithDescription:@"Concurrency"];
    [self waitForExpectationsWithTimeout:1 handler:^(NSError * _Nullable error) {
        
    }];
//}];
}
- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
//        for (int i = 0; i<1000; i++) {
//            NSLog(@"Measure log");
//        }
    }];
}
- (void)testSynPerformance {
    [self measureBlock:^{
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        for (int i=0; i<0; i++) {
            dispatch_async(queue, ^{
            EOCNotificationCenter *nc = [EOCNotificationCenter sharedInstanceSynchronized];
                NSLog(@"nc %@", nc);
            });
            
        }
        
    }];
}
- (void)testOnceTokenPerformance {
    [self measureBlock:^{
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        for (int i=0; i<0; i++) {
            dispatch_async(queue, ^{
        NSNotificationCenter *nc = [EOCNotificationCenter sharedInstanceOnceToken];
                NSLog(@"nc %@", nc);
            });
        
            
        }
        
    }];
}
- (void)testSpecific {
    dispatch_queue_t queueA = dispatch_queue_create("com.eoc.queueA", NULL);
    dispatch_queue_t queueB = dispatch_queue_create("com.eoc.queueB", NULL);
    dispatch_set_target_queue(queueB, queueA);
    static int kQueueSpecific;
    CFStringRef queueSpecificValue = CFSTR("queueA");
    dispatch_queue_set_specific(queueA, &kQueueSpecific, (void *)queueSpecificValue, (dispatch_function_t)CFRelease);
       dispatch_sync(queueB, ^{
           
           XCTAssertTrue(dispatch_get_current_queue() == queueB);
           
       });
}
- (void)testCommenEqual {
    NSDictionary *dic1 = @{@"key1":@"value1",@"key2":@"value2",@"key3":@"value3",@"key4":@"value4"};
    NSMutableDictionary *dic2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"value1",@"key1",@"value2",@"key2",@"value3",@"key3",@"value4",@"key4", nil];
    NSLog(@"dic1 %@", dic1);
    NSLog(@"%@", dic2);
    XCTAssertTrue([dic1 isEqual:dic2]);
    [self measureBlock:^{
        for (int i=0; i<1000000; i++) {
            [dic1 isEqual:dic2];
        }
        
    }];
}
- (void)testSpecialEqual {
    NSDictionary *dic1 = @{@"key1":@"value1",@"key2":@"value2",@"key3":@"value3",@"key4":@"value4"};
    NSMutableDictionary *dic2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"value1",@"key1",@"value2",@"key2",@"value3",@"key3",@"value4",@"key4", nil];
    NSLog(@"dic1 %@", dic1);
    NSLog(@"%@", dic2);
    XCTAssertTrue([dic1 isEqual:dic2]);
    [self measureBlock:^{
        for (int i=0; i<1000000; i++) {
            [dic1 isEqualToDictionary:dic2];
        }
        
    }];
}
- (void)testSet {
    NSMutableSet *set = [NSMutableSet new];
    NSMutableArray *arrayA = [@[@1,@2] mutableCopy];
    NSMutableArray *arrayB = [@[@1] mutableCopy];
    [set addObject:arrayA];
    [set addObject:arrayB];
    NSLog(@"set %@", set);
    [arrayB addObject:@2];
    NSLog(@"set %@", set);
    XCTAssertTrue(TRUE);
}
- (void)testResponseSELPerformance {
    EOCNotificationCenter *center = [EOCNotificationCenter sharedInstanceOnceToken];
    [self measureBlock:^{
        for (int i=0; i<10000; i++) {
            [center respondsToSelector:@selector(sayHello)];
        }
    }];
}
@end
