//
//  BodyStep.swift
//  HealthDashBoardApp
//
//  Created by Srimaan Sridharan on 4/18/25.
//
import SwiftUI

struct BodyStep: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @Binding var currentPage: Int

    var body: some View {
        VStack(spacing: 30) {
            Text("Your body measurements")
                .font(.title2)

            TextField("Weight (lbs)", text: $viewModel.weight)
                .keyboardType(.decimalPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

            TextField("Height (inches)", text: $viewModel.height)
                .keyboardType(.decimalPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)

            Button("Next") {
                currentPage += 1
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

