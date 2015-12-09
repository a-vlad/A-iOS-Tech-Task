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

#import "APerson.h"
#import "AURL.h"
#import "AEmoticon.h"


@interface NSString (ChatParsing)

/**
 *  Returns all string occurenses of @mention
 */
- (NSArray<APerson*>*)parsePersons;

/**
 *  Returns all string occurenses URLs
 */
- (NSArray<AURL*>*)parseURLs;

/**
 *  Returns all string emoticons
 */
- (NSArray<AEmoticon*>*)parseEmoticons;

@end
