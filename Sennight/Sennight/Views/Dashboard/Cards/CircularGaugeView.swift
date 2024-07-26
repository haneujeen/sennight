//
//  CircularGaugeView.swift
//  Sennight
//
//  Created by 한유진 on 7/26/24.
//

import SwiftUI

struct CircularGaugeView: View {
    @EnvironmentObject var quitAttemptViewModel: QuitAttemptViewModel
    var healthBenefit: HealthBenefit
    @State private var range: ClosedRange<Date>?
    @State private var progress: Double = 0.0
    
    private var startDate: Date {
        dateFormatter.date(from: quitAttemptViewModel.activeQuitAttempt?.startDate ?? "") ?? Date()
    }
    
    var body: some View {
        VStack {
            CircularGauge(progress: progress)
            Text(healthBenefit.rawValue)
            Text(healthBenefit.description)
        }
        .onAppear(perform: {
            range = startDate...startDate.addingTimeInterval(healthBenefit.timeInterval)
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
    CircularGaugeView(healthBenefit: .breathing)
        .environmentObject(QuitAttemptViewModel())
}
