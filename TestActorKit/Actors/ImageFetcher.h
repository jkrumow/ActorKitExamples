//
//  ImageFetcher.h
//  TestActorKit
//
//  Created by Julian Krumow on 21.08.15.
//  Copyright (c) 2015 Julian Krumow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <ActorKit/Supervision.h>

#import "ImageRequest.h"

@interface ImageFetcher : NSObject
@property (nonatomic, readonly) NSArray *images;

- (void)fetchImages:(NSArray *)urls;
@end
