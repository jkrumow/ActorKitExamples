//
//  Philosopher.m
//  TestActorKit
//
//  Created by Julian Krumow on 15.12.15.
//  Copyright © 2015 Julian Krumow. All rights reserved.
//

#import <ActorKit/ActorKit.h>

#import "Philosopher.h"
#import "Table.h"

@implementation Philosopher

- (instancetype)initWithName:(NSString *)name table:(Table *)table
{
    self = [super init];
    if (self) {
        _name = name;
        _table = table;
        
        srand ((unsigned int)time(NULL));
        
        [self.table.async welcome:self];
    }
    return self;
}

- (void)think
{
    NSLog(@"%@ is thinking", self.name);
    [self sleepForRandomInterval];
    
    NSLog(@"%@ gets hungry", self.name);
    [self.table.async hungry:self.name];
}

- (void)eat
{
    NSLog(@"%@ is eating", self.name);
    [self sleepForRandomInterval];
    
    NSLog(@"%@ burps", self.name);
    [self.table.async dropChopsticks:self.name];
}

- (void)sleepForRandomInterval
{
    sleep([self randomNumberInRange:0 to:1000] / 1000.0);
}

- (NSInteger)randomNumberInRange:(NSInteger)from to:(NSInteger)to
{
    return to + rand() / (RAND_MAX / (from - to + 1) + 1);
}

@end
