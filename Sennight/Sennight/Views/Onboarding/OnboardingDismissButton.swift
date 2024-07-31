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
                alertMessage = "You’re about to exit the onboarding. Don’t worry, you can set up your preferences later."
            }) {
                Text("Dismiss")
                    .foregroundStyle(Color.secondary)
            }
            .padding(.vertical)
            .padding(.horizontal)
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text(""),
                    message: Text(alertMessage),
                    primaryButton: .destructive(Text("Yes")) {
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
