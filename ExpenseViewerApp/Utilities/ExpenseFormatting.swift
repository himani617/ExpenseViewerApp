//
//  ExpenseFormatting.swift
//  ExpenseViewerApp
//
//  Created by HIMANI VARU on 17/09/26.
//

import Foundation

extension Expense {

    var formattedAmount: String {
        amount.formatted(
            .currency(code: "USD")
        )
    }

    var formattedDate: String {
        date.formatted(
            .dateTime
                .day()
                .month(.abbreviated)
                .year()
                .hour()
                .minute()
        )
    }

    var formattedDetailDate: String {
        date.formatted(
            date: .complete,
            time: .shortened
        )
    }
}
