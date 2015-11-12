//
//  ImageRequest.m
//  TestActorKit
//
//  Created by Julian Krumow on 21.08.15.
//  Copyright (c) 2015 Julian Krumow. All rights reserved.
//

#import "ImageRequest.h"
#import <ActorKit/ActorKit.h>

@interface ImageRequest ()
@property (nonatomic) AFHTTPRequestOperation *operation;
@end

@implementation ImageRequest

- (void)fetchImageAtUrl:(NSURL *)url
{
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    _operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    _operation.responseSerializer = [AFImageResponseSerializer serializer];
    
    __weak typeof(self) weakSelf = self;
    [_operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id object) {
        [weakSelf.actorQueue addOperationWithBlock:^{
            
            NSLog(@"received image from %@", operation.response.URL.absoluteString);
            
            [weakSelf publish:@"receivedImage" payload:object];
        }];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [weakSelf.actorQueue addOperationWithBlock:^{
            
            NSLog(@"received error %@ from %@", error.localizedDescription, operation.request.URL.absoluteString);
            
            [weakSelf publish:@"receivedError" payload:error];
        }];
    }];
    
    [self.actorQueue addOperation:_operation];
}

- (void)cancelFetch
{
    NSLog(@"cancelling request to url %@", self.operation.request.URL.absoluteString);
    [self.operation cancel];
}

@end
