//
//  ABaseModel.m
//  ATask
//
//  Created by Vlad on 9/12/2015.
//  Copyright © 2015 Vlad Paraschiv. All rights reserved.
//

#import "ABaseModel.h"

@implementation ABaseModel

- (instancetype)initWithString:(NSString*)string
{
    self = [super init];
    if (self) {
        /* nothing to do here, subclasses will implement their own init method accordingly */
    }
    return self;
}

/**
 *  Generates JSON string model properties
 */
- (NSString*)generateJSONString
{
    /* nothing to do here, subclasses will implement their own init method accordingly */
    return nil;
}

@end
