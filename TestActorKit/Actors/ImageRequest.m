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
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFImageResponseSerializer serializer];
    
    __weak typeof(self) weakSelf = self;
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, UIImage *image) {
        [weakSelf.async handleSuccess:image operation:operation];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [weakSelf.async handleError:error operation:operation];
    }];
    
    [self.actorQueue addOperation:operation];
}

- (void)handleSuccess:(UIImage *)image operation:(AFHTTPRequestOperation *)operation
{
    NSLog(@"received image from %@", operation.response.URL.absoluteString);
    [self publish:@"receivedImage" payload:image];
}

- (void)handleError:(NSError *)error operation:(AFHTTPRequestOperation *)operation
{
    NSLog(@"received error %@ from %@", error.localizedDescription, operation.request.URL.absoluteString);
    [self crashWithError:error];
}

@end
