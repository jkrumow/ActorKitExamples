//
//  TestSupervisedPhilosophers.m
//  TestActorKitTests
//
//  Created by Julian Krumow on 20.08.15.
//  Copyright (c) 2015 Julian Krumow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <ActorKit/Supervision.h>

#import "TableSupervised.h"
#import "PhilosopherSupervised.h"

@interface TestSupervisedPhilosophers : XCTestCase

@property (nonatomic) NSArray *philosophers;
@end

@implementation TestSupervisedPhilosophers

- (void)setUp
{
    [super setUp];
    
    _philosophers = @[@"Heraclitus", @"Aristotle", @"Epictetus", @"Schopenhauer", @"Popper"];
    
    [TBActorSupervisionPool.sharedInstance superviseWithId:@"table" creationBlock:^NSObject * _Nonnull {
        return [[TableSupervised alloc] initWithChopsticks:self.philosophers.count];
    }];
}

- (void)tearDown
{
    [TBActorSupervisionPool.sharedInstance[@"table"] tbak_suspend];
    [TBActorSupervisionPool.sharedInstance unsuperviseActorWithId:@"table"];
    
    for (NSString *name in self.philosophers) {
        [TBActorSupervisionPool.sharedInstance[name] tbak_suspend];
        [TBActorSupervisionPool.sharedInstance unsuperviseActorWithId:name];
    }
    
    [super tearDown];
}

- (void)test
{
    for (NSString *name in self.philosophers) {
        [TBActorSupervisionPool.sharedInstance superviseWithId:name creationBlock:^NSObject * _Nonnull {
            return [[PhilosopherSupervised alloc] initWithName:name];
        }];
    }
    
    sleep(2);
    
    XCTAssert(YES, @"Pass");
}

@end
