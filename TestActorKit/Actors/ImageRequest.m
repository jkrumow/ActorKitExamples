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
        [weakSelf.actorQueue addOperationWithBlock:^{
            
            NSLog(@"received image from %@", operation.response.URL.absoluteString);
            [weakSelf publish:@"receivedImage" payload:image];
        }];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [weakSelf.actorQueue addOperationWithBlock:^{
            
            NSLog(@"received error %@ from %@", error.localizedDescription, operation.request.URL.absoluteString);
            [weakSelf crashWithError:error];
        }];
    }];
    
    [self.actorQueue addOperation:_operation];
}

@end
