//
//  MainViewControllerTests.m
//  HackerNewsiOS
//
//  Created by Qi.Wang on 11/20/15.
//  Copyright © 2015 kiki. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "ViewController.h"

@interface MainViewControllerTests : XCTestCase

@property (nonatomic) ViewController *vcToTest;

@end

@implementation MainViewControllerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    self.vcToTest = [[ViewController alloc] init];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    NSString *time = [self.vcToTest convertReadableTime:11874.460389018059];
    NSString *expectedtime = @"3 hrs ago";
    XCTAssertEqualObjects(time, expectedtime, @"not right");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
