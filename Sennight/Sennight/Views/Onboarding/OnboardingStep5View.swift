//
//  OnboardingStep5View.swift
//  Sennight
//
//  Created by 한유진 on 7/16/24.
//

import SwiftUI

struct OnboardingStep5View: View {
    @Binding var currentStep: Int
    @Binding var isOnboardingComplete: Bool
    @State private var smokingYears = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    let selectedYears = Array(0...60)
    
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
            Text("Step 4: smoking years")
                .font(.largeTitle)
                .padding(.bottom, 40)
            HStack {
                Text("Q.")
                    .font(.title2)
                    .padding(.bottom, 25)
                Text("How many years have you been smoking?")
                    .font(.title2)
                    .padding()
            }
            .padding(.horizontal)
            //TODO: 피커로 변경 필요
            Picker("", selection: $smokingYears) {
                ForEach(selectedYears, id: \.self) { selectedYears in
                    Text("\(selectedYears)")
                        .font(.title3)
                }
            }
            .pickerStyle(.wheel)
            .frame(height: 100)
            .clipped()
            .padding(.bottom, 30)
            
            Button(action: {
                if smokingYears.isEmpty {
                    alertMessage = "Please select the price."
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

struct OnboardingStep5View_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingStep5View(currentStep: .constant(5), isOnboardingComplete: .constant(false))
    }
}
