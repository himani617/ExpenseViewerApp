//
//  ExpenseTransformer.m
//  ExpenseViewerApp
//
//  Created by HIMANI VARU on 16/09/26.
//



#import "ExpenseTransformer.h"

NSString * const ExpenseTransformerErrorDomain = @"ExpenseTransformer";

@implementation ExpenseTransformer

+ (nullable NSArray<ExpenseRecord *> *)expensesFromJSONData:(NSData *)data
                                                      error:(NSError **)error {
    NSParameterAssert(data);

    NSError *jsonError = nil;

    id json = [NSJSONSerialization JSONObjectWithData:data
                                              options:0
                                                error:&jsonError];

    if (json == nil) {
        if (error != NULL) {
            *error = [self errorWithCode:ExpenseTransformerErrorCodeInvalidJSON
                             description:@"The expense feed could not be read as JSON."
                              underlying:jsonError];
        }
        return nil;
    }

    if (![json isKindOfClass:[NSArray class]]) {
        if (error != NULL) {
            *error = [self errorWithCode:ExpenseTransformerErrorCodeUnexpectedStructure
                             description:@"Expected JSON to contain an array of expenses."
                              underlying:nil];
        }
        return nil;
    }

    NSArray *items = (NSArray *)json;
    NSMutableArray<ExpenseRecord *> *expenses =
        [NSMutableArray arrayWithCapacity:items.count];

    NSISO8601DateFormatter *dateFormatter = [[NSISO8601DateFormatter alloc] init];
    dateFormatter.formatOptions = NSISO8601DateFormatWithInternetDateTime;

    NSISO8601DateFormatter *fractionalDateFormatter = [[NSISO8601DateFormatter alloc] init];
    fractionalDateFormatter.formatOptions =
        NSISO8601DateFormatWithInternetDateTime | NSISO8601DateFormatWithFractionalSeconds;

    for (id item in items) {
        if (![item isKindOfClass:[NSDictionary class]]) {
            continue;
        }

        NSDictionary *dictionary = (NSDictionary *)item;

        NSString *expenseId = dictionary[@"id"];
        NSString *title = dictionary[@"title"];
        NSNumber *amount = dictionary[@"amount"];
        NSString *dateString = dictionary[@"date"];

        if (![expenseId isKindOfClass:[NSString class]] ||
            ![title isKindOfClass:[NSString class]] ||
            ![amount isKindOfClass:[NSNumber class]] ||
            ![dateString isKindOfClass:[NSString class]]) {
            continue;
        }

        NSDate *date = [dateFormatter dateFromString:dateString];

        if (date == nil) {
            date = [fractionalDateFormatter dateFromString:dateString];
        }

        if (date == nil) {
            continue;
        }

        ExpenseRecord *record =
            [[ExpenseRecord alloc] initWithId:expenseId
                                        title:title
                                       amount:amount.doubleValue
                                         date:date];

        [expenses addObject:record];
    }

    [expenses sortUsingComparator:^NSComparisonResult(ExpenseRecord *a,
                                                      ExpenseRecord *b) {
        return [b.date compare:a.date];
    }];

    return [expenses copy];
}

#pragma mark - Errors

+ (NSError *)errorWithCode:(ExpenseTransformerErrorCode)code
               description:(NSString *)description
                underlying:(nullable NSError *)underlying {
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[NSLocalizedDescriptionKey] = description;

    if (underlying != nil) {
        userInfo[NSUnderlyingErrorKey] = underlying;
    }

    return [NSError errorWithDomain:ExpenseTransformerErrorDomain
                              code:code
                          userInfo:userInfo];
}

@end
