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
        ZStack {
            LottieView(name: Constants.buttercupCrossingLine, loopMode: .repeat(4), animationSpeed: 0.05, contentMode: .left)
                .scaleEffect(10)
                .rotationEffect(.degrees(180))
            
//            LottieView(name: <#T##String#>, loopMode: <#T##LottieLoopMode#>, animationSpeed: <#T##CGFloat#>, contentMode: <#T##UIView.ContentMode#>, play: <#T##Binding<Bool>#>)
//
            VStack {
                if currentStep == 1 {
                    OnboardingStep1View(currentStep: $currentStep, isOnboardingComplete: $isOnboardingComplete)
                } else if currentStep == 2 {
                    OnboardingStep2View(currentStep: $currentStep, isOnboardingComplete: $isOnboardingComplete)
                } else if currentStep == 3 {
                    OnboardingStep3View(currentStep: $currentStep, isOnboardingComplete: $isOnboardingComplete)
                } else if currentStep == 4 {
                    OnboardingStep3View(currentStep: $currentStep, isOnboardingComplete: $isOnboardingComplete)
                } else if currentStep == 5 {
                    OnboardingStep3View(currentStep: $currentStep, isOnboardingComplete: $isOnboardingComplete)
                } else if currentStep == 6 {
                    OnboardingStep3View(currentStep: $currentStep, isOnboardingComplete: $isOnboardingComplete)
                } else if currentStep == 7 {
                    OnboardingStep3View(currentStep: $currentStep, isOnboardingComplete: $isOnboardingComplete)
                } else if currentStep == 8 {
                    OnboardingStep3View(currentStep: $currentStep, isOnboardingComplete: $isOnboardingComplete)
                } else if currentStep == 9 {
                    OnboardingStep9View(currentStep: $currentStep, isOnboardingComplete: $isOnboardingComplete)
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
