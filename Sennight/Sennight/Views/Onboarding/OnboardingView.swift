//
//  OnboardingView.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//

import SwiftUI

struct OnboardingView: View {
    @Binding var isOnboardingComplete: Bool
    @State private var currentStep = 1

    var body: some View {
        VStack {
            if currentStep == 1 {
                OnboardingStep1View(currentStep: $currentStep, isOnboardingComplete: $isOnboardingComplete)
            } else if currentStep == 2 {
                OnboardingStep2View(currentStep: $currentStep, isOnboardingComplete: $isOnboardingComplete)
            } else if currentStep == 3 {
                OnboardingStep3View(currentStep: $currentStep, isOnboardingComplete: $isOnboardingComplete)
            }
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(isOnboardingComplete: .constant(false))
    }
}
