//
//  AStringConstruct.m
//  ATask
//
//  Created by Vlad on 9/12/2015.
//  Copyright © 2015 Vlad Paraschiv. All rights reserved.
//

#import "AStringConstruct.h"
#import "NSString+ChatParsing.h"

@interface AStringConstruct ()

@property (nonatomic, strong) NSArray<APerson*>   *persons;
@property (nonatomic, strong) NSArray<AURL*>      *urls;
@property (nonatomic, strong) NSArray<AEmoticon*> *emoticons;

@end


@implementation AStringConstruct

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
