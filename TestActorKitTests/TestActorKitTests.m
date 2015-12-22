//
//  TestActorKitTests.m
//  TestActorKitTests
//
//  Created by Julian Krumow on 20.08.15.
//  Copyright (c) 2015 Julian Krumow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <ActorKit/Supervision.h>

#import "Table.h"
#import "Philosopher.h"

@interface TestActorKitTests : XCTestCase

@end

@implementation TestActorKitTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testDiningPhilosophers
{
    NSArray *names = @[@"Heraclitus", @"Aristotle", @"Epictetus", @"Schopenhauer", @"Popper"];
    
    Table *table = [[Table alloc] initWithChopsticks:names.count];
    
    for (NSString *name in names) {
        [TBActorSupervisionPool.sharedInstance superviseWithId:name creationBlock:^NSObject * _Nonnull{
            return [[Philosopher alloc] initWithName:name table:table];
        }];
    }
    
    sleep(2);
    
    [table tbak_suspend];
    
    for (NSString *name in names) {
        [TBActorSupervisionPool.sharedInstance[name] tbak_suspend];
    }
    
    XCTAssert(YES, @"Pass");
}

@end
