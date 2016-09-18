//
//  Philosopher.h
//  TestActorKit
//
//  Created by Julian Krumow on 15.12.15.
//  Copyright © 2015 Julian Krumow. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Table;
@interface Philosopher : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) Table *table;
@property (nonatomic, assign, getter=isSensitive) BOOL sensitive;

- (instancetype)initWithName:(NSString *)name table:(Table *)table sensitive:(BOOL)sensitive;
- (void)think;
- (void)eat;
- (void)barf;
@end
