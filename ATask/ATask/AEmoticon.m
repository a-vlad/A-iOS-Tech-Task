//
//  AEmoticon.m
//  ATask
//
//  Created by Vlad on 9/12/2015.
//  Copyright © 2015 Vlad Paraschiv. All rights reserved.
//

#import "AEmoticon.h"

@interface AEmoticon ()

@property (nonatomic) AEmoticonKind     emoticonKind;
@property (nonatomic, strong) NSString  *emoticonString;
@property (nonatomic, strong) NSURL     *emoticonImagePath;

@end

static NSString* const kEmoticonJSONPlaceholder = @"\"%@\"";
static NSDictionary* emoticonImagePaths;    // maps emoticon name to a URL image path
static NSDictionary* emoticonKindNames;     // maps emoticon name to ENUM kind


@implementation AEmoticon

- (instancetype)initWithString:(NSString*)string
{
    self = [super initWithString:string];
    if (self)
    {
        emoticonImagePaths = @{  @"allthethings"    : @"https://dujrsrsgsd3nh.cloudfront.net/img/emoticons/allthethings-1414024836.png",
                                 @"android"         : @"https://dujrsrsgsd3nh.cloudfront.net/img/emoticons/android-1414024011.png",
                                 @"areyoukiddingme" : @"https://dujrsrsgsd3nh.cloudfront.net/img/emoticons/areyoukiddingme-1414024355.png",
                                 @"arringoton"      : @"https://dujrsrsgsd3nh.cloudfront.net/img/emoticons/arrington-1414023805.png",
                                 @"arya"            : @"https://dujrsrsgsd3nh.cloudfront.net/img/emoticons/arya-1414028821.png",
                                 @"ashton"          : @"https://dujrsrsgsd3nh.cloudfront.net/img/emoticons/ashton-1414025136.png",
                                 @"atlassian"       : @"https://dujrsrsgsd3nh.cloudfront.net/img/emoticons/atlassian-1414025304.png",
                                    //...
                                };
        
        emoticonKindNames = @{  @"allthethings"    : @1,
                                @"android"         : @2,
                                @"areyoukiddingme" : @3,
                                @"arringoton"      : @4,
                                @"arya"            : @5,
                                @"ashton"          : @6,
                                @"atlassian"       : @7,
                                 //...
                                 };
        
        if (string && string.length > 2)
        {
            _emoticonString = [string substringWithRange:NSMakeRange(1, string.length-2)];
            NSNumber *kindNumber = emoticonKindNames[_emoticonString];
            if (kindNumber)
                _emoticonKind = [kindNumber intValue];
            else
                _emoticonKind = AEmoticonNotFound;
        }
    }
    
    return self;
}

- (NSString*)jsonString
{
    NSString *jsonString = [NSString stringWithFormat:kEmoticonJSONPlaceholder,self.emoticonString];
    
    return jsonString;
}


//=============================
#pragma mark - Public Methods
//=============================

- (NSURL*)emoticonImagePath
{
    NSString *pathString = emoticonImagePaths[self.emoticonString];
    NSURL *url = [NSURL URLWithString:pathString];
    
    return url;
}

@end
