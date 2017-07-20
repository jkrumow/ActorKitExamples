//
//  PhilosopherSupervised.h
//  TestActorKit
//
//  Created by Julian Krumow on 15.12.15.
//  Copyright © 2015 Julian Krumow. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TableSupervised;
@interface PhilosopherSupervised : NSObject

@property (nonatomic) NSString *name;

- (instancetype)initWithName:(NSString *)name;
- (void)think;
- (void)eat;
- (void)barf;
@end
