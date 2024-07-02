//
//  OnboardingStep1View.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//

import SwiftUI

struct OnboardingStep1View: View {
    @Binding var currentStep: Int
    @Binding var isOnboardingComplete: Bool
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
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
            Text("Step 1: Registration")
                .font(.largeTitle)
                .padding(.bottom, 40)
            TextField("Name", text: $name)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.bottom, 20)
            
            TextField("Email", text: $email)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.bottom, 20)
            
            SecureField("Password", text: $password)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.bottom, 20)
            
            Button(action: {
                if name.isEmpty {
                    alertMessage = "Name can not be empty."
                    showAlert = true
                } else if email.isEmpty {
                    alertMessage = "Email can not be empty."
                    showAlert = true
                } else if password.isEmpty {
                    alertMessage = "Password can not be empty."
                    showAlert = true
                } else {
                    currentStep = 2
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

struct OnboardingStep1View_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingStep1View(currentStep: .constant(1), isOnboardingComplete: .constant(false))
    }
}
