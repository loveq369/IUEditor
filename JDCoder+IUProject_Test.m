//
//  JDCoder+IUProject_Test.m
//  IUEditor
//
//  Created by Joodong Yang on 2014. 10. 27..
//  Copyright (c) 2014년 JDLab. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>
#import "IUProject.h"

@interface JDCoder_IUProject_Test : XCTestCase

@end

@implementation JDCoder_IUProject_Test{
    IUProject *project;
}

- (void)setUp {
    [super setUp];
    NSString *filePath = [NSString stringWithFormat:@"%@/sampleProject.iuml", NSTemporaryDirectory()];
    project = [[IUProject alloc] initWithCreation:@{IUProjectKeyAppName:@"sampleProject", IUProjectKeyIUFilePath:filePath}  error:nil];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)test1_encodeDecode {
    // This is an example of a functional test case.
    JDCoder *encoder = [[JDCoder alloc] init];
    [encoder encodeRootObject:project];
    
    IUProject *decodedProject = [encoder decodedAndInitializeObject];
    XCTAssertEqualObjects(decodedProject.name, @"sampleProject");
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
