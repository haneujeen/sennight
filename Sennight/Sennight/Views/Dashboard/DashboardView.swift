//
//  DashboardView.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
        NavigationStack {
            List {
                DashboardHeaderView()
                    .frame(height: 60)
                HealthProgressCardView()
                    .frame(height: 300)
                MotivationCardView()
                    .frame(height: 40)
                MoneySavedCardView()
                    .frame(height: 40)
                AidProductsCardView()
                SymptomsCardView()
                ActivitiesCardView()
            }
        }
        
    }
}

#Preview {
    DashboardView()
}
