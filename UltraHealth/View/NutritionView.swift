//
//  NutritionView.swift
//  HealthDashBoardApp
//
//  Created by Srimaan Sridharan on 4/22/25.
//

import SwiftUI

struct NutritionView: View {
    var body: some View {
        NavigationView {
            VStack {
                 Image(systemName: "carrot")
                     .resizable()
                     .scaledToFit()
                     .frame(width: 50, height: 50)
                     .foregroundColor(.orange)
                Text("Nutrition Tracking View")
                    .font(.largeTitle)
                    .padding()
            }
             .navigationTitle("Nutrition")
        }
    }
}

#Preview {
    NutritionView()
}
