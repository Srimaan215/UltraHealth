//
//  JournalView.swift
//  HealthDashBoardApp
//
//  Created by Srimaan Sridharan on 4/22/25.
//

import SwiftUI

struct JournalView: View {
    var body: some View {
        NavigationView {
            VStack {
                 Image(systemName: "book.closed")
                     .resizable()
                     .scaledToFit()
                     .frame(width: 50, height: 50)
                     .foregroundColor(Color.brown) // Explicit Color.brown
                Text("Journal View")
                    .font(.largeTitle)
                    .padding()
            }
             .navigationTitle("Journal")
        }
    }
}

#Preview {
    JournalView()
}
