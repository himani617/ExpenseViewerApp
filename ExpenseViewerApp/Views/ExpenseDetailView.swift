//
//  ExpenseDetailView.swift
//  ExpenseViewerApp
//
//  Created by HIMANI VARU on 17/09/26.
//

import SwiftUI

struct ExpenseDetailView: View {

    let expense: Expense

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                amountHeader
                detailsCard
                metadataCard
            }
            .padding()
        }
        .navigationTitle("Expense Details")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.systemGroupedBackground))
    }

    // MARK: - Amount Header

    private var amountHeader: some View {
        VStack(spacing: 12) {
            Image(systemName: "creditcard.fill")
                .font(.system(size: 32))
                .foregroundStyle(.blue)
                .frame(width: 72, height: 72)
                .background(
                    Circle()
                        .fill(.blue.opacity(0.12))
                )
                .accessibilityHidden(true)

            Text(expense.title)
                .font(.title2)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)

            Text(expense.formattedAmount)
                .font(
                    .system(
                        size: 38,
                        weight: .bold,
                        design: .rounded
                    )
                )
                .foregroundStyle(.primary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(expense.title)
        .accessibilityValue(expense.formattedAmount)
    }

    // MARK: - Details

    private var detailsCard: some View {
        VStack(spacing: 0) {
            DetailRow(
                icon: "calendar",
                title: "Date",
                value: expense.formattedDate
            )

            Divider()
                .padding(.leading, 52)
                .accessibilityHidden(true)

            DetailRow(
                icon: "dollarsign.circle",
                title: "Amount",
                value: expense.formattedAmount
            )
        }
        .padding(.horizontal)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.regularMaterial)
        )
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(
                    Color.primary.opacity(0.08),
                    lineWidth: 1
                )
        }
        .accessibilityElement(children: .contain)
        .accessibilityLabel("Expense details")
    }

    // MARK: - Metadata

    private var metadataCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Transaction Information")
                .font(.headline)
                .accessibilityAddTraits(.isHeader)

            HStack {
                Label(
                    "Expense ID",
                    systemImage: "number"
                )
                .accessibilityHidden(true)

                Spacer()

                Text(expense.id)
                    .foregroundStyle(.secondary)
                    .font(.subheadline.monospaced())
            }
            .accessibilityElement(children: .combine)
            .accessibilityLabel("Expense ID")
            .accessibilityValue(expense.id)

            Divider()
                .accessibilityHidden(true)

            HStack {
                Label(
                    "Currency",
                    systemImage: "banknote"
                )
                .accessibilityHidden(true)

                Spacer()

                Text("USD")
                    .foregroundStyle(.secondary)
            }
            .accessibilityElement(children: .combine)
            .accessibilityLabel("Currency")
            .accessibilityValue("US dollars")
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.regularMaterial)
        )
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(
                    Color.primary.opacity(0.08),
                    lineWidth: 1
                )
        }
        .accessibilityElement(children: .contain)
        .accessibilityLabel("Transaction information")
    }
}

// MARK: - Detail Row

private struct DetailRow: View {

    let icon: String
    let title: String
    let value: String

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: icon)
                .font(.headline)
                .foregroundStyle(.blue)
                .frame(width: 28)
                .accessibilityHidden(true)

            Text(title)
                .font(.body)

            Spacer()

            Text(value)
                .font(.body)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.trailing)
        }
        .padding(.vertical, 16)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(title)
        .accessibilityValue(value)
    }
}
