//
//  BiologyView.swift
//  HealthDashBoardApp
//
//  Created by Srimaan Sridharan on 4/22/25.
//

import SwiftUI

struct BiologyView: View {
    var body: some View {
        NavigationView {
            VStack {
                 Image(systemName: "staroflife")
                     .resizable()
                     .scaledToFit()
                     .frame(width: 50, height: 50)
                     .foregroundColor(.red)
                Text("Biology Summary View")
                    .font(.largeTitle)
                    .padding()
            }
             .navigationTitle("Biology")
        }
    }
}

#Preview {
    BiologyView()
}
