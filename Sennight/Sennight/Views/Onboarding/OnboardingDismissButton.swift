//
//  OnboardingDismissButton.swift
//  Sennight
//
//  Created by 한유진 on 7/31/24.
//

import SwiftUI

struct OnboardingDismissButton: View {
    @Binding var isOnboardingComplete: Bool
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        HStack {
            Button(action: {
                showAlert = true
                alertMessage = "You can update your preferences and settings later."
            }) {
                Text("Dismiss")
                    .foregroundStyle(Color.secondary)
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Leaving onboarding?"),
                    message: Text(alertMessage),
                    primaryButton: .destructive(Text("OK")) {
                        isOnboardingComplete = true
                    },
                    secondaryButton: .cancel()
                )
            }
            Spacer()
        }
    }
}

#Preview {
    OnboardingDismissButton(isOnboardingComplete: .constant(false))
}
