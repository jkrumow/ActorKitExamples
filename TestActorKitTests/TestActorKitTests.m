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

@property (nonatomic) NSArray *names;
@property (nonatomic) Table *table;
@end

@implementation TestActorKitTests

- (void)setUp
{
    [super setUp];
    
    _names = @[@"Heraclitus", @"Aristotle", @"Epictetus", @"Schopenhauer", @"Popper"];
    _table = [[Table alloc] initWithChopsticks:self.names.count];
}

- (void)tearDown
{
    [self.table tbak_suspend];
    
    for (NSString *name in self.names) {
        [TBActorSupervisionPool.sharedInstance[name] tbak_suspend];
    }
    
    for (NSString *name in self.names) {
        [TBActorSupervisionPool.sharedInstance unsuperviseActorWithId:name];
    }
    [super tearDown];
}

- (void)testDiningPhilosophers
{
    for (NSString *name in self.names) {
        [TBActorSupervisionPool.sharedInstance superviseWithId:name creationBlock:^NSObject * _Nonnull {
            return [[Philosopher alloc] initWithName:name table:self.table sensitive:NO];
        }];
    }
    
    sleep(2);
    
    XCTAssert(YES, @"Pass");
}

- (void)testDiningPhilosophersSensitive
{
    for (NSString *name in self.names) {
        [TBActorSupervisionPool.sharedInstance superviseWithId:name creationBlock:^NSObject * _Nonnull {
            return [[Philosopher alloc] initWithName:name table:self.table sensitive:YES];
        }];
    }
    
    sleep(2);
    
    XCTAssert(YES, @"Pass");
}

@end
