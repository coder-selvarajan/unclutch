//
//  unclutchApp.swift
//  unclutch
//
//  Created by Selvarajan on 23/12/24.
//

import SwiftUI
import FamilyControls

@main
struct unclutchApp: App {
    let center = AuthorizationCenter.shared
    var body: some Scene {
        WindowGroup {
            HomeView()
                .onAppear {
                    Task {
                        do {
                            try await center.requestAuthorization(for: .individual)
                        } catch {
                            print("Failed to enroll ActivityAnalyser with error: \(error)")
                        }
                    }
                }
        }
    }
}
