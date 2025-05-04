import SwiftUI
import HealthKit

enum HealthMetricType: String, Identifiable {
    case recovery = "Recovery"
    case sleepScore = "Sleep Score"
    case exertion = "Exertion"
    case energy = "Energy"
    case respiratoryRate = "Respiratory Rate"
    case restingHeartRate = "Resting Heart Rate"
    case hrv = "HRV"
    case bodyTemperature = "Body Temperature"
    case sleepHours = "Sleep Hours"
    case steps = "Steps"

    var id: String { self.rawValue }
}


struct DashboardView: View {
    @State private var healthStore = HKHealthStore()

    @State private var heartRate: Double = 0
    @State private var respiratoryRate: Double = 0
    @State private var hrv: Double = 0
    @State private var temperature: Double = 0
    @State private var sleepHours: Double = 0
    @State private var stepsToday: Double = 0

    @State private var recoveryScore: Double = 0
    @State private var sleepScore: Double = 0
    @State private var exertionScore: Double = 0
    @State private var energyScore: Double = 0

    @State private var selectedDate = Date()
    @State private var isCalendarPresented = false

    @State private var selectedMetric: HealthMetricType? = nil
    @State private var isMetricDetailPresented = false

    @State private var isSettingsPresented = false

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                HStack {
                    Text(selectedDate, style: .date)
                        .font(.title2.bold())
                        .foregroundColor(.black)
                        .padding(.leading)
                        .onTapGesture {
                            isCalendarPresented = true
                        }

                    Spacer()
                    Button {
                        isSettingsPresented = true
                    } label: {
                        Image(systemName: "gearshape")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .foregroundColor(.gray)
                            .padding(.trailing)
                    }
                }
                .padding(.top)
                .frame(minHeight: 44)
                Divider()
                    .padding(.horizontal)
                VStack(alignment: .leading, spacing: 16) {
                    Text("Daily Metrics")
                        .font(.title2.bold())
                        .foregroundColor(.black)
                        .padding(.bottom, 8)

                    HStack(spacing: 12) {
                        Button {
                            selectedMetric = .recovery
                            isMetricDetailPresented = true
                        } label: {
                            CircularWidget(title: "Recovery", value: recoveryScore, baseColor: .green)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .frame(maxWidth: .infinity)

                        Button {
                            selectedMetric = .sleepScore
                            isMetricDetailPresented = true
                        } label: {
                            CircularWidget(title: "Sleep", value: sleepScore, baseColor: .purple)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .frame(maxWidth: .infinity)
                    }

                    HStack(spacing: 12) {
                        Button {
                            selectedMetric = .exertion
                            isMetricDetailPresented = true
                        } label: {
                            CircularWidget(title: "Exertion", value: exertionScore, baseColor: .cyan)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .frame(maxWidth: .infinity)
                        Button {
                            selectedMetric = .energy
                            isMetricDetailPresented = true
                        } label: {
                            CircularWidget(title: "Energy", value: energyScore, baseColor: .orange)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .frame(maxWidth: .infinity)
                    }
                }
                .padding(.all, 16)
                .background(Color.white)
                .cornerRadius(20)
                .shadow(color: .gray.opacity(0.3), radius: 10, x: 0, y: 4)
                VStack(alignment: .leading, spacing: 16) {
                    Text("Health Monitor")
                        .font(.title2.bold())
                        .foregroundColor(.black)
                        .padding(.bottom, 8)

                    let fixedWidgetHeight: CGFloat = 90

                    GeometryReader { geometry in
                        HStack(spacing: 12) {
                            let totalSpacing: CGFloat = 12
                            let availableWidth = geometry.size.width - totalSpacing
                            let widgetWidth = availableWidth / 2


                            Button {
                                selectedMetric = .respiratoryRate
                                isMetricDetailPresented = true
                            } label: {
                                BevelHealthWidget(title: "RR", value: respiratoryRate, unit: "rpm", range: 12...18)
                            }
                            .buttonStyle(PlainButtonStyle())
                            .frame(width: widgetWidth, height: fixedWidgetHeight)


                            Button {
                                selectedMetric = .restingHeartRate
                                isMetricDetailPresented = true
                            } label: {
                                BevelHealthWidget(title: "RHR", value: heartRate, unit: "bpm", range: 50...100)
                            }
                            .buttonStyle(PlainButtonStyle())
                            .frame(width: widgetWidth, height: fixedWidgetHeight)
                        }
                    }
                    .frame(height: fixedWidgetHeight)

                    GeometryReader { geometry in
                        HStack(spacing: 12) {
                             let totalSpacing: CGFloat = 12
                             let availableWidth = geometry.size.width - totalSpacing
                             let widgetWidth = availableWidth / 2

                            Button {
                                selectedMetric = .hrv
                                isMetricDetailPresented = true
                            } label: {
                                BevelHealthWidget(title: "HRV", value: hrv, unit: "ms", range: 20...120)
                            }
                            .buttonStyle(PlainButtonStyle())
                            .frame(width: widgetWidth, height: fixedWidgetHeight)
                            Button {
                                selectedMetric = .bodyTemperature
                                isMetricDetailPresented = true
                            } label: {
                                BevelHealthWidget(title: "Temp", value: temperature, unit: "°F", range: 95.0...99.5)
                            }
                            .buttonStyle(PlainButtonStyle())
                            .frame(width: widgetWidth, height: fixedWidgetHeight)
                        }
                    }
                     .frame(height: fixedWidgetHeight)

                    GeometryReader { geometry in
                        HStack(spacing: 12) {
                             let totalSpacing: CGFloat = 12
                             let availableWidth = geometry.size.width - totalSpacing
                             let widgetWidth = availableWidth / 2

                            Button {
                                selectedMetric = .sleepHours
                                isMetricDetailPresented = true
                            } label: {
                                BevelHealthWidget(title: "Sleep", value: sleepHours, unit: "hrs", range: 4...9)
                            }
                            .buttonStyle(PlainButtonStyle())
                            .frame(width: widgetWidth, height: fixedWidgetHeight)

                            Button {
                                selectedMetric = .steps
                                isMetricDetailPresented = true
                            } label: {
                                BevelHealthWidget(title: "Steps", value: stepsToday, unit: "", range: 0...10000)
                            }
                            .buttonStyle(PlainButtonStyle())
                            .frame(width: widgetWidth, height: fixedWidgetHeight)
                        }
                    }
                     .frame(height: fixedWidgetHeight)

                }
                .padding(.all, 16)
                .background(Color.white)
                .cornerRadius(20)
                .shadow(color: .gray.opacity(0.3), radius: 10, x: 0, y: 4)


            }
            .padding()
            .onAppear {
                print("DashboardView appeared. Fetching data for initial date: \(selectedDate)")
                fetchHealthData(for: selectedDate)
            }
            .onChange(of: selectedDate) { newDate in
                print("Selected date changed to \(newDate). Fetching data...")
                fetchHealthData(for: newDate)
            }
        }
        .background(Color.white.ignoresSafeArea())
        .sheet(isPresented: $isCalendarPresented) {
            CalendarSheetView(selectedDate: $selectedDate, isPresented: $isCalendarPresented)
        }
        .sheet(item: $selectedMetric) { metricType in
            MetricDetailView(metricType: metricType, selectedDate: selectedDate)
        }
        .sheet(isPresented: $isSettingsPresented){
            SettingView()
        }
    }

    func fetchHealthData(for date: Date) {
         print("Attempting to fetch health data for \(date)...")
         let typesToRead: Set = [
             HKObjectType.quantityType(forIdentifier: .restingHeartRate)!,
             HKObjectType.quantityType(forIdentifier: .respiratoryRate)!,
             HKObjectType.quantityType(forIdentifier: .heartRateVariabilitySDNN)!,
             HKObjectType.quantityType(forIdentifier: .bodyTemperature)!,
             HKObjectType.categoryType(forIdentifier: .sleepAnalysis)!,
             HKObjectType.quantityType(forIdentifier: .stepCount)!
         ]

         healthStore.requestAuthorization(toShare: [], read: typesToRead) { success, error in
             if success {
                 print("HealthKit authorization granted.")
                 readMostRecentSample(for: .restingHeartRate, on: date) { sample in
                     self.heartRate = sample
                     print("Fetched Resting Heart Rate for \(date): \(sample)")
                      self.calculateDashboardScores()
                 }
                 readMostRecentSample(for: .respiratoryRate, on: date) { sample in
                     self.respiratoryRate = sample
                     print("Fetched Respiratory Rate for \(date): \(sample)")
                      self.calculateDashboardScores()
                 }
                 readMostRecentSample(for: .heartRateVariabilitySDNN, on: date) { sample in
                     self.hrv = sample
                     print("Fetched HRV SDNN for \(date): \(sample)")
                      self.calculateDashboardScores()
                 }
                 readMostRecentSample(for: .bodyTemperature, on: date) { sample in
                     self.temperature = sample
                     print("Fetched Body Temperature for \(date): \(sample)")
                      self.calculateDashboardScores()
                 }
                 readSleepSample(for: date) { hours in
                     self.sleepHours = hours
                     print("Fetched Sleep Hours for \(date): \(hours)")
                      self.calculateDashboardScores()
                 }
                  readStepsForDay(date: date) { steps in
                       self.stepsToday = steps
                       print("Fetched Steps for \(date): \(steps)")
                        self.calculateDashboardScores()
                  }

             } else {
                 if let error = error {
                     print("HealthKit authorization failed: \(error.localizedDescription)")
                 } else {
                     print("HealthKit authorization failed.")
                 }
                 DispatchQueue.main.async {
                      self.heartRate = 0
                      self.respiratoryRate = 0
                      self.hrv = 0
                      self.temperature = 0
                      self.sleepHours = 0
                      self.stepsToday = 0
                     self.calculateDashboardScores()
                 }
             }
         }
     }

     func calculateDashboardScores() {
        print("Calculating dashboard scores...")
        let calculatedRecovery = min(100.0, max(0.0, (hrv / 120.0 * 50.0) + (sleepHours / 9.0 * 50.0)))

        let calculatedSleepScore = min(100.0, max(0.0, (sleepHours / 8.0) * 100.0))

        let calculatedExertion = min(100.0, max(0.0, stepsToday / 100.0))

        let calculatedEnergy = min(100.0, max(0.0, (calculatedRecovery * 0.6 + calculatedSleepScore * 0.4)))

        DispatchQueue.main.async {
            self.recoveryScore = calculatedRecovery
            self.sleepScore = calculatedSleepScore
            self.exertionScore = calculatedExertion
            self.energyScore = calculatedEnergy
            print("Scores calculated: Recovery=\(self.recoveryScore), Sleep=\(self.sleepScore), Exertion=\(self.exertionScore), Energy=\(self.energyScore)")
        }
     }

     func readMostRecentSample(for identifier: HKQuantityTypeIdentifier, on date: Date, completion: @escaping (Double) -> Void) {
         guard let sampleType = HKObjectType.quantityType(forIdentifier: identifier) else {
             print("Error: Could not create sample type for \(identifier.rawValue)")
             DispatchQueue.main.async { completion(0) }
             return
         }

         let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)

         let predicate = HKQuery.predicateForSamples(withStart: nil, end: date, options: .strictEndDate)


         let query = HKSampleQuery(sampleType: sampleType, predicate: predicate, limit: 1, sortDescriptors: [sortDescriptor]) { _, results, queryError in
              if let queryError = queryError {
                  print("Error fetching most recent \(identifier.rawValue) on or before \(date): \(queryError.localizedDescription)")
                  DispatchQueue.main.async { completion(0) }
                  return
              }

             if let result = results?.first as? HKQuantitySample {
                 let unit: HKUnit
                 switch identifier {
                 case .restingHeartRate: unit = .count().unitDivided(by: .minute())
                 case .respiratoryRate: unit = .count().unitDivided(by: .minute())
                 case .heartRateVariabilitySDNN: unit = .secondUnit(with: .milli)
                 case .bodyTemperature: unit = .degreeFahrenheit()
                 case .stepCount: unit = .count()
                 default:
                      print("Unknown identifier unit: \(identifier.rawValue)")
                      DispatchQueue.main.async { completion(0) }
                     return
                 }
                 DispatchQueue.main.async {
                      let value = result.quantity.doubleValue(for: unit)
                      completion(value)
                 }
             } else {
                 print("No recent sample found for \(identifier.rawValue) on or before \(date).")
                  DispatchQueue.main.async { completion(0) }
             }
         }
         healthStore.execute(query)
     }

