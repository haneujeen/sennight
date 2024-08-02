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
    @State private var showDetail = false
    
    private var startDate: Date {
        dateFormatter().date(from: quitAttemptViewModel.activeQuitAttempt?.startDate ?? "") ?? Date()
    }
    
    var body: some View {
        VStack {
            Text(healthBenefit.timeIntervalString.uppercased())
                .font(.footnote)
                .fontWeight(.semibold)
            CircularGauge(progress: progress)
                .padding()
            Button(action: {
                showDetail = true
            }, label: {
                HStack {
                    healthBenefit.icon
                    Text(healthBenefit.rawValue)
                }
                    .font(.footnote)
                    .fontWeight(.bold)
                    .padding(12)
                    .padding(.horizontal, 40)
                    .foregroundStyle(.blue)
                    .background(Theme.yellow.mainColor)
                    .cornerRadius(16)
            })
            .sheet(isPresented: $showDetail) {
                VStack(alignment: .leading, spacing: 16) {
                    Text(healthBenefit.rawValue)
                        .font(.headline)
                    Text(healthBenefit.description)
                        .lineLimit(5)
                    Text("Note: The health benefits listed are general estimates and may vary from person to person. Please consult with a healthcare professional for personalized guidance.")
                        .font(.footnote)
                        .foregroundColor(.gray)
                    
                    Button("Dismiss") {
                        showDetail = false
                    }
                    .padding()
                }
                .padding()
                .background(Color.white)
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.hidden)
            }
            Spacer()
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
