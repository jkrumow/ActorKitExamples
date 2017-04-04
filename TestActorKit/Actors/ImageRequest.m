//
//  ImageRequest.m
//  TestActorKit
//
//  Created by Julian Krumow on 21.08.15.
//  Copyright (c) 2015 Julian Krumow. All rights reserved.
//

#import "ImageRequest.h"

@implementation ImageRequest

- (void)fetchImageAtUrl:(NSURL *)url
{
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (error) {
        [self handleError:error url:url];
        return;
    }
    
    UIImage *image = [UIImage imageWithData:data];
    if (image == nil) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        NSError *httpError = [NSError errorWithDomain:NSURLErrorDomain code:404 userInfo:nil];
        [self handleError:httpError url:httpResponse.URL];
        return;
    }
    [self handleSuccess:image url:url];
}

- (void)handleSuccess:(UIImage *)image url:(NSURL *)url
{
    NSLog(@"received image from %@", url.absoluteString);
    [self publish:@"receivedImage" payload:image];
}

- (void)handleError:(NSError *)error url:(NSURL *)url
{
    NSLog(@"received error %@ from %@", error.localizedDescription, url.absoluteString);
    [self crashWithError:error];
}

@end
