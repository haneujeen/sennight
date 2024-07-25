//
//  ProgressViewView.swift
//  TimerTest
//
//  Created by 한유진 on 7/25/24.
//

import SwiftUI

struct ProgressViewView: View {
    let range = startDate...startDate.addingTimeInterval(3600) // 1 hour
    @State private var progress: Double = 0.0
    
    var body: some View {
        ProgressView(value: progress, total: 1.0) {
            Text(String(format: "%.1f%%", progress * 100))
        }
        .onAppear(perform: {
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                let elapsedTime = Date().timeIntervalSince(startDate)
                let duration = range.upperBound.timeIntervalSince(startDate)
                progress = min(elapsedTime / duration, 1.0)
                
                if progress >= 1.0 {
                    timer.invalidate()
                }
            }
        })
    }
}

#Preview {
    ProgressViewView()
}
