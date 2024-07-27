//
//  HealthProgressCardView.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//  Edited by 한유진 on 2024-07-26
//

import SwiftUI

struct HealthProgressCardView: View {
    @EnvironmentObject var quitAttemptViewModel: QuitAttemptViewModel
    @State private var selection = 0
    @State private var initialSnap = 0
    private let cacheKey = "initialSnap"
    
    private var startDate: Date {
        dateFormatter.date(from: quitAttemptViewModel.activeQuitAttempt?.startDate ?? "") ?? Date()
    }
    
    var body: some View {
        Section {
            VStack {
                TabView(selection: $selection) {
                    ForEach(HealthBenefit.allCases.indices, id: \.self) { index in
                        CircularGaugeView(healthBenefit: HealthBenefit.allCases[index])
                            .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .onAppear {
                    /// Cache the initial tab index based on elapsed time
                    let elapsedTime = Date().timeIntervalSince(startDate)
                    if let snappedBenefit = HealthBenefit.allCases.firstIndex(where: { $0.timeInterval > elapsedTime }) {
                        UserDefaults.standard.set(snappedBenefit, forKey: cacheKey)
                    }
                    
                    /// Get the cached index
                    if let cachedSnap = UserDefaults.standard.value(forKey: cacheKey) as? Int {
                        initialSnap = cachedSnap
                    }
                    
                    /// Update tab index
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        selection = initialSnap
                    }
                }
            }
        }
    }
}

#Preview {
    HealthProgressCardView()
        .environmentObject(QuitAttemptViewModel())
        .frame(height: 300)
        .background(Theme.lightGray.mainColor)
}
