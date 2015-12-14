//
//  NSString+ChatParsing.m
//  ATask
//
//  Created by Vlad on 9/12/2015.
//  Copyright © 2015 Vlad Paraschiv. All rights reserved.
//

#import "NSString+ChatParsing.h"

static NSString* const kEmoticonRegEx   = @"\\B(\\(.[^ \\s]*?\\))";
static NSString* const kMentionRegEx    = @"\\B(@.[^ \\s]*)";
static NSString* const kURLRegEx        = @"\\b(https?:\\/\\/[^ \\s]+|www\\.[^ \\s]+)";


@implementation NSString (ChatParsing)

- (NSArray<APerson*>*)parsePersons
{
    NSMutableArray *result = [NSMutableArray new];
    
    NSRange searchRange = NSMakeRange(0, self.length);
    NSString *pattern = kMentionRegEx;
    NSError  *error = nil;
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:&error];
    
    if (!error){
        NSArray *matches = [regex matchesInString:self options:0 range: searchRange];
        for (NSTextCheckingResult *match in matches) {
            NSString *matchText = [self substringWithRange:[match range]];
            APerson *person = [[APerson alloc] initWithString:matchText];
            [result addObject:person];
        }
    }
    
    return result;
}

- (NSArray<AURL*>*)parseURLs
{
    NSMutableArray *result = [NSMutableArray new];
    
    NSRange searchRange = NSMakeRange(0, self.length);
    NSString *pattern = kURLRegEx;
    NSError  *error = nil;
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:&error];
    
    if (!error){
        NSArray *matches = [regex matchesInString:self options:0 range: searchRange];
        for (NSTextCheckingResult *match in matches) {
            NSString *matchText = [self substringWithRange:[match range]];
            AURL *url = [[AURL alloc] initWithString:matchText];
            [result addObject:url];
        }
    }
    
    return result;
}

- (NSArray<AEmoticon*>*)parseEmoticons
{
    NSMutableArray *result = [NSMutableArray new];
    
    NSRange searchRange = NSMakeRange(0, self.length);
    NSString *pattern = kEmoticonRegEx;
    NSError  *error = nil;
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:&error];
    
    if (!error){
        NSArray *matches = [regex matchesInString:self options:0 range: searchRange];
        for (NSTextCheckingResult *match in matches) {
            NSString *matchText = [self substringWithRange:[match range]];
            AEmoticon *person = [[AEmoticon alloc] initWithString:matchText];
            [result addObject:person];
        }
    }
    
    return result;
}

@end
