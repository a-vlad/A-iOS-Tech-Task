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

@end

static NSString* const kMessageConstructJSONPlaceholder = @"{\"mentions\" : [ \n %@ \n ], \"emoticons\" : [ \n %@ \n ], \"links\" : [ \n %@ \n ], }";


@implementation AMessageConstruct

- (instancetype)initWithString:(NSString*)string
{
    self = [super initWithString:string];
    if (self && string)
    {
        _persons    = [string parsePersons];
        _urls       = [string parseURLs];
        _emoticons  = [string parseEmoticons];
    }
    return self;
}

- (NSString*)generateJSONString
{
    NSMutableString *personsJson    = [NSMutableString new];
    NSMutableString *urlsJson       = [NSMutableString new];
    NSMutableString *emoticonsJson  = [NSMutableString new];
    
    // create list of mentioned persons
    for (APerson *person in self.persons)
    {
        [personsJson appendString:[person generateJSONString]];
        
        // append comma if more objects in list
        if ([[self.persons lastObject] isEqual:person] == NO)
            [personsJson appendString:@","];
    }

    // create list of urls
    for (AURL *url in self.urls)
    {
        [urlsJson appendString:[url generateJSONString]];
        
        // append comma if more objects in list
        if ([[self.urls lastObject] isEqual:url] == NO)
            [urlsJson appendString:@","];
    }
    
    // create list of emoticons
    for (AEmoticon *emoticon in self.emoticons)
    {
        [emoticonsJson appendString:[emoticon generateJSONString]];
        
        // append comma if more objects in list
        if ([[self.emoticons lastObject] isEqual:emoticon] == NO)
            [emoticonsJson appendString:@","];
    }
    
    NSString *jsonString = [NSString stringWithFormat:kMessageConstructJSONPlaceholder, personsJson, emoticonsJson, urlsJson];
    
    return jsonString;
}

@end