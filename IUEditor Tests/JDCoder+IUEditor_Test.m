//
//  JDCoder+IUEditor_Test.m
//  IUEditor
//
//  Created by Joodong Yang on 2014. 10. 27..
//  Copyright (c) 2014년 JDLab. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <XCTest/XCTest.h>
#import "IUBox.h"

@interface JDCoder_IUEditor_Test : XCTestCase

@end

@implementation JDCoder_IUEditor_Test{
    IUBox *parentBox;
    IUBox *childBox1;
    IUBox *childBox2;
}

- (void)setUp {
    [super setUp];
    NSLog(@"test");
    parentBox = [[IUBox alloc] initWithPreset];
    parentBox.htmlID = @"parentBox";
    
    childBox1 = [[IUBox alloc] initWithPreset];
    childBox1.htmlID = @"ChildBox1";
    
    childBox2 = [[IUBox alloc] initWithPreset];
    childBox2.htmlID = @"ChildBox2";
    
    [parentBox addIU:childBox1 error:nil];
    [parentBox addIU:childBox2 error:nil];
    
    childBox1.link = childBox2;
    childBox2.link = childBox1;
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


- (void)test1_IUBoxEncoding1{
    // This is an example of a functional test case.
    IUBox *oneBox = [[IUBox alloc] initWithPreset];
    oneBox.htmlID = @"OneBox";
    
    JDCoder *coder = [[JDCoder alloc] init];
    [coder encodeRootObject:oneBox];
    IUBox *resultBox = [coder decodeRootObject];
    
    XCTAssert([resultBox.htmlID isEqualToString:@"OneBox"], @"Pass");
}


- (void)test2_IUBoxEncoding2{
    // This is an example of a functional test case.
    IUBox *oneBox = [[IUBox alloc] initWithPreset];
    oneBox.htmlID = @"OneBox";
    oneBox.defaultStyleStorage.fontName = @"Roboto";
    
    JDCoder *coder = [[JDCoder alloc] init];
    [coder encodeRootObject:oneBox];
    IUBox *resultBox = [coder decodeRootObject];
    
    XCTAssert([resultBox.htmlID isEqualToString:@"OneBox"], @"Pass");
    XCTAssert([resultBox.defaultStyleStorage.fontName isEqualToString:@"Roboto"], @"Pass");

}



- (void)test4_children{
    JDCoder *coder = [[JDCoder alloc] init];
    [coder encodeRootObject:parentBox];
    
    IUBox *resultBox = [coder decodeRootObject];
    IUBox *resultChildBox1 = [[resultBox children] objectAtIndex:0];
    
    XCTAssert([resultChildBox1.htmlID isEqualToString:@"ChildBox1"], @"Pass");
    XCTAssert([resultChildBox1.parent.htmlID isEqualToString:@"parentBox"], @"Pass");
}

- (void)test5_selector{
    JDCoder *coder = [[JDCoder alloc] init];
    [coder encodeRootObject:parentBox];
    
    IUBox *resultBox = [coder decodeRootObject];
    IUBox *resultChildBox1 = [[resultBox children] objectAtIndex:0];
    IUBox *resultChildBox2 = [[resultBox children] objectAtIndex:1];
    
    XCTAssert(resultChildBox1, @"Pass");
    XCTAssert(resultChildBox1.link == resultChildBox2, @"Pass");
    XCTAssert(resultChildBox2.link == resultChildBox1, @"Pass");
}



@end
