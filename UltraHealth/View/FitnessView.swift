//
//  FitnessView.swift
//  HealthDashBoardApp
//
//  Created by Srimaan Sridharan on 4/22/25.
//

import SwiftUI

struct FitnessView: View {
    var body: some View {
        NavigationView {
            VStack {
                 Image(systemName: "figure.walk")
                     .resizable()
                     .scaledToFit()
                     .frame(width: 50, height: 50)
                     .foregroundColor(.blue)
                Text("Fitness Tracker View")
                    .font(.largeTitle)
                    .padding()
            }
            .navigationTitle("Fitness")
        }
    }
}

#Preview {
    FitnessView()
}
