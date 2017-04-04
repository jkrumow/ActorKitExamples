//
//  ViewController.m
//  TestActorKit
//
//  Created by Julian Krumow on 20.08.15.
//  Copyright (c) 2015 Julian Krumow. All rights reserved.
//

#import <ActorKit/ActorKit.h>

#import "ViewController.h"
#import "ImageCell.h"

@implementation ViewController

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _images = @[];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_displayImages:) name:@"receivedImages" object:nil];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCell" forIndexPath:indexPath];
    cell.imageView.image = nil;
    
    if (self.images[indexPath.item] != [NSNull null]) {
        cell.imageView.image = self.images[indexPath.item];
    }
    return cell;
}

- (IBAction)refresh:(id)sender
{
    [self.appDelegate fetchImages];
}

- (void)_displayImages:(NSNotification *)notification
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.images = notification.userInfo[TBAKActorPayload];
        [self.collectionView reloadData];
    });
}

@end