     func readSleepSample(for date: Date, completion: @escaping (Double) -> Void) {
         guard let sleepType = HKObjectType.categoryType(forIdentifier: .sleepAnalysis) else {
              print("Error: Could not create sample type for sleepAnalysis")
              DispatchQueue.main.async { completion(0) }
             return
         }

         let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)

         let calendar = Calendar.current
         let startOfSelectedDay = calendar.startOfDay(for: date)
         guard let startOfNextDay = calendar.date(byAdding: .day, value: 1, to: startOfSelectedDay) else {
             print("Error calculating start of next day for sleep query.")
             DispatchQueue.main.async { completion(0) }
             return
         }
         let predicate = HKQuery.predicateForSamples(withStart: startOfSelectedDay, end: startOfNextDay, options: .strictEndDate)


         let query = HKSampleQuery(sampleType: sleepType, predicate: predicate, limit: HKObjectQueryNoLimit, sortDescriptors: [sortDescriptor]) { _, results, queryError in
             if let queryError = queryError {
                  print("Error fetching sleep samples for \(date): \(queryError.localizedDescription)")
                  DispatchQueue.main.async { completion(0) }
                  return
             }

             guard let sleepSamples = results?.compactMap({ $0 as? HKCategorySample }) else {
                 print("No sleep samples found or error casting samples for \(date).")
                 DispatchQueue.main.async { completion(0) }
                 return
             }

             let relevantSleepSamples = sleepSamples.filter { sample in
                  sample.value == HKCategoryValueSleepAnalysis.asleep.rawValue ||
                  sample.value == HKCategoryValueSleepAnalysis.asleepCore.rawValue ||
                  sample.value == HKCategoryValueSleepAnalysis.asleepDeep.rawValue ||
                  sample.value == HKCategoryValueSleepAnalysis.asleepREM.rawValue
             }

             let totalAsleepTime = relevantSleepSamples.reduce(0.0) { total, sample in
                 total + sample.endDate.timeIntervalSince(sample.startDate)
             }

             print("Total sleep time fetched (seconds) for \(date): \(totalAsleepTime)")

             DispatchQueue.main.async {
                 completion(totalAsleepTime / 3600.0)
             }
         }
         healthStore.execute(query)
     }

     func readStepsForDay(date: Date, completion: @escaping (Double) -> Void) {
         guard let stepType = HKObjectType.quantityType(forIdentifier: .stepCount) else {
             print("Error: Could not create sample type for stepCount")
             DispatchQueue.main.async { completion(0) }
             return
         }

         let calendar = Calendar.current
         let startOfSelectedDay = calendar.startOfDay(for: date)
          guard let endOfSelectedDay = calendar.date(byAdding: .day, value: 1, to: startOfSelectedDay) else {
              print("Error calculating end of day for steps query.")
              DispatchQueue.main.async { completion(0) }
              return
          }
         let predicate = HKQuery.predicateForSamples(withStart: startOfSelectedDay, end: endOfSelectedDay, options: .strictEndDate)

         let query = HKStatisticsQuery(quantityType: stepType, quantitySamplePredicate: predicate, options: .cumulativeSum) { _, statistics, queryError in
              if let queryError = queryError {
                  print("Error fetching steps for \(date): \(queryError.localizedDescription)")
                  DispatchQueue.main.async { completion(0) }
                  return
              }

            var stepCount = 0.0
            if let sumQuantity = statistics?.sumQuantity() {
                stepCount = sumQuantity.doubleValue(for: .count())
            }
            print("Total steps fetched for \(date): \(stepCount)")

            DispatchQueue.main.async {
                completion(stepCount)
            }
        }
        healthStore.execute(query)
    }
}

