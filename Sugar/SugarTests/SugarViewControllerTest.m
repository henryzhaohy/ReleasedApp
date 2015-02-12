//
//  SugarViewControllerTest.m
//  Sugar
//
//  Created by HANYU ZHAO on 2015-01-27.
//  Copyright (c) 2015 HANYU ZHAO. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SugarViewController.h"

@interface SugarViewControllerTest : XCTestCase

@property (strong, nonatomic) SugarViewController* sugarViewController;

@end

@implementation SugarViewControllerTest

- (void)setUp {
    [super setUp];

    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.sugarViewController = [storyboard instantiateViewControllerWithIdentifier:
                      @"SugarViewController"];
    [self.sugarViewController view];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    
    self.sugarViewController = nil;
}

-(void)testViewControllerViewExists {
    XCTAssertNotNil([self.sugarViewController view], @"ViewController should contain a view");
}

-(void)testTableViewConnection
{
    XCTAssertNotNil([self.sugarViewController tableView], @"tableView should be connected");
}

- (void)testParentViewHasTableViewSubview
{
    NSArray *subviews = self.sugarViewController.view.subviews;
    XCTAssertTrue([subviews containsObject:self.sugarViewController.tableView], @"View does have a table subview");
}

#pragma mark - UITableView tests
- (void)testThatViewConformsToUITableViewDataSource
{
    XCTAssertTrue([self.sugarViewController conformsToProtocol:@protocol(UITableViewDataSource) ], @"View does not conform to UITableView datasource protocol");
}

- (void)testThatTableViewHasDataSource
{
    XCTAssertNotNil(self.sugarViewController.tableView.dataSource, @"Table datasource cannot be nil");
}

- (void)testThatViewConformsToUITableViewDelegate
{
    XCTAssertTrue([self.sugarViewController conformsToProtocol:@protocol(UITableViewDelegate) ], @"View does not conform to UITableView delegate protocol");
}

- (void)testTableViewIsConnectedToDelegate
{
    XCTAssertNotNil(self.sugarViewController.tableView.delegate, @"Table delegate cannot be nil");
}

- (void)testTableViewNumberOfRowsInSection
{
    NSInteger expectedRows = 15;
    XCTAssertNotEqual([self.sugarViewController tableView:self.sugarViewController.tableView numberOfRowsInSection:0], expectedRows, @"Table has %ld rows but it should have %ld", (long)[self.sugarViewController tableView:self.sugarViewController.tableView numberOfRowsInSection:0], (long)expectedRows);
}

- (void)testTableViewHeightForRowAtIndexPath
{
    CGFloat expectedHeight = 44.0;
    CGFloat actualHeight = self.sugarViewController.tableView.rowHeight;
    XCTAssertNotEqual(expectedHeight, actualHeight, @"Cell should have %f height, but they have %f", expectedHeight, actualHeight);
}


- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
