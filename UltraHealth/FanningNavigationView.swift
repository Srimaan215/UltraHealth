//
//  FanningNavigationView.swift
//  HealthDashBoardApp
//
//  Created by Srimaan Sridharan on 4/23/25.
//


import SwiftUI

struct FanningNavigationView: View {
    @Binding var selectedTab: AppTab
    @Binding var showingAddModal: Bool
    
    @State private var isFannedOut: Bool = false
    
    // Constants for animation and layout
    private let fanningDuration: Double = 0.3
    private let overlayOpacity: Double = 0.6
    private let buttonSize: CGFloat = 60
    private let fanRadius: CGFloat = 130
    private let fanAngleRange: Angle = .degrees(180)
    private let blurRadius: CGFloat = 5
    
    var body: some View {
        ZStack {
            Group {
                switch selectedTab {
                case .home:
                    DashboardView()
                case .journal:
                    JournalView()
                case .nutrition:
                    NutritionView()
                case .fitness:
                    FitnessView()
                case .biology:
                    BiologyView()
                case .add:
                    // placeholder quick-add view
                    EmptyView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .blur(radius: isFannedOut ? blurRadius : 0)
            .animation(.easeInOut(duration: fanningDuration), value: isFannedOut)
            
            if isFannedOut {
                Color.black
                    .opacity(overlayOpacity)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: fanningDuration)) {
                            isFannedOut = false
                        }
                    }
            }
            
            VStack {
                Spacer()
                ZStack {
                    if isFannedOut {
                        let visibleTabs = getVisibleTabs()
                        ForEach(0..<visibleTabs.count, id: \.self) { index in
                            let tab = visibleTabs[index]
                            fanButtonAt(tab: tab, index: index, total: visibleTabs.count)
                        }
                    }
                    
                    FloatingButton(icon: iconName(for: selectedTab), size: buttonSize)
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: fanningDuration)) {
                                isFannedOut.toggle()
                            }
                        }
                }
                .padding(.bottom, 20)
            }
            .padding()
            .edgesIgnoringSafeArea(.bottom)
        }
    }
    
    private func getVisibleTabs() -> [AppTab] {
        let otherTabs = AppTab.allCases.filter { $0 != selectedTab }
        
        var orderedTabs: [AppTab] = []
        let nonAddTabs = otherTabs.filter { $0 != .add }
        
        let middlePosition = nonAddTabs.count / 2
        
        for (index, tab) in nonAddTabs.enumerated() {
            if index == middlePosition {
                orderedTabs.append(.add)
            }
            orderedTabs.append(tab)
        }
        
        if nonAddTabs.count % 2 == 0 && !orderedTabs.contains(.add) {
            orderedTabs.append(.add)
        }
        
        return orderedTabs
    }
    
    @ViewBuilder
    private func fanButtonAt(tab: AppTab, index: Int, total: Int) -> some View {
        let angleStep = fanAngleRange.radians / Double(total - 1)
        let startAngle = -.pi / 2 - fanAngleRange.radians / 2
        let angle = startAngle + angleStep * Double(index)
        
        let x = fanRadius * cos(angle)
        let y = fanRadius * sin(angle)
        
        FloatingButton(icon: iconName(for: tab), size: buttonSize * 0.8)
            .offset(x: x, y: y)
            .onTapGesture {
                if tab == .add {
                    withAnimation(.easeInOut(duration: fanningDuration)) {
                        isFannedOut = false
                        showingAddModal = true
                    }
                } else {
                    withAnimation(.easeInOut(duration: fanningDuration)) {
                        selectedTab = tab
                        isFannedOut = false
                    }
                }
            }
    }
    
    private func iconName(for tab: AppTab) -> String {
        switch tab {
        case .home:
            return "house.fill"
        case .journal:
            return "book.fill"
        case .nutrition:
            return "leaf.fill"
        case .fitness:
            return "figure.walk"
        case .biology:
            return "waveform.path.ecg"
        case .add:
            return "plus"
        }
    }
}

struct FloatingButton: View {
    let icon: String
    let size: CGFloat
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(.blue)
                .frame(width: size, height: size)
                .shadow(radius: 3)
            
            Image(systemName: icon)
                .font(.system(size: size * 0.4))
                .foregroundColor(.white)
        }
    }
}

struct FanningNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        FanningNavigationView(
            selectedTab: .constant(.home),
            showingAddModal: .constant(false)
        )
    }
}
