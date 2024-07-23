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
    @State private var onboardingData: [String: Any] = [:]
    
    var body: some View {
        ZStack {
            LottieView(name: Constants.buttercupCrossingLine, loopMode: .repeat(4), animationSpeed: 1, contentMode: .bottom)
            VStack {
                if currentStep == 1 {
                    OnboardingStep1View(currentStep: $currentStep, isOnboardingComplete: $isOnboardingComplete)
                        .transition(.blurReplace)
                } else if currentStep == 2 {
                    OnboardingStep2View(currentStep: $currentStep, isOnboardingComplete: $isOnboardingComplete, onboardingData: $onboardingData)
                } else if currentStep == 3 {
                    OnboardingStep3View(currentStep: $currentStep, isOnboardingComplete: $isOnboardingComplete, onboardingData: $onboardingData)
                } else if currentStep == 4 {
                    OnboardingStep4View(currentStep: $currentStep, isOnboardingComplete: $isOnboardingComplete, onboardingData: $onboardingData)
                } else if currentStep == 5 {
                    OnboardingStep5View(currentStep: $currentStep, isOnboardingComplete: $isOnboardingComplete, onboardingData: $onboardingData)
                } else if currentStep == 6 {
                    OnboardingStep6View(currentStep: $currentStep, isOnboardingComplete: $isOnboardingComplete, onboardingData: $onboardingData)
                } else if currentStep == 7 {
                    OnboardingStep7View(currentStep: $currentStep, isOnboardingComplete: $isOnboardingComplete, onboardingData: $onboardingData)
                } else if currentStep == 8 {
                    OnboardingStep8View(currentStep: $currentStep, isOnboardingComplete: $isOnboardingComplete, onboardingData: $onboardingData)
                } else if currentStep == 9 {
                    OnboardingStep9View(currentStep: $currentStep, isOnboardingComplete: $isOnboardingComplete, onboardingData: $onboardingData)
                }
                Spacer()
                
                HStack {
                    ForEach(1...9, id: \.self) { index in
                        Circle()
                            .fill(index == currentStep ? Theme.indigo.mainColor : .lightGray)
                            .frame(width: 10, height: 10)
                    }
                }
                .padding(.bottom, 20)
            }
            .animation(.easeInOut, value: currentStep)
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(isOnboardingComplete: .constant(false))
    }
}
