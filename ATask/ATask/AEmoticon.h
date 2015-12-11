//
//  AEmoticon.h
//  ATask
//
//  Created by Vlad on 9/12/2015.
//  Copyright © 2015 Vlad Paraschiv. All rights reserved.
//

//
//  Represents an emoticon object. This class will also map itself to the corresponding
//  image path for that emoticon and be represented by an ENUM. In future the mapping
//  could be done inside an external file (eg. CSV file) which could be parsed at runtime.
//

#import <Foundation/Foundation.h>

#import "AMessageComponent.h"

typedef NS_ENUM(NSUInteger, AEmoticonKind) {
    
    AEmoticonNotFound = 0,
    
    AEmoticonSmile = 1,
    AEmoticonLaugh,
    AEmoticonLol
    //... more can be added
};


@interface AEmoticon : AMessageComponent

@property (nonatomic, readonly) AEmoticonKind emoticonKind;

@property (nonatomic, readonly) NSString *emoticonString;
@property (nonatomic, readonly) NSURL *emoticonImagePath;

@end
