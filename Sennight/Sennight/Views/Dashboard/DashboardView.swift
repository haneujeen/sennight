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
            ZStack {
                Theme.buttercup.mainColor
                    .ignoresSafeArea()
                
                List {
                    ElapsedTimeTextHeaderView()
                        .frame(height: 40)
                        .listRowBackground(Theme.buttercup.mainColor)
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
                .padding(.top, -20)
                .scrollContentBackground(.hidden)
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
}

#Preview {
    DashboardView()
        .environmentObject(QuitAttemptViewModel())
}
