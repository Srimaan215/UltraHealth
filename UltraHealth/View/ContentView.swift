//
//  ContentView.swift
//  HealthDashBoardApp
//
//  Created by Srimaan Sridharan on 4/14/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            DashboardView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }

            FitnessView()
                .tabItem {
                    Label("Fitness", systemImage: "figure.walk")
                }

            NutritionView()
                .tabItem {
                    Label("Nutrition", systemImage: "carrot")
                }

            JournalView()
                 .tabItem {
                     Label("Journal", systemImage: "book.closed")
                 }

            BiologyView()
                .tabItem {
                    Label("Biology", systemImage: "staroflife")
                }
        }
    }
}

#Preview {
    ContentView()
}
