//
//  AgeStep.swift
//  HealthDashBoardApp
//
//  Created by Srimaan Sridharan on 4/18/25.
//
import SwiftUI

struct AgeStep: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @Binding var currentPage: Int

    var body: some View {
        VStack(spacing: 40) {
            Text("How old are you?")
                .font(.title2)

            TextField("Age", text: $viewModel.age)
                .keyboardType(.numberPad)
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

