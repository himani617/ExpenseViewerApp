//
//  ExpenseSummaryView.swift
//  ExpenseViewerApp
//
//  Created by HIMANI VARU on 17/09/26.
//

import SwiftUI

struct ExpenseSummaryView: View {

    let summary: ExpenseSummary

    private let currencyCode = "USD"

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {

            // Header
            HStack {
                Image(systemName: "chart.bar.fill")
                    .foregroundStyle(.blue)

                Text("Expense Summary")
                    .font(.headline)

                Spacer()
            }

            // Total and Average
            HStack(spacing: 12) {
                SummaryMetricCard(
                    title: "Total Spent",
                    value: summary.total.formatted(
                        .currency(code: currencyCode)
                    ),
                    systemImage: "dollarsign.circle.fill"
                )

                SummaryMetricCard(
                    title: "Average",
                    value: summary.average.formatted(
                        .currency(code: currencyCode)
                    ),
                    systemImage: "chart.line.uptrend.xyaxis"
                )
            }

            // Highest Expense
            if let highestExpense = summary.highestExpense {
                HighestExpenseView(
                    expense: highestExpense,
                    currencyCode: currencyCode
                )
            }
        }
        .padding(16)
        .background {
            RoundedRectangle(cornerRadius: 20)
                .fill(.regularMaterial)
        }
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .strokeBorder(.quaternary, lineWidth: 1)
        }
        .padding(.horizontal)
        .padding(.top, 8)
    }
}

// MARK: - Metric Card

private struct SummaryMetricCard: View {

    let title: String
    let value: String
    let systemImage: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {

            Image(systemName: systemImage)
                .font(.title3)
                .foregroundStyle(.blue)

            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)

            Text(value)
                .font(.title3)
                .fontWeight(.semibold)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(12)
        .background {
            RoundedRectangle(cornerRadius: 14)
                .fill(.quaternary.opacity(0.35))
        }
    }
}

// MARK: - Highest Expense

private struct HighestExpenseView: View {

    let expense: Expense
    let currencyCode: String

    var body: some View {
        HStack(spacing: 12) {

            Image(systemName: "arrow.up.circle.fill")
                .font(.title2)
                .foregroundStyle(.orange)

            VStack(alignment: .leading, spacing: 4) {
                Text("Highest Expense")
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Text(expense.title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .lineLimit(1)
            }

            Spacer()

            Text(
                expense.amount.formatted(
                    .currency(code: currencyCode)
                )
            )
            .font(.headline)
        }
        .padding(12)
        .background {
            RoundedRectangle(cornerRadius: 14)
                .fill(.quaternary.opacity(0.35))
        }
    }
}

