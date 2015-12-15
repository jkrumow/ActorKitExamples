//
//  TestActorKitTests.m
//  TestActorKitTests
//
//  Created by Julian Krumow on 20.08.15.
//  Copyright (c) 2015 Julian Krumow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <ActorKit/ActorKit.h>

NSUInteger const CHOPSTICK_FREE = 0;
NSUInteger const  CHOPSTICK_USED = 1;

@class Table;
@interface Philosopher : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) Table *table;

- (instancetype)initWithName:(NSString *)name table:(Table *)table;
- (void)think;
- (void)eat;
@end

@interface Table : NSObject

@property (nonatomic) NSMutableArray *philosophers;
@property (nonatomic) NSMutableArray *chopsticks;
@property (nonatomic) NSMutableArray *eating;

- (instancetype)initWithChopsticks:(NSUInteger)chopSticks;
- (void)welcome:(Philosopher *)philosopher;
- (void)hungry:(Philosopher *)philosopher;
- (void)dropChopsticks:(Philosopher *)philosopher;
- (void)printTableStatus;
@end

@implementation Philosopher

- (instancetype)initWithName:(NSString *)name table:(Table *)table
{
    self = [super init];
    if (self) {
        _name = name;
        _table = table;
        
        [self.table.async welcome:self];
    }
    return self;
}

- (void)think
{
    NSLog(@"%@ is thinking", self.name);
    [self sleepForRandomInterval];
    NSLog(@"%@ gets hungry", self.name);
    [self.table.async hungry:self];
}

- (void)eat
{
    NSLog(@"%@ is eating", self.name);
    [self sleepForRandomInterval];
    NSLog(@"%@ burps", self.name);
    [self.table.async dropChopsticks:self];
}

- (void)sleepForRandomInterval
{
    double interval =(rand() % 1000) / 1000.0;
    sleep(interval);
}

@end

@implementation Table

- (instancetype)initWithChopsticks:(NSUInteger)chopSticks
{
    self = [super init];
    if (self) {
        _philosophers = [NSMutableArray new];
        _eating = [NSMutableArray new];
        _chopsticks = [NSMutableArray new];
        
        for (int i=0; i < chopSticks; i++) {
            [_chopsticks addObject:@(CHOPSTICK_FREE)];
        }
    }
    return self;
}

- (void)welcome:(Philosopher *)philosopher
{
    [self.philosophers addObject:philosopher];
    [philosopher.async think];
}

- (void)hungry:(Philosopher *)philosopher
{
    if (![self.philosophers containsObject:philosopher]) {
        @throw [NSException exceptionWithName:@"Exception" reason:@"A philosopher is not even sat down" userInfo:@{@"name":philosopher.name}];
    }
    NSUInteger index = [self.philosophers indexOfObject:philosopher];
    NSUInteger leftPosition = index;
    NSUInteger rightPosition = (index + 1) % self.chopsticks.count;
    
    if ([self.chopsticks[leftPosition] integerValue] == CHOPSTICK_FREE && [self.chopsticks[rightPosition] integerValue] == CHOPSTICK_FREE) {
        self.chopsticks[leftPosition] = @(CHOPSTICK_USED);
        self.chopsticks[rightPosition] = @(CHOPSTICK_USED);
        [self.eating addObject:philosopher];
        
        [self printTableStatus];
        
        [philosopher.async eat];
        
        if (self.eating.count == self.chopsticks.count) {
            @throw [NSException exceptionWithName:@"Exception" reason:@"TOO MANY PHILOSOPHERS ARE EATING" userInfo:@{@"name":philosopher.name}];
        }
        NSLog(@"TABLE: %lu are eating", (unsigned long)self.eating.count);
    } else {
        // it's not your turn, keep thinking
        [self printTableStatus];
        [philosopher.async think];
    }
}

- (void)dropChopsticks:(Philosopher *)philosopher
{
    if (![self.philosophers containsObject:philosopher]) {
        @throw [NSException exceptionWithName:@"Exception" reason:@"A philosopher is not even sat down" userInfo:@{@"name":philosopher.name}];
    }
    NSUInteger index = [self.philosophers indexOfObject:philosopher];
    NSUInteger leftPosition = index;
    NSUInteger rightPosition = (index + 1) % self.chopsticks.count;
    
    if (![self.chopsticks[leftPosition] integerValue] == CHOPSTICK_USED && [self.chopsticks[rightPosition] integerValue] == CHOPSTICK_USED) {
        @throw [NSException exceptionWithName:@"Exception" reason:@" philosopher without both chopsticks thinks he had eaten" userInfo:@{@"name":philosopher.name}];
    }
    self.chopsticks[leftPosition] = @(CHOPSTICK_FREE);
    self.chopsticks[rightPosition] = @(CHOPSTICK_FREE);
    [self.eating removeObject:philosopher];
    
    [self printTableStatus];
    
    [philosopher.async think];
}

- (void)printTableStatus
{
    NSLog(@"--------------");
    
    [self.philosophers enumerateObjectsUsingBlock:^(Philosopher  *philosopher, NSUInteger position, BOOL *stop) {
        if ([self.eating containsObject:philosopher]) {
            NSUInteger leftPosition = position;
            NSUInteger rightPosition = (position + 1) % self.chopsticks.count;
            NSLog(@"\t%@ %lu %lu", philosopher.name, (unsigned long)leftPosition, (unsigned long)rightPosition);
        }
    }];
    
    NSLog(@"----------------------");
}

@end

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

- (void)testDiningPhilosophers {
    
    NSArray *names = @[@"Heraclitus", @"Aristotle", @"Epictetus", @"Schopenhauer", @"Popper"];
    Table *table = [[Table alloc] initWithChopsticks:names.count];
    NSMutableArray *philosophers = [NSMutableArray new];
    for (NSString *name in names) {
        Philosopher *philosopher = [[Philosopher alloc] initWithName:name table:table];
        [philosophers addObject:philosopher];
    }
    
    sleep(60000);
    
    XCTAssert(YES, @"Pass");
}

@end
