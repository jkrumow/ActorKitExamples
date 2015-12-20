//
//  ImageRequest.m
//  TestActorKit
//
//  Created by Julian Krumow on 21.08.15.
//  Copyright (c) 2015 Julian Krumow. All rights reserved.
//

#import "ImageRequest.h"
#import <ActorKit/Supervision.h>

@implementation ImageRequest

- (void)fetchImageAtUrl:(NSURL *)url
{
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    _operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    _operation.responseSerializer = [AFImageResponseSerializer serializer];
    
    __weak typeof(self) weakSelf = self;
    [_operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, UIImage *image) {
        [weakSelf.async handleSuccess:image operation:operation];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [weakSelf.async handleError:error operation:operation];
    }];
    
    [self.actorQueue addOperation:_operation];
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
