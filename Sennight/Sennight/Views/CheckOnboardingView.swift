//
//  EntryView.swift
//  Sennight
//
//  Created by 한유진 on 7/2/24.
//  Edited by 한유진 on 2024-07-19: EntryView.swift 파일 이름 변경
//

import SwiftUI

struct CheckOnboardingView: View {
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
    CheckOnboardingView()
}
