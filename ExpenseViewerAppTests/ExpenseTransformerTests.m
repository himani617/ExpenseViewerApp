//
//  ExpenseTransformerTests.m
//  ExpenseViewerAppTests
//
//  Created by HIMANI VARU on 17/09/26.
//

#import <XCTest/XCTest.h>
#import "ExpenseTransformer.h"

@interface ExpenseTransformerTests : XCTestCase
@end

@implementation ExpenseTransformerTests

- (void)testTransformsValidJSON {
    NSString *json =
        @"["
         "{\"id\":\"1\",\"title\":\"Flight to SF\","
         "\"amount\":230.50,"
         "\"date\":\"2021-07-03T01:50:00+01:00\"},"
         "{\"id\":\"2\",\"title\":\"Hotel\","
         "\"amount\":550.00,"
         "\"date\":\"2021-08-03T01:50:00+01:00\"}"
         "]";

    NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding];

    NSError *error = nil;

    NSArray<ExpenseRecord *> *expenses =
        [ExpenseTransformer expensesFromJSONData:data
                                           error:&error];

    XCTAssertNil(error);
    XCTAssertEqual(expenses.count, 2);

    XCTAssertEqualObjects(expenses[0].expenseId, @"2");
    XCTAssertEqualObjects(expenses[0].title, @"Hotel");
    XCTAssertEqualWithAccuracy(expenses[0].amount, 550.00, 0.001);

    XCTAssertEqualObjects(expenses[1].expenseId, @"1");
    XCTAssertEqualObjects(expenses[1].title, @"Flight to SF");
}

- (void)testInvalidJSONReturnsError {
    NSString *json = @"not valid json";

    NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding];

    NSError *error = nil;

    NSArray *expenses =
        [ExpenseTransformer expensesFromJSONData:data
                                           error:&error];

    XCTAssertNotNil(error);
    XCTAssertEqual(expenses.count, 0);
}

- (void)testNonArrayJSONReturnsError {
    NSString *json = @"{\"id\":\"1\"}";

    NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding];

    NSError *error = nil;

    NSArray *expenses =
        [ExpenseTransformer expensesFromJSONData:data
                                           error:&error];

    XCTAssertNotNil(error);
    XCTAssertEqual(expenses.count, 0);
}

@end
