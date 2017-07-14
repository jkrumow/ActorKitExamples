//
//  Table.h
//  TestActorKit
//
//  Created by Julian Krumow on 15.12.15.
//  Copyright © 2015 Julian Krumow. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Table : NSObject

@property (nonatomic) NSMutableOrderedSet *philosopherNames;
@property (nonatomic) NSMutableOrderedSet *eating;
@property (nonatomic) NSMutableArray *chopsticks;

- (instancetype)initWithChopsticks:(NSUInteger)chopSticks;
- (void)welcome:(NSString *)name;
- (void)hungry:(NSString *)name;
- (void)dropChopsticks:(NSString *)name;
- (void)printTableStatus;
@end
