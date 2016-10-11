//
//  TMDBMovieManagerTestCases.m
//  TMDB
//
//  Created by Kaushik Thekkekere on 10/10/16.
//  Copyright © 2016 Home. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TMDBMovieManager.h"
#import "TMDBMovie.h"

@interface TMDBMovieManagerTestCases : XCTestCase

@end

@implementation TMDBMovieManagerTestCases

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    
//    [[[XCUIApplication alloc] init] launch];
    

    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testInitialzation {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    TMDBMovieManager *moviemanager = [[TMDBMovieManager alloc]init];
    
    XCTAssertNotNil(moviemanager);
    
}

- (void)testDefaultSortProperty {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    TMDBMovieManager *moviemanager = [[TMDBMovieManager alloc]init];
    
    XCTAssertEqualObjects([NSNumber numberWithInt:moviemanager.sortBy], [NSNumber numberWithInt:0]);
    
}


- (void)testDefaultMaxListCountProperty {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    TMDBMovieManager *moviemanager = [[TMDBMovieManager alloc]init];
    
    XCTAssertEqualObjects([NSNumber numberWithUnsignedInteger:moviemanager.maxListCount], [NSNumber numberWithInt:50]);
    
}


- (void)testMaxListCountProperty {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    TMDBMovieManager *moviemanager = [[TMDBMovieManager alloc]init];
    moviemanager.maxListCount = 100;
    XCTAssertEqualObjects([NSNumber numberWithUnsignedInteger:moviemanager.maxListCount], [NSNumber numberWithInt:100]);
    
}


- (void)testSortByNameProperty {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    TMDBMovieManager *moviemanager = [[TMDBMovieManager alloc]init];
    moviemanager.sortBy = kSortByName;
    XCTAssertEqualObjects([NSNumber numberWithInt:moviemanager.sortBy], [NSNumber numberWithInt:1]);
    
}



@end
