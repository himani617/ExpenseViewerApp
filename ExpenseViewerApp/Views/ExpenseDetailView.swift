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

            Text(expense.title)
                .font(.title2)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)

            Text(expense.formattedAmount)
                .font(.system(size: 38, weight: .bold, design: .rounded))
                .foregroundStyle(.primary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
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
    }

    // MARK: - Metadata

    private var metadataCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Transaction Information")
                .font(.headline)

            HStack {
                Label("Expense ID", systemImage: "number")

                Spacer()

                Text(expense.id)
                    .foregroundStyle(.secondary)
                    .font(.subheadline.monospaced())
            }

            Divider()

            HStack {
                Label("Currency", systemImage: "banknote")

                Spacer()

                Text("USD")
                    .foregroundStyle(.secondary)
            }
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

            Text(title)
                .font(.body)

            Spacer()

            Text(value)
                .font(.body)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.trailing)
        }
        .padding(.vertical, 16)
    }
}
