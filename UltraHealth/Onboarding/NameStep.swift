//
//  NameStep.swift
//  HealthDashBoardApp
//
//  Created by Srimaan Sridharan on 4/18/25.
//
import SwiftUI

struct NameStep: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @Binding var currentPage: Int

    var body: some View {
        VStack(spacing: 40) {
            Text("Welcome!")
                .font(.largeTitle)
                .bold()
            Text("What's your name?")
                .font(.title2)

            TextField("Your name", text: $viewModel.name)
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

