//
//  Table.m
//  TestActorKit
//
//  Created by Julian Krumow on 15.12.15.
//  Copyright © 2015 Julian Krumow. All rights reserved.
//

#import <ActorKit/Supervision.h>

#import "Table.h"
#import "Philosopher.h"

NSUInteger const CHOPSTICK_FREE = 0;
NSUInteger const  CHOPSTICK_USED = 1;

@implementation Table
- (instancetype)initWithChopsticks:(NSUInteger)chopSticks
{
    self = [super init];
    if (self) {
        _philosophers = [NSMutableOrderedSet new];
        _eating = [NSMutableOrderedSet new];
        _chopsticks = [NSMutableArray new];
        
        for (int i=0; i < chopSticks; i++) {
            [_chopsticks addObject:@(CHOPSTICK_FREE)];
        }
    }
    return self;
}

- (void)welcome:(NSString *)name
{
    [self.philosophers addObject:name];
    Philosopher *philosopher = TBActorSupervisionPool.sharedInstance[name];
    
    // re-entry through supervision
    if ([self.eating containsObject:name]) {
        NSLog(@"%@ is well again", name);
        [philosopher.async eat];
    } else {
        NSLog(@"%@ has sat down at the table", name);
        [philosopher.async think];
    }
}

- (void)hungry:(NSString *)name
{
    if (![self.philosophers containsObject:name]) {
        NSLog(@"ERROR: A philosopher %@ is not even sat down", name);
    }
    NSUInteger index = [self.philosophers indexOfObject:name];
    NSUInteger leftPosition = index;
    NSUInteger rightPosition = (index + 1) % self.chopsticks.count;
    
    if ([self.chopsticks[leftPosition] integerValue] == CHOPSTICK_FREE && [self.chopsticks[rightPosition] integerValue] == CHOPSTICK_FREE) {
        self.chopsticks[leftPosition] = @(CHOPSTICK_USED);
        self.chopsticks[rightPosition] = @(CHOPSTICK_USED);
        [self.eating addObject:name];
        
        [self printTableStatus];
        
        Philosopher *philosopher = TBActorSupervisionPool.sharedInstance[name];
        [philosopher.async eat];
        
        if (self.eating.count == self.chopsticks.count) {
            NSLog(@"ERROR: TOO MANY PHILOSOPHERS ARE EATING");
        }
    } else {
        [self printTableStatus];
        
        Philosopher *philosopher = TBActorSupervisionPool.sharedInstance[name];
        [philosopher.async think];
    }
}

- (void)dropChopsticks:(NSString *)name
{
    if (![self.philosophers containsObject:name]) {
        NSLog(@"ERROR: A philosopher %@ is not even sat down", name);
    }
    NSUInteger index = [self.philosophers indexOfObject:name];
    NSUInteger leftPosition = index;
    NSUInteger rightPosition = (index + 1) % self.chopsticks.count;
    
    if (![self.chopsticks[leftPosition] integerValue] == CHOPSTICK_USED && [self.chopsticks[rightPosition] integerValue] == CHOPSTICK_USED) {
        NSLog(@"ERROR: philosopher %@ without both chopsticks thinks he had eaten", name);
    }
    self.chopsticks[leftPosition] = @(CHOPSTICK_FREE);
    self.chopsticks[rightPosition] = @(CHOPSTICK_FREE);
    [self.eating removeObject:name];
    
    [self printTableStatus];
    
    Philosopher *philosopher = TBActorSupervisionPool.sharedInstance[name];
    [philosopher.async think];
}

- (void)printTableStatus
{
    NSLog(@"| eating: %@ chopsticks: %@ |", [self.eating.array componentsJoinedByString:@" "], [self.chopsticks componentsJoinedByString:@" "]);
}


@end
