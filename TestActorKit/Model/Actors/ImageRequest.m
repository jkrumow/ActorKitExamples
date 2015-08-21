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
    
    __block AFHTTPRequestOperation *blockOperation = operation;
    operation.completionBlock = ^{
        
        [self.actorQueue addOperationWithBlock:^{
            
            if (blockOperation.error) {
                [self publish:@"receivedError" payload:blockOperation.error];
            } else {
                [self publish:@"receivedImage" payload:blockOperation.responseObject];
            }
        }];
    };
    
    [self.actorQueue addOperation:operation];
}

@end
