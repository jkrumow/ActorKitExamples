//
//  ImageFetcher.m
//  TestActorKit
//
//  Created by Julian Krumow on 21.08.15.
//  Copyright (c) 2015 Julian Krumow. All rights reserved.
//

#import "ImageFetcher.h"

@interface ImageFetcher ()
@property (nonatomic) NSMutableArray *priv_images;
@end

@implementation ImageFetcher

- (instancetype)init
{
    self = [super init];
    if (self) {
        _priv_images = [NSMutableArray new];
        
        [self subscribe:@"receivedImage" selector:@selector(_handleImage:)];
    }
    return self;
}

- (void)dealloc
{
    [self unsubscribe:@"receivedImage"];
}

- (NSArray *)images
{
    return self.priv_images.copy;
}

- (void)fetchImages:(NSArray *)urls
{
    [self.priv_images removeAllObjects];
    
    for (NSURL *url in urls) {
        TBActorPool *pool = self.supervisor.supervisionPool[@"fetcherPool"];
        [pool.async fetchImageAtUrl:url];
    }
}

- (void)_handleImage:(UIImage *)image
{
    [self.priv_images addObject:image];
    [self publish:@"receivedImages" payload:self.images];
}

@end
