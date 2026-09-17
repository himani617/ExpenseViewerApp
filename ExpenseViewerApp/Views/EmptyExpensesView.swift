//
//  EmptyExpensesView.swift
//  ExpenseViewerApp
//
//  Created by HIMANI VARU on 17/09/26.
//

import SwiftUI

struct EmptyExpensesView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "creditcard")
                .font(.system(size: 44))
                .foregroundStyle(.secondary)
                .frame(width: 88, height: 88)
                .background(
                    Circle()
                        .fill(.secondary.opacity(0.12))
                )

            VStack(spacing: 8) {
                Text("No Expenses")
                    .font(.title2)
                    .fontWeight(.semibold)

                Text(
                    "There are currently no expenses to display."
                )
                .font(.body)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
            }
        }
        .padding(32)
        .frame(maxWidth: 360)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("No expenses")
        .accessibilityHint(
            "There are currently no expenses to display."
        )
    }
}

#Preview {
    EmptyExpensesView()
}
