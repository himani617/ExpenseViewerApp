//
//  ExpenseSummary.swift
//  ExpenseViewerApp
//
//  Created by HIMANI VARU on 17/09/26.
//

import Foundation

struct ExpenseSummary: Equatable {
    let total: Double
    let average: Double
    let highestExpense: Expense?

    static func from(_ expenses: [Expense]) -> ExpenseSummary {
        guard !expenses.isEmpty else {
            return ExpenseSummary(
                total: 0,
                average: 0,
                highestExpense: nil
            )
        }

        let total = expenses.reduce(0) { partialResult, expense in
            partialResult + expense.amount
        }

        let average = total / Double(expenses.count)

        let highestExpense = expenses.max {
            $0.amount < $1.amount
        }

        return ExpenseSummary(
            total: total,
            average: average,
            highestExpense: highestExpense
        )
    }
}
