//
//  MoneySavedCardView.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//

import SwiftUI

struct MoneySavedCardView: View {
    @EnvironmentObject var quitAttemptViewModel: QuitAttemptViewModel
    @StateObject private var smokingHabitViewModel = SmokingHabitViewModel()
    
    private var startDate: Date {
        dateFormatter().date(from: quitAttemptViewModel.activeQuitAttempt?.startDate ?? "") ?? Date()
    }
    
    private var daysSinceStartDate: Double {
        let timeInterval = Date().timeIntervalSince(startDate)
        return max(0, timeInterval / (60 * 60 * 24))
    }

    private var moneySaved: Double {
        guard let cigarettePrice = smokingHabitViewModel.smokingHabit?.cigarettePrice,
              let dailyCigarettes = smokingHabitViewModel.smokingHabit?.dailyCigarettes else {
            return 0
        }
        let pricePerCigarette = cigarettePrice / 20
        return pricePerCigarette * Double(dailyCigarettes) * daysSinceStartDate
    }
    
    var body: some View {
        Section {
            HStack(spacing: 0) {
                Spacer()
                Text("Saved up to ")
                
                Group {
                    Text(String(format: "%.2f", moneySaved))
                        .foregroundStyle(LinearGradient(gradient: Gradient(colors: [Theme.teal.mainColor, Theme.sky.mainColor]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    Text(" USD")
                }
                .font(.headline)
                .fontWeight(.bold)
                
                Text(" so far")
                Spacer()
            }
            .font(.subheadline)
        }
        .onAppear {
            smokingHabitViewModel.getSmokingHabit()
        }
    }
}

#Preview {
    MoneySavedCardView()
        .environmentObject(QuitAttemptViewModel())
}
