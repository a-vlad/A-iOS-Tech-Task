//
//  AMessageConstruct.m
//  ATask
//
//  Created by Vlad on 9/12/2015.
//  Copyright © 2015 Vlad Paraschiv. All rights reserved.
//

#import "AMessageConstruct.h"

#import "NSString+ChatParsing.h"

@interface AMessageConstruct ()

@property (nonatomic, strong) NSArray<APerson*>   *persons;
@property (nonatomic, strong) NSArray<AURL*>      *urls;
@property (nonatomic, strong) NSArray<AEmoticon*> *emoticons;
@property (nonatomic, strong) NSString            *message;

@end


static NSString* const kMessageConstructJSONPlaceholder = @"{\n\"mentions\" : \n[ \n %@ \n ], \n\"emoticons\" : \n[ \n %@ \n ], \n\"links\" : \n[ \n %@ \n ] \n}";


@implementation AMessageConstruct

- (instancetype)initWithString:(NSString*)string
{
    self = [super initWithString:string];
    if (self && string)
    {
        _persons    = [string parsePersons];
        _urls       = [string parseURLs];
        _emoticons  = [string parseEmoticons];
        _message    = string;
    }
    return self;
}

- (NSString*)jsonString
{
    NSMutableString *personsJson    = [NSMutableString new];
    NSMutableString *urlsJson       = [NSMutableString new];
    NSMutableString *emoticonsJson  = [NSMutableString new];
    
    // create list of mentioned persons
    for (APerson *person in self.persons)
    {
        [personsJson appendString:[person jsonString]];
        
        // append comma if more objects in list
        if ([[self.persons lastObject] isEqual:person] == NO)
            [personsJson appendString:@", "];
    }

    // create list of urls
    for (AURL *url in self.urls)
    {
        [urlsJson appendString:[url jsonString]];
        
        // append comma if more objects in list
        if ([[self.urls lastObject] isEqual:url] == NO)
            [urlsJson appendString:@", \n"];
    }
    
    // create list of emoticons
    for (AEmoticon *emoticon in self.emoticons)
    {
        [emoticonsJson appendString:[emoticon jsonString]];
        
        // append comma if more objects in list
        if ([[self.emoticons lastObject] isEqual:emoticon] == NO)
            [emoticonsJson appendString:@", "];
    }
    
    NSString *jsonString = [NSString stringWithFormat:kMessageConstructJSONPlaceholder, personsJson, emoticonsJson, urlsJson];
    
    return jsonString;
}

@end
