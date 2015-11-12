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

@interface ViewController ()
@property (nonatomic) NSArray *images;
@end

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
    cell.imageView.image = [self.images objectAtIndex:indexPath.item];
    return cell;
}

- (IBAction)refresh:(id)sender {
    [self.appDelegate fetchImages];
}

- (void)_displayImages:(NSNotification *)notification
{
    self.images = notification.userInfo[TBAKActorPayload];
    
    NSLog(@"will display %lu images.", (unsigned long)self.images.count);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
    });
}

@end
