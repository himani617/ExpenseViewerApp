//
//  ExpenseRowView.swift
//  ExpenseViewerApp
//
//  Created by HIMANI VARU on 17/09/26.
//

import SwiftUI

struct ExpenseRowView: View {

    let expense: Expense

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {

            HStack(alignment: .firstTextBaseline) {
                Text(expense.title)
                    .font(.headline)

                Spacer()

                Text(expense.formattedAmount)
                    .font(.headline)
            }

            Text(expense.formattedDate)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding(.vertical, 6)
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(expense.title)
        .accessibilityValue(
            "\(expense.formattedAmount), \(expense.formattedDate)"
        )
        .accessibilityHint(
            "Double tap to view expense details"
        )
    }
}
