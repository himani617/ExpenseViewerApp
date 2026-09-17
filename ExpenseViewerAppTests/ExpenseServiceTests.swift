//
//  ExpenseServiceTests.swift
//  ExpenseViewerApp
//
//  Created by HIMANI VARU on 17/09/26.
//

import XCTest
@testable import ExpenseViewerApp

final class ExpenseServiceTests: XCTestCase {

    func testFetchExpensesTransformsResponse() async throws {
        let json = """
        [
          {
            "id": "1",
            "title": "Flight to SF",
            "amount": 230.50,
            "date": "2021-07-03T01:50:00+01:00"
          },
          {
            "id": "2",
            "title": "Hotel",
            "amount": 550.00,
            "date": "2021-08-03T01:50:00+01:00"
          }
        ]
        """

        let data = Data(json.utf8)

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]

        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!

            return (response, data)
        }

        let session = URLSession(configuration: configuration)
        let service = ExpenseService(session: session)

        let expenses = try await service.fetchExpenses()

        XCTAssertEqual(expenses.count, 2)
        XCTAssertEqual(expenses[0].title, "Hotel")
        XCTAssertEqual(expenses[1].title, "Flight to SF")
    }
}

final class MockURLProtocol: URLProtocol {

    static var requestHandler:
        ((URLRequest) throws -> (HTTPURLResponse, Data))?

    override class func canInit(with request: URLRequest) -> Bool {
        true
    }

    override class func canonicalRequest(
        for request: URLRequest
    ) -> URLRequest {
        request
    }

    override func startLoading() {
        guard let handler = Self.requestHandler else {
            return
        }

        do {
            let (response, data) = try handler(request)

            client?.urlProtocol(
                self,
                didReceive: response,
                cacheStoragePolicy: .notAllowed
            )

            client?.urlProtocol(self, didLoad: data)
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
    }

    override func stopLoading() {}
}
