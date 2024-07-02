//
//  EntryView.swift
//  Sennight
//
//  Created by 한유진 on 7/2/24.
//

import SwiftUI

struct EntryView: View {
    @AppStorage("isOnboardingComplete") private var isOnboardingComplete: Bool = false
    @EnvironmentObject var userViewModel: UserViewModel
    
    var body: some View {
        if isOnboardingComplete {
            if userViewModel.isLoggedIn {
                HomeView()
            } else {
                LoginView()
            }
        } else {
            OnboardingView(isOnboardingComplete: $isOnboardingComplete)
                .padding()
        }
    }
}

#Preview {
    EntryView()
        .environmentObject(UserViewModel())
}
