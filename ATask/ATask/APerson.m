//
//  APerson.m
//  ATask
//
//  Created by Vlad on 9/12/2015.
//  Copyright © 2015 Vlad Paraschiv. All rights reserved.
//

#import "APerson.h"

@interface APerson ()

@property (nonatomic, strong) NSString *name;

@end

static NSString* const kPersonJSONPlaceholder = @"\"%@\"";


@implementation APerson

- (instancetype)initWithString:(NSString*)string
{
    self = [super initWithString:string];
    if (self) {
        if (string && (string.length > 0)){
            _name = [string substringFromIndex:1];  // from 1 as we ignore the @ symbol
        }
    }
    return self;
}

- (NSString*)jsonString
{
    NSString *jsonString = [NSString stringWithFormat:kPersonJSONPlaceholder,self.name];
    
    return jsonString;
}

@end
