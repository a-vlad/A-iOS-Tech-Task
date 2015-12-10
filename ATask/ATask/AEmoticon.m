//
//  AEmoticon.m
//  ATask
//
//  Created by Vlad on 9/12/2015.
//  Copyright © 2015 Vlad Paraschiv. All rights reserved.
//

#import "AEmoticon.h"

@interface AEmoticon ()

@property (nonatomic, strong) NSString *emoticonName;

@end

static NSString* const kEmoticonJSONPlaceholder = @"\"%@\"";


@implementation AEmoticon

- (instancetype)initWithString:(NSString*)string
{
    self = [super initWithString:string];
    if (self) {
        if (string && string.length > 2)
        {
            _emoticonName = [string substringWithRange:NSMakeRange(1, string.length-2)];
        }
    }
    return self;
}

- (NSString*)jsonString
{
    NSString *jsonString = [NSString stringWithFormat:kEmoticonJSONPlaceholder,self.emoticonName];
    
    return jsonString;
}

@end
