//
//  NSString+ChatParsing.h
//  ATask
//
//  Created by Vlad on 9/12/2015.
//  Copyright © 2015 Vlad Paraschiv. All rights reserved.
//

//
//  This class is a category on NSString to extend functionality
//  for parsing strings out that match our patterns for @mention
//  URLs and emoticons.
//

#import <Foundation/Foundation.h>

@interface NSString_ChatParsing : NSObject

/**
 *  Returns all string occurenses of @mention
 */
+ (NSArray<NSString*>*)parsePersons;

/**
 *  Returns all string occurenses URLs
 */
+ (NSArray<NSString*>*)parseURLs;

/**
 *  Returns all string emoticons
 */
+ (NSArray<NSString*>*)parseEmoticons;

@end
