//
//  Philosopher.m
//  TestActorKit
//
//  Created by Julian Krumow on 15.12.15.
//  Copyright © 2015 Julian Krumow. All rights reserved.
//

#import <ActorKit/Supervision.h>

#import "Philosopher.h"
#import "Table.h"

@implementation Philosopher

- (instancetype)initWithName:(NSString *)name table:(Table *)table
{
    self = [super init];
    if (self) {
        _name = name;
        _table = table;
        
        [self.table.async welcome:self.name];
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
    
    if ([self isFeelingWell]) {
        NSLog(@"%@ burps", self.name);
        [self.table.async dropChopsticks:self.name];
    } else {
        [self barf];
    }
}

- (void)barf
{
    NSLog(@"%@ gets sick", self.name);
    [self sleepForRandomInterval];
    NSLog(@"%@ barfs", self.name);
    
    NSString *message = [NSString stringWithFormat:@"%@ got sick.", self.name];
    @throw [NSException exceptionWithName:@"org.philosopher.error" reason:message userInfo:nil];
}

- (void)sleepForRandomInterval
{
    double interval =(rand() % 1000) / 1000.0;
    sleep(interval);
}

- (BOOL)isFeelingWell
{
    return rand() <  0.8 * ((double)RAND_MAX + 1.0);
}

@end
