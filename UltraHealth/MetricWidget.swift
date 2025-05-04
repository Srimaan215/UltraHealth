//
//  MetricWidget.swift
//  HealthDashBoardApp
//
//  Created by Srimaan Sridharan on 4/18/25.
//

import SwiftUI

struct MetricWidget: View {
    let title: String
    let values: [Double]
    let unit: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)

            HStack(spacing: 6) {
                ForEach(values.indices, id: \.self) { index in
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.blue)
                        .frame(width: 12, height: max(10, CGFloat(values[index] * 2)))
                }
            }

            Text("\(values.last ?? 0, specifier: "%.1f") \(unit)")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}
