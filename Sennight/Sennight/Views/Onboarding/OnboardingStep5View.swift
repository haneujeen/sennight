//
//  OnboardingStep5View.swift
//  Sennight
//
//  Created by 한유진 on 7/16/24.
//  Edited by 김소연 on 2024-07-23: 
//    UI수정
//    다음 화면으로 넘어가지 않는 오류 수정
//

import SwiftUI

struct OnboardingStep5View: View {
    @EnvironmentObject var smokingHabitViewModel: SmokingHabitViewModel
    @Binding var currentStep: Int
    @Binding var isOnboardingComplete: Bool
    @State private var smokingYears = 7
    @State private var showAlert = false
    @State private var alertMessage = ""
    let selectedYears = Array(1...60)
    
    var body: some View {
        VStack {
            
            OnboardingDismissButton(isOnboardingComplete: $isOnboardingComplete)
            
            Image(systemName: "figure.wave")
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
                .padding()
            
            HStack {
                Text("How many years")
                    .font(.largeTitle)
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
                Text("have you been smoking?")
                    .padding(.horizontal)
                    .fontWeight(.semibold)
                Spacer()
            }
            
            HStack {
                Text("Regardless of how long you've been a smoker, it’s never too late to improve your health.")
                    .padding(.horizontal)
                    .font(.subheadline)
                    .foregroundStyle(Color.secondary)
                Spacer()
            }
            .padding(.top, 5)
       
            Picker("", selection: $smokingYears) {
                ForEach(selectedYears, id: \.self) { selectedYears in
                    Text("\(selectedYears)")
                        .font(.headline)
                }
            }
            .pickerStyle(.wheel)
            .frame(height: 130)
            .clipped()
            .padding(.horizontal, 50)
            .padding(.vertical, 30)
            
            Button(action: {
                smokingHabitViewModel.smokingYears = smokingYears
                currentStep = 6
            }) {
                Text("Next")
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
                currentStep = 4
            }) {
                Text("Previous")
                    .fontWeight(.semibold)
                    .padding(20)
                    .frame(maxWidth: .infinity)
                    .background(Theme.lightGray.mainColor)
                    .cornerRadius(25)
            }
            .padding(.horizontal)
            Spacer()
        }
        .foregroundStyle(Theme.indigo.mainColor)
        .padding()
    }
}

struct OnboardingStep5View_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingStep5View(currentStep: .constant(5), isOnboardingComplete: .constant(false))
            .environmentObject(SmokingHabitViewModel())
    }
}
