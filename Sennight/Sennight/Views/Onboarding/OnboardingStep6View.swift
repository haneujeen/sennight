//
//  OnboardingStep6View.swift
//  Sennight
//
//  Created by 한유진 on 7/16/24.
//

import SwiftUI

import SwiftUI

struct OnboardingStep6View: View {
    @Binding var currentStep: Int
    @Binding var isOnboardingComplete: Bool
    @State private var motivation = ""
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
            Text("Step 5: Smoking status")
                .font(.largeTitle)
                .padding(.bottom, 40)
            HStack {
                Text("Q.")
                    .font(.title2)
                Text("Are you currently a smoker?")
                    .font(.title2)
                    .padding()
            }
            .padding(.horizontal)
            TextField("입력해주세요", text: $motivation)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.bottom, 40)
                .padding(.horizontal)
            
            Button(action: {
                if motivation.isEmpty {
                    alertMessage = "Please select your motivation."
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

struct OnboardingStep6View_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingStep6View(currentStep: .constant(6), isOnboardingComplete: .constant(false))
    }
}
