//
//  ProgressBarView.swift
//  HealthProgressCardTest
//
//  Created by 한유진 on 7/19/24.
//

import SwiftUI

struct ProgressBarView: View {
    @ObservedObject var timer: MyTimer
    let title: String
    let lengthInMinutes: Int
    
    private var lengthInSeconds: Int {
        lengthInMinutes * 60
    }
    
    private var progress: Double {
        let progress = Double(timer.secondsElapsed) / Double(lengthInSeconds)
        return min(max(progress, 0), 1)
    }
    
    private var percentage: String {
        if progress == 1 { return "100%" }
        return String(format: "%.1f%%", progress * 100)
    }
    
    var body: some View {
        VStack {
            Text(title)
            ProgressView(value: progress)
                .progressViewStyle(LinearProgressViewStyle())
                .padding()
            Text("\(percentage) completed")
        }
    }
}

#Preview {
    ProgressBarView(timer: MyTimer(frequency: 1), title: "20 minutes", lengthInMinutes: 20)
}
