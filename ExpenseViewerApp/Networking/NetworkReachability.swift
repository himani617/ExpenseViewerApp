//
//  NetworkReachability.swift
//  ExpenseViewerApp
//
//  Created by HIMANI VARU on 17/09/26.
//

import Foundation
import Network

@MainActor
@Observable
final class NetworkReachability {

   private(set) var isConnected = true

    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(
        label: "com.expenseviewer.network-reachability"
    )

    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            Task { @MainActor in
                self?.isConnected = path.status == .satisfied
            }
        }

        monitor.start(queue: queue)
    }

    deinit {
        monitor.cancel()
    }
}
