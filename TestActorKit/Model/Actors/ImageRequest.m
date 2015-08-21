//
//  ImageRequest.m
//  TestActorKit
//
//  Created by Julian Krumow on 21.08.15.
//  Copyright (c) 2015 Julian Krumow. All rights reserved.
//

#import "ImageRequest.h"
#import <ActorKit/ActorKit.h>

@implementation ImageRequest

- (void)fetchImageAtUrl:(NSURL *)url
{
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFImageResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id object) {
        [self.actorQueue addOperationWithBlock:^{
            [self publish:@"receivedImage" payload:object];
        }];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self.actorQueue addOperationWithBlock:^{
            [self publish:@"receivedError" payload:error];
        }];
    }];
    
    [self.actorQueue addOperation:operation];
}

@end
