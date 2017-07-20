//
//  PhilosopherSupervised.m
//  TestActorKit
//
//  Created by Julian Krumow on 15.12.15.
//  Copyright © 2015 Julian Krumow. All rights reserved.
//

#import <ActorKit/Supervision.h>

#import "PhilosopherSupervised.h"
#import "TableSupervised.h"

@implementation PhilosopherSupervised

- (instancetype)initWithName:(NSString *)name
{
    self = [super init];
    if (self) {
        _name = name;
        
        srand ((unsigned int)time(NULL));
        
        [self.table.async welcome:self.name];
    }
    return self;
}

- (TableSupervised *)table
{
    return TBActorSupervisionPool.sharedInstance[@"table"];
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
    @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:message userInfo:nil];
}

- (void)sleepForRandomInterval
{
    sleep([self randomNumberInRange:0 to:1000] / 1000.0);
}

- (BOOL)isFeelingWell
{
    return ([self randomNumberInRange:0 to:9] <  8);
}

- (NSInteger)randomNumberInRange:(NSInteger)from to:(NSInteger)to
{
    return to + rand() / (RAND_MAX / (from - to + 1) + 1);
}

@end