struct CalendarSheetView: View {
    @Binding var selectedDate: Date
    @Binding var isPresented: Bool

    @Environment(\.presentationMode) var presentationMode

    let dateRange: ClosedRange<Date> = {
           let calendar = Calendar.current
           let now = Date()
           let startComponents = calendar.dateComponents([.year, .month, .day], from: calendar.date(byAdding: .year, value: -1, to: now)!)
           let endComponents = calendar.dateComponents([.year, .month, .day], from: now)
           return calendar.date(from:startComponents)! ... calendar.date(from:endComponents)!
       }()


    var body: some View {
        NavigationView {
            VStack {
                DatePicker(
                    "Select a date",
                    selection: $selectedDate,
                    in: dateRange,
                    displayedComponents: [.date]
                )
                .datePickerStyle(.graphical)

                Spacer()
            }
            .padding()
            .navigationTitle("Select Date")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                    }
                }
            }
        }
    }
}

struct MetricDetailView: View {
    let metricType: HealthMetricType
    let selectedDate: Date

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "info.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.blue)
                    .padding()

                Text("Details for \(metricType.rawValue)")
                    .font(.title.bold())
                    .padding(.bottom)

                Text("Data for \(selectedDate, style: .date)")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .padding(.bottom)

                Text("This is where you will add more detailed information, charts, or historical data for \(metricType.rawValue).")
                    .multilineTextAlignment(.center)
                    .padding()

