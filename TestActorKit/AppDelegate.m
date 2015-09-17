//
//  AppDelegate.m
//  TestActorKit
//
//  Created by Julian Krumow on 20.08.15.
//  Copyright (c) 2015 Julian Krumow. All rights reserved.
//

#import <GHRunLoopWatchdog/GHRunLoopWatchdog.h>

#import "AppDelegate.h"
#import "ViewController.h"
#import "ImageFetcher.h"

@interface AppDelegate ()
@property (nonatomic, strong) GHRunLoopWatchdog *runloopWatchdog;
@property (nonatomic, strong) ImageFetcher *imageFetcher;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    ViewController *viewController = (ViewController *)self.window.rootViewController;
    viewController.appDelegate = self;
    
    self.runloopWatchdog = [[GHRunLoopWatchdog alloc] initWithRunLoop:CFRunLoopGetMain()];
    [self.runloopWatchdog startWatchingMode:kCFRunLoopCommonModes];
    self.runloopWatchdog.didStallWithDuration = ^(NSTimeInterval duration) {
        
    };
    
    return YES;
}

- (void)fetchImages
{
    NSArray *imageUrls = @[
                           [NSURL URLWithString:@"http://www.queenworld.com/cmsAdmin/uploads/mainpage_image_the_band_bw.png"],
                           [NSURL URLWithString:@"http://i1.ytimg.com/vi/a01QQZyl-_I/0.jpg"],
                           [NSURL URLWithString:@"https://gp1.wac.edgecastcdn.net/802892/production_public/Artist/133886/image/small/220px-QueenBand.jpg"],
                           [NSURL URLWithString:@"http://resources3.news.com.au/images/2014/05/19/1226923/257987-b1efbfea-df26-11e3-ada0-03258d7c0c20.jpg"],
                           [NSURL URLWithString:@"http://chantduchoeur.de/blog/wp-content/uploads/2012/02/queen.jpg"],
                           [NSURL URLWithString:@"http://static.guim.co.uk/sys-images/Music/Pix/pictures/2011/9/20/1316514596907/Queen-in-the-late-70s-006.jpg"],
                           [NSURL URLWithString:@"http://www.queen-tribute.de/band90.JPG"],
                           [NSURL URLWithString:@"http://images.zeit.de/kultur/musik/2014-01/queen/queen-540x304.jpg"],
                           [NSURL URLWithString:@"http://resources1.news.com.au/images/2014/05/19/1226923/258041-270da4d2-df26-11e3-ada0-03258d7c0c20.jpg"],
                           [NSURL URLWithString:@"https://upload.wikimedia.org/wikipedia/commons/2/29/Queen_1976.JPG"],
                           [NSURL URLWithString:@"http://i.telegraph.co.uk/multimedia/archive/01906/Queen_1906434c.jpg"],
                           [NSURL URLWithString:@"http://i.dailymail.co.uk/i/pix/2009/04/18/article-1169307-01EC3A8F0000044D-100_306x469.jpg"],
                           ];
    
    self.imageFetcher = [ImageFetcher new];
    [self.imageFetcher.async fetchImages:imageUrls];
}

@end
