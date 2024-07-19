//
//  ProgressViewExample.swift
//  HealthProgressCardTest
//
//  Created by 한유진 on 7/19/24.
//

import SwiftUI

struct ProgressViewExample: View {
    @StateObject private var myTimer = MyTimer(frequency: 1)
    
    var body: some View {
        VStack {
            Text("Progress Bars")
                .font(.largeTitle)
                .padding()
            
            Text("Elapsed Time: \(formattedElapsedTime)")
                .font(.headline)
                .padding()
            
            List {
                ProgressBarView(timer: myTimer, title: "20 minutes", lengthInMinutes: 20)
                ProgressBarView(timer: myTimer, title: "48 hours", lengthInMinutes: 48 * 60)
                ProgressBarView(timer: myTimer, title: "72 hours", lengthInMinutes: 72 * 60)
                ProgressBarView(timer: myTimer, title: "1 month", lengthInMinutes: 30 * 24 * 60)
                ProgressBarView(timer: myTimer, title: "3 months", lengthInMinutes: 3 * 30 * 24 * 60)
                ProgressBarView(timer: myTimer, title: "9 months", lengthInMinutes: 9 * 30 * 24 * 60)
                ProgressBarView(timer: myTimer, title: "1 year", lengthInMinutes: 365 * 24 * 60)
                ProgressBarView(timer: myTimer, title: "5 years", lengthInMinutes: 5 * 365 * 24 * 60)
                ProgressBarView(timer: myTimer, title: "10 years", lengthInMinutes: 10 * 365 * 24 * 60)
                ProgressBarView(timer: myTimer, title: "15 years", lengthInMinutes: 15 * 365 * 24 * 60)
            }
        }
        .onAppear {
            let startDate = ISO8601DateFormatter().date(from: "2024-07-19T08:30:48Z")!
            myTimer.startTimer(startDate: startDate)
        }
        .onDisappear {
            myTimer.stopTimer()
        }
    }
}

extension ProgressViewExample {
    private var formattedElapsedTime: String {
        let seconds = myTimer.secondsElapsed
        
        if seconds < 3600 { // Less than an hour
            let minutes = seconds / 60
            let remainingSeconds = seconds % 60
            return "\(minutes) minute\(minutes != 1 ? "s" : "") \(remainingSeconds) second\(remainingSeconds != 1 ? "s" : "")"
        } else if seconds < 86400 { // Less than a day
            let hours = seconds / 3600
            let minutes = (seconds % 3600) / 60
            let remainingSeconds = seconds % 60
            return "\(hours) hour\(hours != 1 ? "s" : "") \(minutes) minute\(minutes != 1 ? "s" : "") \(remainingSeconds) second\(remainingSeconds != 1 ? "s" : "")"
        } else if seconds < 2592000 { // Less than 30 days
            let days = seconds / 86400
            let hours = (seconds % 86400) / 3600
            let minutes = (seconds % 3600) / 60
            return "\(days) day\(days != 1 ? "s" : "") \(hours) hour\(hours != 1 ? "s" : "") \(minutes) minute\(minutes != 1 ? "s" : "")"
        } else if seconds < 31536000 { // Less than a year
            let months = seconds / 2592000
            let days = (seconds % 2592000) / 86400
            let hours = (seconds % 86400) / 3600
            return "\(months) month\(months != 1 ? "s" : "") \(days) day\(days != 1 ? "s" : "") \(hours) hour\(hours != 1 ? "s" : "")"
        } else { // More than a year
            let years = seconds / 31536000
            let months = (seconds % 31536000) / 2592000
            let days = (seconds % 2592000) / 86400
            return "\(years) year\(years != 1 ? "s" : "") \(months) month\(months != 1 ? "s" : "") \(days) day\(days != 1 ? "s" : "")"
        }
    }
}

#Preview {
    ProgressViewExample()
}
