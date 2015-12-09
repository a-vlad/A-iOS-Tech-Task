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
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


// Tests parsing String into JSON with @mentions
- (void)testParsingMentions
{
    NSString *testString = @"@chris you around?";
    
    AMessageConstruct *construct = [[AMessageConstruct alloc] initWithString:testString];
    
    NSString *jsonString = [construct generateJSONString];
    
    XCTAssert(jsonString);  // simple check if not nil
}

//- (void)testPerformanceExample {
//    // This is an example of a performance test case.
//    [self measureBlock:^{
//        // Put the code you want to measure the time of here.
//    }];
//}

@end
