//
//  ExpenseService.swift
//  ExpenseViewerApp
//
//  Created by HIMANI VARU on 17/09/26.
//

import Foundation

protocol ExpenseServicing {
    func fetchExpenses() async throws -> [Expense]
}

enum ExpenseServiceError: LocalizedError {
    case invalidResponse(statusCode: Int)

    var errorDescription: String? {
        switch self {
        case let .invalidResponse(statusCode):
            return "The server returned an invalid response (status \(statusCode))."
        }
    }
}

final class ExpenseService: ExpenseServicing {
    private let session: URLSession
    private let endpoint: URL

    init(
        session: URLSession = .shared,
        endpoint: URL = URL(string: "https://www.jsonkeeper.com/b/DYZJF")!
    ) {
        self.session = session
        self.endpoint = endpoint
    }

    func fetchExpenses() async throws -> [Expense] {
        let (data, response) = try await session.data(from: endpoint)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw ExpenseServiceError.invalidResponse(statusCode: 0)
        }

        guard 200..<300 ~= httpResponse.statusCode else {
            throw ExpenseServiceError.invalidResponse(statusCode: httpResponse.statusCode)
        }

        let records = try ExpenseTransformer.expenses(fromJSONData: data)
        return records.map(Expense.init(record:))
    }
}
