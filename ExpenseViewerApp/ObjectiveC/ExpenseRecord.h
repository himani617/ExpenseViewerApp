
//
//  ExpenseRecord.h
//  ExpenseViewerApp
//
//  Created by HIMANI VARU on 17/09/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ExpenseRecord : NSObject

@property (nonatomic, copy) NSString *expenseId;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) double amount;
@property (nonatomic, strong) NSDate *date;

- (instancetype)initWithId:(NSString *)expenseId
                      title:(NSString *)title
                     amount:(double)amount
                       date:(NSDate *)date;

@end

NS_ASSUME_NONNULL_END
