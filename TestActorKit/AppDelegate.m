//
//  AppDelegate.m
//  TestActorKit
//
//  Created by Julian Krumow on 20.08.15.
//  Copyright (c) 2015 Julian Krumow. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "ImageFetcher.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    ViewController *viewController = (ViewController *)self.window.rootViewController;
    viewController.appDelegate = self;
    
    [self _superviseActors];
    return YES;
}

- (void)_superviseActors
{
    [TBActorSupervisionPool.sharedInstance superviseWithId:@"imageFetcher" creationBlock:^NSObject * _Nonnull {
        return [ImageFetcher new];
    }];
    
    [TBActorSupervisionPool.sharedInstance superviseWithId:@"fetcherPool" creationBlock:^NSObject * _Nonnull {
        return [ImageRequest poolWithSize:10 configuration:nil];
    }];
}

- (void)fetchImages
{
    
    [[TBActorSupervisionPool.sharedInstance[@"imageFetcher"] async] fetchImages:self.imageURLs];
}

- (NSArray *)imageURLs
{
    if (_imageURLs == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"image_urls" ofType:@"json"];
        NSString *jsonString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        NSArray *urlStrings = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
        NSMutableArray *urls = [NSMutableArray new];
        for (NSString *urlString in urlStrings) {
            [urls addObject:[NSURL URLWithString:urlString]];
        }
        _imageURLs = urls;
    }
    return _imageURLs;
}

@end
