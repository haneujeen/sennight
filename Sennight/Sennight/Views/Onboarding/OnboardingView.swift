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
    var smokingHabitViewModel = SmokingHabitViewModel()
    var quitAttemptViewModel = QuitAttemptViewModel()
    var motivationViewModel = MotivationViewModel()
    
    var body: some View {
        ZStack {
            LottieView(name: Constants.seafoamCrossingLine, loopMode: .autoReverse, animationSpeed: 0.03, contentMode: .left)
                .scaleEffect(10)
                .rotationEffect(.degrees(100))
                .opacity(0.8)
            
            VStack {
                if currentStep == 1 {
                    OnboardingStep1View(currentStep: $currentStep)
                } else if currentStep == 2 {
                    OnboardingStep2View(currentStep: $currentStep, isOnboardingComplete: $isOnboardingComplete)
                        .environmentObject(smokingHabitViewModel)
                } else if currentStep == 3 {
                    OnboardingStep3View(currentStep: $currentStep, isOnboardingComplete: $isOnboardingComplete)
                        .environmentObject(smokingHabitViewModel)
                } else if currentStep == 4 {
                    OnboardingStep4View(currentStep: $currentStep, isOnboardingComplete: $isOnboardingComplete)
                        .environmentObject(smokingHabitViewModel)
                } else if currentStep == 5 {
                    OnboardingStep5View(currentStep: $currentStep, isOnboardingComplete: $isOnboardingComplete)
                        .environmentObject(smokingHabitViewModel)
                } else if currentStep == 6 {
                    OnboardingStep6View(currentStep: $currentStep, isOnboardingComplete: $isOnboardingComplete)
                } else if currentStep == 7 {
                    OnboardingStep7View(currentStep: $currentStep, isOnboardingComplete: $isOnboardingComplete)
                        .environmentObject(quitAttemptViewModel)
                } else if currentStep == 8 {
                    OnboardingStep8View(currentStep: $currentStep, isOnboardingComplete: $isOnboardingComplete)
                        .environmentObject(motivationViewModel)
                } else if currentStep == 9 {
                    OnboardingStep9View(currentStep: $currentStep, isOnboardingComplete: $isOnboardingComplete)
                        .environmentObject(smokingHabitViewModel)
                        .environmentObject(motivationViewModel)
                        .environmentObject(quitAttemptViewModel)
                }
                Spacer()
                
                HStack {
                    ForEach(1...9, id: \.self) { index in
                        Circle()
                            .fill(index == currentStep ? Color.blue : Theme.lightGray.mainColor)
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
