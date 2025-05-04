//
//  UltraHealthApp.swift
//  UltraHealth
//
//  Created by Srimaan Sridharan on 4/23/25.
//

import SwiftUI

@main
struct UltraHealthApp: App {
    @AppStorage("hasCompletedOnboarding") var hasCompletedOnboarding = false

    @State private var selectedTab: AppTab = .home
    @State private var showingAddModal = false

    var body: some Scene {
        WindowGroup {
            if hasCompletedOnboarding {
                FanningNavigationView(
                    selectedTab: $selectedTab,
                    showingAddModal: $showingAddModal
                )
            } else {
                OnboardingView()
            }
        }
    }
}
