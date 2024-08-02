//
//  OnboardingStep4View.swift
//  Sennight
//
//  Created by 한유진 on 7/16/24.
//

import SwiftUI

struct OnboardingStep4View: View {
    @EnvironmentObject var smokingHabitViewModel: SmokingHabitViewModel
    let hours = Array(0...23)
    let minutes = Array(0...59)
    @State private var selectedHour = 11
    @State private var selectedMinute = 0
    
    @Binding var currentStep: Int
    @Binding var isOnboardingComplete: Bool
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        VStack {
            OnboardingDismissButton(isOnboardingComplete: $isOnboardingComplete)
            Spacer()
            Image(systemName: "clock.badge.questionmark")
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
                Text("What time")
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
                Text("do you usually have your first cigarette of the day?")
                    .padding(.horizontal)
                    .fontWeight(.semibold)
                Spacer()
            }
            
            HStack {
                Text("Right after you wake up or later in the morning?")
                    .padding(.horizontal)
                    .font(.subheadline)
                    .foregroundStyle(Color.secondary)
                Spacer()
            }
            
            HStack {
                Picker(selection: $selectedHour, label: Text("Hour")) {
                    ForEach(hours, id: \.self) { hour in
                        Text(String(format: "%02d", hour))
                            .font(.title)
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: 100, height: 120)
                .clipped()
                
                Text(":")
                    .font(.title)
                
                Picker(selection: $selectedMinute, label: Text("Minute")) {
                    ForEach(minutes, id: \.self) { minute in
                        Text(String(format: "%02d", minute))
                            .font(.title)
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: 100, height: 120)
                .clipped()
                .padding(.vertical, 30)
            }
            
            Spacer()
            
            Button(action: {
                let selectedTime = String(format: "%02d:%02d:00", selectedHour, selectedMinute)
                smokingHabitViewModel.firstCigarette = selectedTime
                currentStep = 5
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
                currentStep = 3
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

struct OnboardingStep4View_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingStep4View(currentStep: .constant(4), isOnboardingComplete: .constant(false))
            .environmentObject(SmokingHabitViewModel())
    }
}
