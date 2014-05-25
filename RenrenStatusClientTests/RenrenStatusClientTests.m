//
//  RenrenStatusClientTests.m
//  RenrenStatusClientTests
//
//  Created by Snowmanzzz on 14-1-9.
//  Copyright (c) 2014年 zzz. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TodoListCenter.h"

@interface RenrenStatusClientTests : XCTestCase

@property (nonatomic, strong) TodoListCenter *center;
@end

@implementation RenrenStatusClientTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.center = [TodoListCenter sharedTodoListCenter];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
//    XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

- (void)testAdd {
    [self.center removeAll];
    [self.center addStatus:@"shit"];
//    [self.center.statusArray count]
    XCTAssertEqual(self.center.statusArray.count, 1, @"wo le ge cao");
}

@end
