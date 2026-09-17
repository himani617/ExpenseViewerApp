
//
//  ExpenseRecord.m
//  ExpenseViewerApp
//
//  Created by HIMANI VARU on 17/09/26.
//

#import "ExpenseRecord.h"

@implementation ExpenseRecord

- (instancetype)initWithId:(NSString *)expenseId
                      title:(NSString *)title
                     amount:(double)amount
                       date:(NSDate *)date {
    self = [super init];

    if (self) {
        _expenseId = [expenseId copy];
        _title = [title copy];
        _amount = amount;
        _date = date;
    }

    return self;
}

@end
