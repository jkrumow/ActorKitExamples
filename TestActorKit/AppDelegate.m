//
//  AppDelegate.m
//  TestActorKit
//
//  Created by Julian Krumow on 20.08.15.
//  Copyright (c) 2015 Julian Krumow. All rights reserved.
//

#import "AppDelegate.h"
#import "URLList.h"
#import "ImageFetcher.h"
#import "ViewController.h"


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    ViewController *viewController = (ViewController *)self.window.rootViewController;
    viewController.appDelegate = self;
    
    _imageURLs = [URLList urlList];
    [self _superviseActors];
    return YES;
}

- (void)_superviseActors
{
    [TBActorSupervisionPool.sharedInstance superviseWithId:@"imageFetcher" creationBlock:^NSObject * _Nonnull {
        return [ImageFetcher new];
    }];
    
    [TBActorSupervisionPool.sharedInstance superviseWithId:@"imageRequest" creationBlock:^NSObject * _Nonnull {
        return [ImageRequest new];
    }];
}

- (void)fetchImages
{
    [[TBActorSupervisionPool.sharedInstance[@"imageFetcher"] async] fetchImages:self.imageURLs];
}

@end
