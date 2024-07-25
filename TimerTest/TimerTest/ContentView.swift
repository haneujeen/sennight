//
//  ContentView.swift
//  TimerTest
//
//  Created by wizard on 7/25/24.
//

import SwiftUI

let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    return formatter
}()

let intervals: [TimeInterval] = [
    1_200,            // 20 minutes
    28_800,           // 8 hours
    172_800,          // 48 hours
    259_200,          // 72 hours
    4_838_400,        // 8 weeks
    7_257_600,        // 12 weeks
    15_552_000,       // 6 months
    31_536_000,       // 1 year
    157_680_000,      // 5 years
    220_752_000,      // 7 years
    315_360_000,      // 10 years
    378_432_000,      // 12 years
    473_385_600       // 15 years
]

let startDate: Date = dateFormatter.date(from: "1980-09-05T6:00:00") ?? Date()

struct ContentView: View {
    @State private var currentDate = Date()
    
    var body: some View {
        VStack {
            HStack {
                if currentDate.timeIntervalSince(startDate) > 31_536_000 {
                    Text(elapsedTimeStringYears(from: startDate, to: currentDate))
                }
                if currentDate.timeIntervalSince(startDate) > 2_592_000 {
                    Text(elapsedTimeStringMonths(from: startDate, to: currentDate))
                }
                if currentDate.timeIntervalSince(startDate) > 86400 {
                    Text(elapsedTimeStringDays(from: startDate, to: currentDate))
                }
            }
            .font(.system(size: 26))
            
            if currentDate.timeIntervalSince(startDate) > 86400 {
                HStack {
                    Text(elapsedTimeStringHours(from: startDate, to: currentDate))
                    Text(elapsedTimeStringMinutes(from: startDate, to: currentDate))
                    Text(elapsedTimeStringSeconds(from: startDate, to: currentDate))
                }
                .font(.system(size: 18))
            } else {
                HStack {
                    Text(elapsedTimeStringHours(from: startDate, to: currentDate))
                    Text(elapsedTimeStringMinutes(from: startDate, to: currentDate))
                    Text(elapsedTimeStringSeconds(from: startDate, to: currentDate))
                }
                .font(.system(size: 24))
            }
            
            PagingView()
        }
        .onAppear(perform: {
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                DispatchQueue.main.async {
                    self.currentDate = Date()
                }
            }
        })
    }
}

#Preview {
    ContentView()
}
