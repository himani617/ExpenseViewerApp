
//
//  ExpenseTransformer.h
//  ExpenseViewerApp
//
//  Created by HIMANI VARU on 17/09/26.
//

#import <Foundation/Foundation.h>
#import "ExpenseRecord.h"

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString * const ExpenseTransformerErrorDomain;

typedef NS_ENUM(NSInteger, ExpenseTransformerErrorCode) {
    ExpenseTransformerErrorCodeInvalidJSON = 1000,
    ExpenseTransformerErrorCodeUnexpectedStructure = 1001,
};

@interface ExpenseTransformer : NSObject

+ (nullable NSArray<ExpenseRecord *> *)expensesFromJSONData:(NSData *)data
                                                      error:(NSError **)error
    NS_SWIFT_NAME(expenses(fromJSONData:));

@end

NS_ASSUME_NONNULL_END
