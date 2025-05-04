//
//  OnboardingView.swift
//  HealthDashBoardApp
//
//  Created by Srimaan Sridharan on 4/18/25.
//
import SwiftUI

struct OnboardingView: View {
    @StateObject var viewModel = OnboardingViewModel()
    @State private var currentPage = 0

    var body: some View {
        TabView(selection: $currentPage) {
            NameStep(viewModel: viewModel, currentPage: $currentPage).tag(0)
            AgeStep(viewModel: viewModel, currentPage: $currentPage).tag(1)
            SexStep(viewModel: viewModel, currentPage: $currentPage).tag(2)
            BodyStep(viewModel: viewModel, currentPage: $currentPage).tag(3)
            PermissionsStep(viewModel: viewModel).tag(4)
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        .animation(.easeInOut, value: currentPage)
    }
}

