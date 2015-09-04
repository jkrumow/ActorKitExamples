//
//  ViewController.m
//  TestActorKit
//
//  Created by Julian Krumow on 20.08.15.
//  Copyright (c) 2015 Julian Krumow. All rights reserved.
//

#import "ViewController.h"
#import "ImageFetcher.h"

@interface ViewController ()
@property (nonatomic, strong)ImageFetcher *imageFetcher;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSArray *imageUrls = @[
                           [NSURL URLWithString:@"http://www.queenworld.com/cmsAdmin/uploads/mainpage_image_the_band_bw.png"],
                           [NSURL URLWithString:@"http://i1.ytimg.com/vi/a01QQZyl-_I/0.jpg"]
                           ];
    
    self.imageFetcher = [ImageFetcher new];
    [self subscribeToActor:self.imageFetcher messageName:@"fetchFinished" selector:@selector(showImages:)];
    [self.imageFetcher.async fetchImages:imageUrls];
}

- (void)showImages:(NSArray *)images
{
    dispatch_sync(dispatch_get_main_queue(), ^{
        for (UIImage *image in images) {
            UIImageView *view = [[UIImageView alloc] initWithImage:image];
            view.frame = CGRectMake(0.0, 0.0, image.size.width, image.size.height);
            [self.view addSubview:view];
        }
    });
}

@end
