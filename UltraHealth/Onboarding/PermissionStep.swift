//
//  PermissionStep.swift
//  HealthDashBoardApp
//
//  Created by Srimaan Sridharan on 4/18/25.
//
import SwiftUI

struct PermissionsStep: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @AppStorage("hasCompletedOnboarding") var hasCompletedOnboarding = false

    var body: some View {
        VStack(spacing: 30) {
            Text("Allow Health Access")
                .font(.title2)
                .multilineTextAlignment(.center)

            Text("To track your recovery, we’ll need permission to access your heart, sleep, and activity data.")

            Button("Allow Access") {
                HealthDataFetcher().requestAuthorization()
                hasCompletedOnboarding = true
            }
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(12)
        }
        .padding()
    }
}

