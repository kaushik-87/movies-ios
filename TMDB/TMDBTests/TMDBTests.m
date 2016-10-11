//
//  TMDBTests.m
//  TMDBTests
//
//  Created by Kaushik Thekkekere on 10/10/16.
//  Copyright © 2016 Home. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ViewController.h"
#import "TMDBMovieDetailsViewController.h"
#import "TMDBAPIManager.h"

@interface TMDBTests : XCTestCase

@end

@implementation TMDBTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testViewControllerInitialization {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                             bundle: nil];
    
    ViewController *viewController  = [mainStoryboard instantiateViewControllerWithIdentifier: @"listView"];
    
    XCTAssertNotNil(viewController);
}


- (void)testDetailsViewControllerInitialization {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                             bundle: nil];
    
    TMDBMovieDetailsViewController *detailsViewController = [mainStoryboard instantiateViewControllerWithIdentifier: @"movieDetails"];
    XCTAssertNotNil(detailsViewController);
}


- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testTMDBAPISingleInstance
{
    TMDBAPIManager *apiManagerOne = [TMDBAPIManager sharedManager];
    TMDBAPIManager *apiManagerTwo = [TMDBAPIManager sharedManager];
    
    XCTAssertEqualObjects(apiManagerOne, apiManagerTwo);
}

@end
