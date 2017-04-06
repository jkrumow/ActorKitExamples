//
//  URLList.m
//  TestActorKit
//
//  Created by Julian Krumow on 06.04.17.
//  Copyright © 2017 Julian Krumow. All rights reserved.
//

#import "URLList.h"

@implementation URLList

+ (NSArray *)urlList
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"image_urls" ofType:@"json"];
    NSString *jsonString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    NSArray *urlStrings = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
    NSMutableArray *urls = [NSMutableArray new];
    for (NSString *urlString in urlStrings) {
        [urls addObject:[NSURL URLWithString:urlString]];
    }
    return urls;
}

@end
