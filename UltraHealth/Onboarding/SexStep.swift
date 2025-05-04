//
//  SexStep.swift
//  HealthDashBoardApp
//
//  Created by Srimaan Sridharan on 4/18/25.
//
import SwiftUI

struct SexStep: View {
    @ObservedObject var viewModel: OnboardingViewModel
    @Binding var currentPage: Int

    let options = ["Male", "Female", "Other"]

    var body: some View {
        VStack(spacing: 30) {
            Text("Select your sex")
                .font(.title2)

            Picker("Sex", selection: $viewModel.sex) {
                ForEach(options, id: \.self) { sex in
                    Text(sex).tag(sex)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)

            Button("Next") {
                currentPage += 1
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

