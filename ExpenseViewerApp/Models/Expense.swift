//
//  Expense.swift
//  ExpenseViewerApp
//
//  Created by HIMANI VARU on 17/09/26.
//

import Foundation

struct Expense: Identifiable, Equatable {
    let id: String
    let title: String
    let amount: Double
    let date: Date

    init(record: ExpenseRecord) {
        self.id = record.expenseId
        self.title = record.title
        self.amount = record.amount
        self.date = record.date
    }
}