                Spacer()
            }
            .navigationTitle(metricType.rawValue)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                    }
                }
            }
        }
    }
}


struct CircularWidget: View {
    var title: String
    var value: Double
    var baseColor: Color

    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                Circle()
                    .stroke(baseColor.opacity(0.2), lineWidth: 10)

                Circle()
                    .trim(from: 0, to: value / 100)
                    .stroke(
                        dynamicColor(for: value, base: baseColor),
                        style: StrokeStyle(lineWidth: 10, lineCap: .round)
                    )
                    .rotationEffect(.degrees(-90))

                    .shadow(color: dynamicColor(for: value, base: baseColor).opacity(0.6), radius: 6, x: 0, y: 0)

                Text("\(Int(value))%")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.black)
            }
            .frame(width: 100, height: 100)

            Text(title)
                .font(.subheadline)
                .foregroundColor(.black)
                .padding(.top, 5)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: .gray.opacity(0.3), radius: 8, x: 0, y: 4)
    }

     private func dynamicColor(for value: Double, base: Color) -> Color {
         let normalizedValue = min(max(value, 0), 100) / 100.0
         return shade(for: base, at: normalizedValue)
     }

     private func shade(for base: Color, at factor: CGFloat) -> Color {
         switch base {
         case .green:
             let lightGreen = Color(red: 0.6, green: 0.9, blue: 0.6)
             let darkGreen = Color(red: 0.1, green: 0.5, blue: 0.1)
             return Color.blend(color1: lightGreen, color2: darkGreen, factor: factor)
         case .purple:
             let lightPurple = Color(red: 0.8, green: 0.6, blue: 0.9)
             let darkPurple = Color(red: 0.4, green: 0.2, blue: 0.6)
              return Color.blend(color1: lightPurple, color2: darkPurple, factor: factor)
         case .cyan:
             let lightCyan = Color(red: 0.6, green: 0.9, blue: 0.95)
             let darkCyan = Color(red: 0.1, green: 0.5, blue: 0.6)
              return Color.blend(color1: lightCyan, color2: darkCyan, factor: factor)
         case .orange:
              let lightOrange = Color(red: 1.0, green: 0.8, blue: 0.6)
              let darkOrange = Color(red: 0.8, green: 0.4, blue: 0.1)
              return Color.blend(color1: lightOrange, color2: darkOrange, factor: factor)
         default:
             return base.opacity(0.4 + (1.0 - 0.4) * factor)
         }
     }
}

