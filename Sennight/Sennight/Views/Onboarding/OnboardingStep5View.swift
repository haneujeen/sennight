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
                Text("Get Started")
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
