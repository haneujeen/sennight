//
//  DashboardView.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//

import SwiftUI

struct DashboardView: View {
    @StateObject private var quitAttemptViewModel = QuitAttemptViewModel()
    @StateObject private var motivationViewModel = MotivationViewModel()
    var body: some View {
        NavigationStack {
            List {
                ElapsedTimeTextHeaderView()
                    .frame(height: 60)
                    .environmentObject(quitAttemptViewModel)
                QuitAttemptCardView()
                    .frame(height: 300)
                    .environmentObject(quitAttemptViewModel)
                MotivationCardView()
                    .frame(height: 40)
                    .environmentObject(motivationViewModel)
                MoneySavedCardView()
                    .frame(height: 40)
                AidProductsCardView()
                SymptomsCardView()
                ActivitiesCardView()
            }
            .onAppear {
                quitAttemptViewModel.getActiveQuitAttempt()
            }
        }
    }
}

#Preview {
    DashboardView()
}
