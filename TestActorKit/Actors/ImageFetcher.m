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
    }
    return self;
}

- (NSArray *)images
{
    return self.priv_images.copy;
}

- (void)fetchImages:(NSArray *)urls
{
    [self.priv_images removeAllObjects];
    
    for (NSURL *url in urls) {
        [self.priv_images addObject:[NSNull null]];
        ImageRequest *request = self.supervisor.supervisionPool[@"imageRequest"];
        
        ((AnyPromise *)[request.promise fetchImageAtUrl:url])
        .then(^(UIImage *image) {
            if (image) {
                [self.sync _handleImage:image];
            }
        });
    }
}

- (void)_handleImage:(UIImage *)image
{
    [self.priv_images removeObjectAtIndex:0];
    [self.priv_images addObject:image];
    [self publish:@"receivedImages" payload:self.images];
}

@end
