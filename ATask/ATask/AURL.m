//
//  AURL.m
//  ATask
//
//  Created by Vlad on 9/12/2015.
//  Copyright © 2015 Vlad Paraschiv. All rights reserved.
//

#import "AURL.h"

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

- (NSString*)generateJSONString
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
 */
- (NSString*)resolveURLTitle:(NSURL*)urlPath
{
#warning - TODO:...
    return @"";
}

@end
