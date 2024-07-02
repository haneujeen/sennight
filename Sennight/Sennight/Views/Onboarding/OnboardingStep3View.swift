//
//  OnboardingStep3View.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//

import SwiftUI

struct OnboardingStep3View: View {
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
            Text("Step 3: Motivation")
                .font(.largeTitle)
                .padding(.bottom, 40)
            TextField("Why do you want to stop smoking?", text: $motivation)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.bottom, 40)
            
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

struct OnboardingStep3View_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingStep3View(currentStep: .constant(3), isOnboardingComplete: .constant(false))
    }
}
