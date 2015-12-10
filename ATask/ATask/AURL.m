//
//  AURL.m
//  ATask
//
//  Created by Vlad on 9/12/2015.
//  Copyright © 2015 Vlad Paraschiv. All rights reserved.
//

#import "AURL.h"

#import "TFHpple.h"

@interface AURL ()

@property (nonatomic, strong) NSURL       *urlPath;
@property (nonatomic, strong) NSString    *urlTitle;

@end

static NSString* const kURLJSONPlaceholder = @"{ \"url:\"\"%@\"\n, \"title:\"\"%@\"\n }";


@implementation AURL

- (instancetype)initWithString:(NSString*)string
{
    self = [super init];
    if (self && string) {
        if (string){
            _urlPath  = [NSURL URLWithString:string];
            _urlTitle = [self resolveURLTitle:_urlPath];
        }
    }
    return self;
}

- (NSString*)jsonString
{
    NSString *jsonString = [NSString stringWithFormat:kURLJSONPlaceholder,self.urlPath,self.urlTitle];
    
    return jsonString;
}


//====================================
#pragma mark - Private Helpers
//====================================

/**
 *  Resolves URL title for a given URL
 *  @param urlPath
 *  @return page title extracted from DOM or empty string if not found
 */
- (NSString*)resolveURLTitle:(NSURL*)urlPath
{
    NSData *urlData = [NSData dataWithContentsOfURL:urlPath];
    
    TFHpple *parser = [TFHpple hppleWithHTMLData:urlData];
    NSString *titleXPath = @"/html/head/title";
    
    NSArray *matches = [parser searchWithXPathQuery:titleXPath];
    TFHppleElement *titleElement = [matches firstObject];
    
    NSString *title = @"";
    if (titleElement){
        title = titleElement.content;
    }

    return title;
}

@end
