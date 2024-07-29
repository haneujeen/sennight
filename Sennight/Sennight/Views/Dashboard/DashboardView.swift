//
//  DashboardView.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//

import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var quitAttemptViewModel: QuitAttemptViewModel
    @Environment(\.scenePhase) private var scenePhase
    
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
                    .environmentObject(quitAttemptViewModel)
                MoneySavedCardView()
                    .frame(height: 40)
                    .environmentObject(quitAttemptViewModel)
                AidProductsCardView()
                SymptomsCardView()
                ActivitiesCardView()
            }
            .onAppear {
                quitAttemptViewModel.getActiveQuitAttempt()
            }
            .onChange(of: scenePhase) { oldPhase, newPhase in
                if newPhase == .active {
                    print("App became active")
                    quitAttemptViewModel.getActiveQuitAttempt()
                } else {
                    print("Scene phase changed to: \(newPhase)")
                }
            }
        }
    }
}

#Preview {
    DashboardView()
        .environmentObject(QuitAttemptViewModel())
}
