//
//  ImageFetcher.m
//  TestActorKit
//
//  Created by Julian Krumow on 21.08.15.
//  Copyright (c) 2015 Julian Krumow. All rights reserved.
//

#import "ImageFetcher.h"

@implementation ImageFetcher

- (instancetype)init
{
    self = [super init];
    if (self) {
        _fetcherPool = [ImageRequest poolWithSize:10 configuration:^(NSObject *actor, NSUInteger index) {
            
        }];
        
        [self.fetcherPool subscribe:@"fetchImage" selector:@selector(fetchImageAtUrl:)];
        [self subscribe:@"receivedImage" selector:@selector(handleImage:)];
        [self subscribe:@"receivedError" selector:@selector(handleError:)];
    }
    return self;
}

- (void)fetchImages:(NSArray *)urls
{
    _urls = urls;
    for (NSURL *url in _urls) {
//        [self.fetcherPool.async fetchImageAtUrl:url];
        [self publish:@"fetchImage" payload:url];
    }
}

- (void)handleImage:(UIImage *)image
{
    
}

- (void)handleError:(NSError *)error
{
    
}

@end
