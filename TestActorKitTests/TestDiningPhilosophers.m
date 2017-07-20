//
//  TestDiningPhilosophers.m
//  TestActorKit
//
//  Created by Julian Krumow on 20.07.17.
//  Copyright © 2017 Julian Krumow. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <ActorKit/ActorKit.h>

#import "Table.h"
#import "Philosopher.h"

@interface TestDiningPhilosophers : XCTestCase

@property (nonatomic) Table *table;
@property (nonatomic) NSArray <NSString *> *philosopherNames;
@property (nonatomic) NSMutableArray <Philosopher *> * philosophers;
@end

@implementation TestDiningPhilosophers

- (void)setUp
{
    [super setUp];
    
    _philosopherNames = @[@"Heraclitus", @"Aristotle", @"Epictetus", @"Schopenhauer", @"Popper"];
    _philosophers = [NSMutableArray new];
}

- (void)tearDown
{
    [self.table tbak_suspend];
    
    for (Philosopher *philosopher in self.philosophers) {
        [philosopher tbak_suspend];
    }
    
    [super tearDown];
}

- (void)test
{
    _table = [[Table alloc] initWithChopsticks:self.philosopherNames.count];
    
    for (NSString *name in self.philosopherNames) {
        Philosopher *philosopher = [[Philosopher alloc] initWithName:name table:self.table];
        [self.philosophers addObject:philosopher];
    }
    
    sleep(2);
    
    XCTAssert(YES, @"Pass");
}

@end