extension Color {
    static func blend(color1: Color, color2: Color, factor: CGFloat) -> Color {
        guard factor >= 0 && factor <= 1 else { return .clear }

        #if os(iOS) || os(tvOS) || os(watchOS)
        let uiColor1 = UIColor(color1)
        let uiColor2 = UIColor(color2)

        var r1: CGFloat = 0, g1: CGFloat = 0, b1: CGFloat = 0, a1: CGFloat = 0
        var r2: CGFloat = 0, g2: CGFloat = 0, b2: CGFloat = 0, a2: CGFloat = 0

        uiColor1.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        uiColor2.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)

        let r = r1 + (r2 - r1) * factor
        let g = g1 + (g2 - g1) * factor
        let b = b1 + (b2 - b1) * factor
        let a = a1 + (a2 - a1) * factor

        return Color(red: Double(r), green: Double(g), blue: Double(b), opacity: Double(a))

        #elseif os(macOS)
         let nsColor1 = NSColor(color1)
         let nsColor2 = NSColor(color2)

         var r1: CGFloat = 0, g1: CGFloat = 0, b1: CGFloat = 0, a1: CGFloat = 0
         var r2: CGFloat = 0, g2: CGFloat = 0, b2: CGFloat = 0, a2: CGFloat = 0

         nsColor1.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
         nsColor2.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)

         let r = r1 + (r2 - r1) * factor
         let g = g1 + (g2 - g1) * factor
         let b = b1 + (b2 - b1) * factor
         let a = a1 + (a2 - a1) * factor

         return Color(red: Double(r), green: Double(g), blue: Double(b), opacity: Double(a))
        #else
         let factor = Double(factor)
         return color1
        #endif
    }
}


struct BevelHealthWidget: View {
    var title: String
    var value: Double
    var unit: String
    var range: ClosedRange<Double>

    var body: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.gray)

                Text("\(String(format: "%.1f", value)) \(unit)")
                    .font(.title2.bold())
                    .foregroundColor(.black)
            }
            Spacer()

            ZStack(alignment: .bottom) {
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: 12, height: 60)

                let clampedValue = min(max(value, range.lowerBound), range.upperBound)
                let normalizedValue = (clampedValue - range.lowerBound) / (range.upperBound - range.lowerBound)
                let fillHeight = CGFloat(normalizedValue * 60)

                RoundedRectangle(cornerRadius: 5)
                    .fill(range.contains(value) ? Color.green : Color.orange)
                    .frame(width: 12, height: fillHeight)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: .gray.opacity(0.2), radius: 6, x: 0, y: 3)
    }
}

#Preview {
    ContentView()
}
