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
    
    private var daysSinceStartDate: Int {
        let timeInterval = Date().timeIntervalSince(startDate)
        return max(0, Int(timeInterval / (60 * 60 * 24)))
    }
    
    private var moneySaved: Double {
        smokingHabitViewModel.cigarettePrice * Double(daysSinceStartDate)
    }
    
    var body: some View {
        Section {
            Text(String(format: "%.2f USD", moneySaved))
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
