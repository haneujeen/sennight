//
//  ContentView.swift
//  TimerTest
//
//  Created by wizard on 7/25/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var myTimer = MyTimer()
    let range1 = startDate...startDate.addingTimeInterval(720) // 12 minutes
    let range2 = startDate...startDate.addingTimeInterval(3600) // 1 hour
    @State private var progress1: Double = 0.0
    @State private var progress2: Double = 0.0
    
    var body: some View {
        VStack {
            Text(elapsedTimeString(from: startDate, to: Date()))
                .font(.largeTitle)
            
            ProgressView(value: progress1, total: 1.0) {
                Text(String(format: "%.1f%%", progress1 * 100))
            }
            
            ProgressView(value: progress2, total: 1.0) {
                Text(String(format: "%.1f%%", progress2 * 100))
            }
        }
        .onAppear(perform: {
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                let elapsedTime = Date().timeIntervalSince(startDate)
                let duration = range1.upperBound.timeIntervalSince(startDate)
                progress1 = min(elapsedTime / duration, 1.0)
                
                if progress1 >= 1.0 {
                    timer.invalidate()
                }
            }
            
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                let elapsedTime = Date().timeIntervalSince(startDate)
                let duration = range2.upperBound.timeIntervalSince(startDate)
                progress2 = min(elapsedTime / duration, 1.0)
                
                if progress2 >= 1.0 {
                    timer.invalidate()
                }
            }
        })
    }
    
    func elapsedTimeString(from start: Date, to end: Date) -> String {
        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: start, to: end)
        return "\(components.year ?? 0) years \(components.month ?? 0) months \(components.day ?? 0) days \(components.hour ?? 0) hours \(components.minute ?? 0) minutes \(components.second ?? 0) seconds"
    }
}

let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    return formatter
}()

let startDate: Date = dateFormatter.date(from: "2024-07-25T13:44:00") ?? Date()

#Preview {
    ContentView()
}
