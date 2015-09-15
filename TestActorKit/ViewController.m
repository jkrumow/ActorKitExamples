//
//  ViewController.m
//  TestActorKit
//
//  Created by Julian Krumow on 20.08.15.
//  Copyright (c) 2015 Julian Krumow. All rights reserved.
//

#import <ActorKit/ActorKit.h>

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_displayImages:) name:@"receivedImages" object:nil];
}

- (void)_displayImages:(NSNotification *)notification
{
    NSArray *images = notification.userInfo[TBAKActorPayload];
    
    NSLog(@"will display %lu images.", (unsigned long)images.count);
    
    for (UIImage *image in images) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImageView *view = [[UIImageView alloc] initWithImage:image];
            CGFloat aspectRatio = image.size.width / image.size.height;
            view.frame = CGRectMake(0.0, 0.0, self.view.bounds.size.width, self.view.bounds.size.width / aspectRatio);
            [self.view addSubview:view];
        });
    }
}

@end
