//
//  ExpenseListViewModel.swift
//  ExpenseViewerApp
//
//  Created by HIMANI VARU on 17/09/26.
//

import Foundation
import Observation

@MainActor
@Observable
final class ExpenseListViewModel {

    private(set) var expenses: [Expense] = []
    private(set) var isLoading = false
    private(set) var errorMessage: String?

    private let service: ExpenseServicing

    init(service: ExpenseServicing = ExpenseService()) {
        self.service = service
    }


    // MARK: - Networking

    func loadExpenses() async {
        guard !isLoading else { return }

        isLoading = true
        errorMessage = nil

        defer {
            isLoading = false
        }

        do {
            expenses = try await service.fetchExpenses()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
