//
//  SettingView.swift
//  UltraHealth
//
//  Created by Srimaan Sridharan on 4/23/25.
//
import SwiftUI

struct SettingView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack {
                 Image(systemName: "gearshape")
                     .resizable()
                     .scaledToFit()
                     .frame(width: 50, height: 50)
                     .foregroundColor(.gray)
                 Text("Settings")
                     .font(.largeTitle)
                     .padding()
                 Spacer()
            }
             .navigationTitle("Settings")
             .navigationBarTitleDisplayMode(.inline)
             .toolbar {
                 ToolbarItem(placement: .navigationBarTrailing) {
                     Button("Done") {
                         presentationMode.wrappedValue.dismiss() 
                     }
                 }
             }
        }
    }
}
