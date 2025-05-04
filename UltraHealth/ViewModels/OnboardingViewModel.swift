//
//  OnboardingViewModel.swift
//  HealthDashBoardApp
//
//  Created by Srimaan Sridharan on 4/18/25.
//
import Foundation

class OnboardingViewModel: ObservableObject {
    @Published var name = ""
    @Published var age = ""
    @Published var sex = "Male"
    @Published var weight = ""
    @Published var height = ""
}

