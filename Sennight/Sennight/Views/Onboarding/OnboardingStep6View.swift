//
//  OnboardingStep6View.swift
//  Sennight
//
//  Created by 한유진 on 7/16/24.
//  Edited by 김소연 on 2024-07-23:
//    UI 수정
//    Next 버튼을 눌렀을 때 다음 온보딩 화면으로 넘어가지 않는 오류 수정
//

import SwiftUI

struct OnboardingStep6View: View {
    @Binding var currentStep: Int
    @Binding var isOnboardingComplete: Bool
    @State private var smokingStatus: String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        VStack {
            OnboardingDismissButton(isOnboardingComplete: $isOnboardingComplete)
            Spacer()
            Image(systemName: "leaf")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundStyle(
                    LinearGradient(
                        gradient: Gradient(colors: [Theme.bubblegum.mainColor, Theme.sky.mainColor]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .padding(.bottom, 30)
            
            HStack {
                Text("Are you currently a smoker?")
                    .font(.system(size: 24))
                    .fontWeight(.bold)
                    .foregroundStyle(
                        LinearGradient(
                            gradient: Gradient(colors: [Theme.sky.mainColor, Theme.teal.mainColor]),
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                Spacer()
            }
            .padding(.horizontal)
            
            HStack {
                Text("Please let us know if you are planning to start or continue your journey to quit smoking.")
                    .font(.subheadline)
                    .foregroundStyle(Color.secondary)
                Spacer()
            }
            .padding(.horizontal)
            .padding(.bottom, 50)
            
            Button(action: {
                currentStep = 7
            }) {
                Text("No, I'm not smoking now!")
                    .fontWeight(.semibold)
                    .padding(20)
                    .frame(maxWidth: .infinity)
                    .background(LinearGradient(
                        gradient: Gradient(colors: [Theme.teal.mainColor, Theme.sky.mainColor]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))
                    .foregroundColor(Theme.periwinkle.accentColor)
                    .cornerRadius(25)
            }
            .padding(.horizontal)
            
            Button(action: {
                currentStep = 8
            }) {
                Text("Yes, I am a smoker.")
                    .fontWeight(.semibold)
                    .padding(20)
                    .frame(maxWidth: .infinity)
                    .background(LinearGradient(
                        gradient: Gradient(colors: [Theme.poppy.mainColor, Theme.sky.mainColor]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))
                    .foregroundColor(Theme.periwinkle.accentColor)
                    .cornerRadius(25)
            }
            .padding(.horizontal)
            
            Spacer()
            
            Button(action: {
                currentStep = 5
            }) {
                Text("Previous")
                    .fontWeight(.semibold)
                    .padding(20)
                    .frame(maxWidth: .infinity)
                    .background(Theme.lightGray.mainColor)
                    .cornerRadius(25)
            }
            .padding()
        }
        .foregroundStyle(Theme.indigo.mainColor)
        .padding()
    }
}

struct OnboardingStep6View_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingStep6View(currentStep: .constant(6), isOnboardingComplete: .constant(false))
    }
}
