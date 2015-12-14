//
//  ATaskTests.m
//  ATaskTests
//
//  Created by Vlad on 9/12/2015.
//  Copyright © 2015 Vlad Paraschiv. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "AMessageConstruct.h"

@interface ATaskTests : XCTestCase

@end


@implementation ATaskTests

- (void)setUp
{
    [super setUp];
    // no setup required
}

- (void)tearDown
{
    // no teardown required
    [super tearDown];
}


// Tests parsing String into JSON with @mentions
- (void)testParsing
{
    NSString *testString = @"@jeanne you around? @vlad are you also around? \n @tim can you parse this? or this @john? (wink)";
    
    AMessageConstruct *construct = [[AMessageConstruct alloc] initWithString:testString];
    
    NSString *jsonString = [construct jsonString];
    NSLog(@"%@",jsonString);
    
    XCTAssert(jsonString);  // simple check if not nil
    
    // check parsing count
    XCTAssertEqual(construct.persons.count, 4);
    XCTAssertEqual(construct.emoticons.count, 1);
    XCTAssertEqual(construct.urls.count, 0);
}


// Tests parsing String into JSON with @mentions
- (void)testParsingMentions
{
    NSString *testString = @"@chris you around?";
    
    AMessageConstruct *construct = [[AMessageConstruct alloc] initWithString:testString];
    
    NSString *jsonString = [construct jsonString];
    NSLog(@"%@",jsonString);
    
    XCTAssert(jsonString);  // simple check if not nil
    
    // check parsing count
    XCTAssertEqual(construct.persons.count, 1);
    XCTAssertEqual(construct.emoticons.count, 0);
    XCTAssertEqual(construct.urls.count, 0);
}

// Tests parsing String into JSON with @mentions
- (void)testParsingURLs
{
    NSString *testString = @"Olympics are starting soon; http://www.nbcolympics.com";
    
    AMessageConstruct *construct = [[AMessageConstruct alloc] initWithString:testString];
    
    NSString *jsonString = [construct jsonString];
    NSLog(@"%@",jsonString);
    
    XCTAssert(jsonString);  // simple check if not nil
    
    // check parsing count
    XCTAssertEqual(construct.persons.count, 0);
    XCTAssertEqual(construct.emoticons.count, 0);
    XCTAssertEqual(construct.urls.count, 1);
}

// Tests parsing String into JSON with @mentions
- (void)testParsingEmoticons
{
    NSString *testString = @"@Good morning! (megusta) (coffee)";
    
    AMessageConstruct *construct = [[AMessageConstruct alloc] initWithString:testString];
    
    NSString *jsonString = [construct jsonString];
    NSLog(@"%@",jsonString);
    
    XCTAssert(jsonString);  // simple check if not nil
    
    // check parsing count
    XCTAssertEqual(construct.persons.count, 1);
    XCTAssertEqual(construct.emoticons.count, 2);
    XCTAssertEqual(construct.urls.count, 0);
}

// Tests parsing all emoticons
- (void)testParsingAllString
{
    NSString *testString = @"@bob @john (success) such a cool feature; https://twitter.com/jdorfman/status/430511497475670016";
    
    AMessageConstruct *construct = [[AMessageConstruct alloc] initWithString:testString];
    
    NSString *jsonString = [construct jsonString];
    NSLog(@"%@",jsonString);
    

    XCTAssert(jsonString);
    
    // check parsing count
    XCTAssertEqual(construct.persons.count, 2);
    XCTAssertEqual(construct.emoticons.count, 1);
    XCTAssertEqual(construct.urls.count, 1);
}

// Simple URL title check
- (void)testParsingURLTitle
{
    NSString *testString = @"@bob @john (success) such a cool feature; https://twitter.com/jdorfman/status/430511497475670016";
    
    AMessageConstruct *construct = [[AMessageConstruct alloc] initWithString:testString];
    
    NSString *jsonString = [construct jsonString];
    NSLog(@"%@",jsonString);
    
    
    XCTAssert(jsonString);
    
    // check parsing count
    XCTAssertEqual(construct.urls.count, 1);
    XCTAssertGreaterThan(construct.urls[0].urlTitle.length, 1); // check url title has been determined
    
}

@end
