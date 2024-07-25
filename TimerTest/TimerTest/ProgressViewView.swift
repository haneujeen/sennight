//
//  ProgressViewView.swift
//  TimerTest
//
//  Created by 한유진 on 7/25/24.
//

import SwiftUI

struct ProgressViewView: View {
    var interval: TimeInterval
    @State private var range: ClosedRange<Date>?
    @State private var progress: Double = 0.0
    
    var body: some View {
        VStack {
            CircularGauge(progress: progress)
            Text(String(format: "%.2f%%", progress * 100))
            Text("Interval: \(interval)")
            
        }
//        ProgressView(value: progress, total: 1.0) {
//            Text(String(format: "%.1f%%", progress * 100))
//        }
        .onAppear(perform: {
            range = startDate...startDate.addingTimeInterval(interval)
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                let elapsedTime = Date().timeIntervalSince(startDate)
                let duration = range?.upperBound.timeIntervalSince(startDate) ?? 1
                progress = min(elapsedTime / duration, 1.0)
                
                if progress >= 1.0 {
                    timer.invalidate()
                }
            }
        })
    }
}

#Preview {
    ProgressViewView(interval: intervals[0])
}
