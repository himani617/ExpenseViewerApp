//
//  ContentView.swift
//  ExpenseViewerApp
//
//  Created by HIMANI VARU on 17/09/26.
//

import SwiftUI

struct ExpenseListView: View {

    @State private var viewModel = ExpenseListViewModel()
    @StateObject private var reachability = NetworkReachability()

    var body: some View {
        NavigationStack {

            Group {
                if !reachability.isConnected {
                    offlineView
                } else  if viewModel.isLoading && viewModel.expenses.isEmpty {

                    loadingView

                } else if let errorMessage = viewModel.errorMessage,
                          viewModel.expenses.isEmpty {

                    errorView(message: errorMessage)

                } else if viewModel.expenses.isEmpty {

                    EmptyExpensesView()

                } else {

                    expenseList
                }
            }
            .navigationTitle("Expenses")
            .task {
                if reachability.isConnected {
                    await viewModel.loadExpenses()
                }
            }
            .refreshable {
                if reachability.isConnected {
                    await viewModel.loadExpenses()
                }
            }
        }
    }
    
    // MARK: - Offline
    
    private var offlineView: some View {
        ContentUnavailableView {
            Label(
                "No Internet Connection",
                systemImage: "wifi.slash"
            )
        } description: {
            Text(
                "Please check your internet connection " + "and try again."
            )
        } actions: {
            Button("Try Again") {
                Task {
                    await viewModel.loadExpenses()
                }
            }
            .buttonStyle(.borderedProminent)
            .disabled(!reachability.isConnected)
            .accessibilityHint( "Attempts to load expenses when an internet connection is available" )
        }
        .accessibilityElement(children: .contain)
    }

    // MARK: - Expense List

    private var expenseList: some View {
        List {

            // Expenses
            Section("All Expenses") {
                ForEach(viewModel.expenses) { expense in
                    NavigationLink {
                        ExpenseDetailView(expense: expense)
                    } label: {
                        ExpenseRowView(expense: expense)
                    }
                }
            }
        }
        .listStyle(.plain)
    }

    // MARK: - Loading

    private var loadingView: some View {
        VStack(spacing: 12) {
            ProgressView()

            Text("Loading expenses...")
                .foregroundStyle(.secondary)
        }
    }


    // MARK: - Error

    private func errorView(message: String) -> some View {
        ContentUnavailableView {
            Label(
                "Unable to Load Expenses",
                systemImage: "exclamationmark.triangle"
            )
        } description: {
            Text(message)
        } actions: {
            Button("Try Again") {
                Task {
                    await viewModel.loadExpenses()
                }
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    ExpenseListView()
}




