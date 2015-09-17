//
//  ImageFetcher.h
//  TestActorKit
//
//  Created by Julian Krumow on 21.08.15.
//  Copyright (c) 2015 Julian Krumow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <ActorKit/ActorKit.h>
#import "ImageRequest.h"

@interface ImageFetcher : NSObject
@property (nonatomic, strong, readonly) TBActorPool *fetcherPool;
@property (nonatomic, strong, readonly) NSArray *urls;
@property (nonatomic, strong, readonly) NSArray *images;
@property (nonatomic, strong, readonly) NSArray *errors;

- (void)fetchImages:(NSArray *)urls;
- (void)cancelFetch;
- (void)handleImage:(UIImage *)image;
- (void)handleError:(NSError *)error;
@end
