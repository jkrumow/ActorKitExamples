//
//  ImageFetcher.m
//  TestActorKit
//
//  Created by Julian Krumow on 21.08.15.
//  Copyright (c) 2015 Julian Krumow. All rights reserved.
//

#import "ImageFetcher.h"

@interface ImageFetcher ()
@property (nonatomic, strong, readonly) NSMutableArray *priv_images;
@property (nonatomic, strong, readonly) NSMutableArray *priv_errors;
@end

@implementation ImageFetcher

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _priv_images = [NSMutableArray new];
        
        _fetcherPool = [ImageRequest poolWithSize:10 configuration:nil];
        
        [self subscribe:@"receivedImage" selector:@selector(handleImage:)];
        [self subscribe:@"receivedError" selector:@selector(handleError:)];
    }
    return self;
}

- (NSArray *)images
{
    return self.priv_images.copy;
}

- (NSArray *)errors
{
    return self.priv_errors.copy;
}

- (void)fetchImages:(NSArray *)urls
{
    _urls = urls;
    [self.priv_images removeAllObjects];
    [self.priv_errors removeAllObjects];

    for (NSURL *url in _urls) {
        [self.fetcherPool.async fetchImageAtUrl:url];
    }
}

- (void)handleImage:(UIImage *)image
{
    [self.priv_images addObject:image];
    [self _checkFinished];
}

- (void)handleError:(NSError *)error
{
    [self.priv_errors addObject:error];
    [self _checkFinished];
}

-(void)_checkFinished
{
    if ((self.priv_images.count + self.priv_errors.count) == self.urls.count) {
        [self publish:@"fetchFinished" payload:self.images];
    }
}

@end
