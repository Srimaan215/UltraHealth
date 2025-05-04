//
//  HealthMetricsFetcher.swift
//  HealthDashBoardApp
//
//  Created by Srimaan Sridharan on 4/18/25.
//
import HealthKit

class HealthMetricsFetcher {
    static let shared = HealthMetricsFetcher()
    private let healthStore = HKHealthStore()

    private init() {}

    func fetchAverageValues(for identifier: HKQuantityTypeIdentifier, unit: HKUnit, days: Int, completion: @escaping ([Double]) -> Void) {
        guard let sampleType = HKObjectType.quantityType(forIdentifier: identifier) else {
            completion([])
            return
        }

        let calendar = Calendar.current
        var results: [Double] = []
        let group = DispatchGroup()

        for i in 0..<days {
            group.enter()
            let end = calendar.date(byAdding: .day, value: -i, to: Date())!
            let start = calendar.startOfDay(for: end)

            let predicate = HKQuery.predicateForSamples(withStart: start, end: calendar.date(byAdding: .day, value: 1, to: start), options: [])

            let query = HKStatisticsQuery(quantityType: sampleType, quantitySamplePredicate: predicate, options: .discreteAverage) { _, result, _ in
                if let avg = result?.averageQuantity()?.doubleValue(for: unit) {
                    results.append(avg)
                } else {
                    results.append(0)
                }
                group.leave()
            }

            healthStore.execute(query)
        }

        group.notify(queue: .main) {
            completion(results.reversed())
        }
    }
}

