//
//  EntryView.swift
//  Sennight
//
//  Created by 한유진 on 7/2/24.
//

import SwiftUI

struct EntryView: View {
    @AppStorage("isOnboardingComplete") private var isOnboardingComplete: Bool = false
    var loginViewModel = LoginViewModel()
    
    var body: some View {
        if isOnboardingComplete {
            if loginViewModel.isLoggedIn {
                HomeView()
            } else {
                LoginView()
                    .environmentObject(loginViewModel)
            }
        } else {
            OnboardingView(isOnboardingComplete: $isOnboardingComplete)
                .padding()
        }
    }
}

#Preview {
    EntryView()
}
