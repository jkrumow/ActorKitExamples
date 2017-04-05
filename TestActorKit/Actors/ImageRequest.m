//
//  ImageRequest.m
//  TestActorKit
//
//  Created by Julian Krumow on 21.08.15.
//  Copyright (c) 2015 Julian Krumow. All rights reserved.
//

#import "ImageRequest.h"
#import "ImageFetcher.h"

@implementation ImageRequest

- (void)fetchImageAtUrl:(NSURL *)url
{
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (error) {
        @throw [NSException exceptionWithName:NSGenericException reason:error.localizedDescription userInfo:nil];
    }
    UIImage *image = [UIImage imageWithData:data];
    if (image == nil) {
        @throw [NSException exceptionWithName:NSGenericException reason:@"No image data." userInfo:nil];
    }
    
    ImageFetcher *fetcher = self.supervisor.supervisionPool[@"imageFetcher"];
    [fetcher.async updateImage:image];
}

@end
