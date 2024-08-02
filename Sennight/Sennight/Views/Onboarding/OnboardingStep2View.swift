//
//  OnboardingStep2View.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//  Edited by 김소연 on 2024-07-22: 온보딩 스텝 2 UI 수정
//  Edited by 김소연 on 2024-07-24: selectedNum을 SmokingHabitViewModel의 dailyCigarettes에 저장
//  Edited by 한유진 on 2024-07-31: 온보딩 스크린의 UI 수정
//

import SwiftUI

struct OnboardingStep2View: View {
    @EnvironmentObject var smokingHabitViewModel: SmokingHabitViewModel
    @Binding var currentStep: Int
    @Binding var isOnboardingComplete: Bool
    
    let dailyCigarettesRange = Array(0...60)
    @State private var dailyCigarettes = 10
    
    var body: some View {
        VStack {
            OnboardingDismissButton(isOnboardingComplete: $isOnboardingComplete)
            Spacer()
            Image(systemName: "smoke")
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
            
            HStack {
                Text("Let us know")
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
                Text("the number of cigarettes you smoke daily.")
                    .padding(.leading)
                    .fontWeight(.semibold)
                Spacer()
            }
            
            HStack {
                Text("If you’re currently smoke-free, add the number of cigarettes you used to smoke daily. This will help calculate your savings.")
                    .padding(.horizontal)
                    .font(.subheadline)
                    .foregroundStyle(Color.secondary)
                Spacer()
            }
            
            Picker("", selection: $dailyCigarettes) {
                ForEach(dailyCigarettesRange, id: \.self) { count in
                    Text("\(count)")
                        .font(.headline)
                }
            }
            .pickerStyle(.wheel)
            .frame(height: 150)
            .clipped()
            .padding(.horizontal, 50)
            .padding(.vertical, 30)
            
            Button(action: {
                smokingHabitViewModel.dailyCigarettes = dailyCigarettes
                currentStep = 3
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
                currentStep = 1
            }) {
                Text("Previous")
                    .fontWeight(.semibold)
                    .padding(20)
                    .frame(maxWidth: .infinity)
                    .background(Theme.lightGray.mainColor)
                    .cornerRadius(25)
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .foregroundStyle(Theme.indigo.mainColor)
        .padding()
    }
}

struct OnboardingStep2View_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingStep2View(currentStep: .constant(2), isOnboardingComplete: .constant(false))
            .environmentObject(SmokingHabitViewModel())
    }
}
