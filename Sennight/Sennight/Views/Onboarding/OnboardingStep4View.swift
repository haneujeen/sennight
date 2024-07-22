//
//  OnboardingStep4View.swift
//  Sennight
//
//  Created by 한유진 on 7/16/24.
//

import SwiftUI

struct OnboardingStep4View: View {
    let hours = Array(0...23)
    let minutes = Array(0...59)
    @State private var selectedHour = 0
    @State private var selectedMinute = 0
    
    @Binding var currentStep: Int
    @Binding var isOnboardingComplete: Bool
    @State private var firstCigarette = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    isOnboardingComplete = true
                }) {
                    Text("Dismiss")
                        .foregroundColor(.red)
                }
                .padding()
            }
            
            Spacer()
            Text("Step 3: first Cigarette")
                .font(.largeTitle)
                .padding(.bottom, 40)
            
            HStack {
                Text("Q.")
                    .font(.title2)
                    .padding(.bottom, 25)
                Text("What time do you usually have your first cigarette of the day?")
                    .font(.title2)
                    .padding(.horizontal)
            }
            
            HStack {
                Picker(selection: $selectedHour, label: Text("Hour")) {
                    ForEach(hours, id: \.self) { hour in
                        Text(String(format: "%02d", hour))
                            .font(.title)
                            .foregroundStyle(.primary)
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
                            .foregroundStyle(.primary)
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: 100, height: 120)
                .clipped()
            }
            
            Text("Selected Time: \(String(format: "%02d", selectedHour)):\(String(format: "%02d", selectedMinute))")
                .font(.title2)
                .padding(.bottom, 30)
            
            Button(action: {
                currentStep = 5
                if firstCigarette.isEmpty {
                    alertMessage = "Please enter the price."
                    showAlert = true
                } else {
                    isOnboardingComplete = true
                }
            }) {
                Text("Next")
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
            Spacer()
        }
    }
}

struct OnboardingStep4View_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingStep4View(currentStep: .constant(4), isOnboardingComplete: .constant(false))
    }
}
