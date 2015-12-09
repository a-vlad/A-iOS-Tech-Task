//
//  AURL.m
//  ATask
//
//  Created by Vlad on 9/12/2015.
//  Copyright © 2015 Vlad Paraschiv. All rights reserved.
//

#import "AURL.h"

@interface AURL ()

@property (nonatomic, strong) NSURL       *urlPath;
@property (nonatomic, strong) NSString    *urlTitle;

@end


@implementation AURL

- (instancetype)initWithString:(NSString*)string
{
    self = [super init];
    if (self) {
#warning - TODO:...
    }
    return self;
}

- (NSString*)generateJSONString
{
#warning - TODO:...
    return nil;
}

@end
