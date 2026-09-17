//
//  LauncherView.swift
//  ExpenseViewerApp
//
//  Created by HIMANI VARU on 17/09/26.
//

import SwiftUI

struct LauncherView: View {

    @State private var isActive = false

    var body: some View {
        Group {
            if isActive {
                ExpenseListView()
            } else {
                launcherContent
            }
        }
        .task {
           
            try? await Task.sleep(for: .milliseconds(1000))

            withAnimation(.easeInOut(duration: 0.25)) {
                isActive = true
            }
        }
    }

    // MARK: - Launcher Content

    private var launcherContent: some View {
        VStack(spacing: 20) {
            Image(systemName: "creditcard.fill")
                .font(.system(size: 56, weight: .medium))
                .foregroundStyle(.blue)
                .frame(width: 110, height: 110)
                .background(
                    Circle()
                        .fill(.blue.opacity(0.12))
                )
                .accessibilityHidden(true)

            VStack(spacing: 8) {
                Text("Expense Viewer")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                Text("View and manage your expenses")
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Expense Viewer")
        .accessibilityValue("View and manage your expenses")
    }
}

#Preview {
    LauncherView()
}
