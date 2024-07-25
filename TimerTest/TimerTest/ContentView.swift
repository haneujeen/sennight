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

let startDate: Date = dateFormatter.date(from: "2024-07-26T06:00:00") ?? Date()

struct ContentView: View {
    @State private var currentDate = Date()
    
    var body: some View {
        VStack {
            Text(elapsedTimeString(from: startDate, to: currentDate))
                .font(.largeTitle)
            
            
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
    
    func elapsedTimeString(from start: Date, to end: Date) -> String {
        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: start, to: end)
        return "\(components.year ?? 0) years \(components.month ?? 0) months \(components.day ?? 0) days \(components.hour ?? 0) hours \(components.minute ?? 0) minutes \(components.second ?? 0) seconds"
    }
}

#Preview {
    ContentView()
}
