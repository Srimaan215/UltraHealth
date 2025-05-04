//
//  HealthDataFetcher.swift
//  HealthDashBoardApp
//
//  Created by Srimaan Sridharan on 4/14/25.
//


import Foundation
import HealthKit

class HealthDataFetcher: ObservableObject {
    private let healthStore = HKHealthStore()

    @Published var hrv: Double = 0.0
    @Published var restingHeartRate: Double = 0.0
    @Published var sleepHours: Double = 0.0

    init() {
        requestAuthorization()
    }

    func requestAuthorization() {
        let types: Set = [
            HKObjectType.quantityType(forIdentifier: .heartRateVariabilitySDNN)!,
            HKObjectType.quantityType(forIdentifier: .restingHeartRate)!,
            HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!
        ]

        healthStore.requestAuthorization(toShare: [], read: types) { success, _ in
            if success {
                self.fetchHRV()
                self.fetchRestingHR()
                self.fetchSleep()
            }
        }
    }

    func fetchHRV() {
        guard let hrvType = HKQuantityType.quantityType(forIdentifier: .heartRateVariabilitySDNN) else { return }
        let now = Date()
        let startDate = Calendar.current.date(byAdding: .day, value: -1, to: now)!
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: now)

        let query = HKStatisticsQuery(quantityType: hrvType, quantitySamplePredicate: predicate, options: .discreteAverage) { _, result, _ in
            DispatchQueue.main.async {
                if let avg = result?.averageQuantity() {
                    self.hrv = avg.doubleValue(for: .init(from: "ms"))
                }
            }
        }
        healthStore.execute(query)
    }

    func fetchRestingHR() {
        guard let type = HKQuantityType.quantityType(forIdentifier: .restingHeartRate) else { return }
        let now = Date()
        let startDate = Calendar.current.date(byAdding: .day, value: -1, to: now)!
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: now)

        let query = HKStatisticsQuery(quantityType: type, quantitySamplePredicate: predicate, options: .discreteAverage) { _, result, _ in
            DispatchQueue.main.async {
                if let avg = result?.averageQuantity() {
                    self.restingHeartRate = avg.doubleValue(for: .init(from: "count/min"))
                }
            }
        }
        healthStore.execute(query)
    }

    func fetchSleep() {
        guard let type = HKObjectType.categoryType(forIdentifier: .sleepAnalysis) else { return }
        let now = Date()
        let startDate = Calendar.current.date(byAdding: .day, value: -1, to: now)!
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: now)

        let handler: (HKSampleQuery, [HKSample]?, Error?) -> Void = { _, samples, _ in
            let sleepSamples = samples?.compactMap { $0 as? HKCategorySample }
                .filter { $0.value == HKCategoryValueSleepAnalysis.asleep.rawValue } ?? []

            let totalSleep = sleepSamples.reduce(0.0) {
                $0 + $1.endDate.timeIntervalSince($1.startDate)
            }

            DispatchQueue.main.async {
                self.sleepHours = totalSleep / 3600
            }
        }

        let query = HKSampleQuery(sampleType: type, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: nil, resultsHandler: handler)
        healthStore.execute(query)
    }

}
