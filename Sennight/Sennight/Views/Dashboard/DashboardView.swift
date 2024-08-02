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
    
    @State private var showConfetti = false
    @State private var isLoading = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Theme.buttercup.mainColor
                    .ignoresSafeArea()
                
                List {
                    Section {
                        Color.clear
                            .frame(height: 40)
                            .listRowBackground(Color.clear)
                    }
                    QuitAttemptCardView(showConfetti: $showConfetti)
                        .frame(height: 320)
                        .environmentObject(quitAttemptViewModel)
                        .listRowBackground(
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color.white)
                        )
                    MotivationCardView(isLoading: $isLoading)
                        .environmentObject(quitAttemptViewModel)
                        .listRowBackground(
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color.white)
                        )
                    MoneySavedCardView()
                        .frame(height: 40)
                        .environmentObject(quitAttemptViewModel)
                    AidProductsCardView()
                    SymptomsCardView()
                    ActivitiesCardView()
                }
                .foregroundStyle(Theme.indigo.mainColor)
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
                
                if showConfetti {
                    LottieView(name: Constants.confetti, animationSpeed: 0.8)
                        .ignoresSafeArea()
                        .scaleEffect(1.7)
                        .allowsHitTesting(false)
                }
                
                if isLoading {
                    LottieView(name: Constants.sparklesLoader)
                        .frame(width: 100, height: 100)
                        .allowsHitTesting(false)
                }
                
                VStack {
                    ElapsedTimeTextHeaderView()
                        .padding(.vertical, 5)
                        .background(Theme.buttercup.mainColor.opacity(0.3))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding(.horizontal, 25)
                        .padding(.top, 5)
                        .environmentObject(quitAttemptViewModel)
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    DashboardView()
        .environmentObject(QuitAttemptViewModel())
}
