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

static NSString* const kURLJSONPlaceholder = @"{\n \"url\" : \"%@\"\n, \"title\" : \"%@\"\n }";


@implementation AURL

- (instancetype)initWithString:(NSString*)string
{
    self = [super init];
    if (self && string) {
        if (string) {
            _urlPath  = [NSURL URLWithString:string];
            [self resolveURLTitle];
        }
    }
    return self;
}

- (NSString*)jsonString
{
    NSString *jsonString = [NSString stringWithFormat:kURLJSONPlaceholder,
                            self.urlPath,
                            self.urlTitle ?: @"resolving..."];
    
    return jsonString;
}


//====================================
#pragma mark - Public Methods
//====================================

/**
 *  Resolves URL title for the URL this class was initialized with
 *  @return page title extracted from DOM or empty string if not found
 */
- (void)resolveURLTitle
{
    // cannot resolve that which does not exist!
    if (self.urlPath == nil) {
        [self setValue:nil forKey:@"urlTitle"];
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSLog(@"Resolving URL title for: %@", weakSelf.urlPath);
        
        NSData *urlData = [NSData dataWithContentsOfURL:weakSelf.urlPath];
        if (urlData != nil)
        {
            TFHpple *parser = [TFHpple hppleWithHTMLData:urlData];
            NSArray *matches = [parser searchWithXPathQuery:@"/html/head/title"];
            
            TFHppleElement *titleElement = [matches firstObject];
            if (titleElement) {
                NSLog(@"Resolved URL: %@ to title: %@", weakSelf.urlPath, titleElement.content);
                [self setValue:titleElement.content forKey:@"urlTitle"];
            }
        }
        else
        {
            // no html content for url retrieved, (no internet connection or url is bad)
            [self setValue:nil forKey:@"urlTitle"];
        }
    });
}

@end
