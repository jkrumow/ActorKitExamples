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
    [self.imageFetcher fetchImages:imageUrls];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
