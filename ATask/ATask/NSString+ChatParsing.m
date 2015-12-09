//
//  NSString+ChatParsing.m
//  ATask
//
//  Created by Vlad on 9/12/2015.
//  Copyright © 2015 Vlad Paraschiv. All rights reserved.
//

#import "NSString+ChatParsing.h"


@implementation NSString (ChatParsing)

- (NSArray<APerson*>*)parsePersons
{
    NSMutableArray *result = [NSMutableArray new];
    
    NSRange searchRange = NSMakeRange(0, self.length);
    NSString *pattern = @"@([A-Za-z]+[A-Za-z0-9]+)";
    NSError  *error = nil;
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:&error];
    
    NSArray *matches = [regex matchesInString:self options:0 range: searchRange];
    
    for (NSTextCheckingResult *match in matches) {
        NSString *matchText = [self substringWithRange:[match range]];
        APerson *person = [[APerson alloc] initWithString:matchText];
        [result addObject:person];
    }
    
    return result;
}

- (NSArray<AURL*>*)parseURLs
{
    NSMutableArray *result = [NSMutableArray new];
    
    NSRange searchRange = NSMakeRange(0, self.length);
    NSString *pattern = @"(https?:\\/\\/([^ ])+)";
    NSError  *error = nil;
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:&error];
    
    NSArray *matches = [regex matchesInString:self options:0 range: searchRange];
    
    for (NSTextCheckingResult *match in matches) {
        NSString *matchText = [self substringWithRange:[match range]];
        AURL *url = [[AURL alloc] initWithString:matchText];
        [result addObject:url];
    }
    
    return result;
}

- (NSArray<AEmoticon*>*)parseEmoticons
{
    NSMutableArray *result = [NSMutableArray new];
    
    NSRange searchRange = NSMakeRange(0, self.length);
    NSString *pattern = @"\\(([A-Za-z]+[A-Za-z0-9]+)\\)";
    NSError  *error = nil;
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:&error];
    
    NSArray *matches = [regex matchesInString:self options:0 range: searchRange];
    
    for (NSTextCheckingResult *match in matches) {
        NSString *matchText = [self substringWithRange:[match range]];
        AEmoticon *person = [[AEmoticon alloc] initWithString:matchText];
        [result addObject:person];
    }
    
    return result;
}

@end
