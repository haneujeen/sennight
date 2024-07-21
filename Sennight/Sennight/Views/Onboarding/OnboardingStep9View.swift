//
//  OnboardingStep9View.swift
//  Sennight
//
//  Created by 한유진 on 7/15/24.
//

import SwiftUI

struct OnboardingStep9View: View {
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
            
            VStack {
                Text("Please enter your email, name, and password.")
                    .font(.title)
                    .padding(.bottom, 40)
                
                TextField("Email", text: $email)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .padding(.bottom, 20)
                
                TextField("Name", text: $name)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .padding(.bottom, 20)
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .padding(.bottom, 20)
            }
            .padding(.horizontal)
            
            Button(action: {
                if email.isEmpty {
                    alertMessage = "Email can not be empty."
                    showAlert = true
                } else if name.isEmpty {
                    alertMessage = "Name can not be empty."
                    showAlert = true
                } else if password.isEmpty {
                    alertMessage = "Password can not be empty."
                    showAlert = true
                } else {
                    // Requests
                    // UserViewModel.register --> id (userId)
                    // SmokingHabitViewModel.create
                    // QuitAttemptViewModel.create
                    // MotivationViewModel.create
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

struct OnboardingStep9View_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingStep9View(currentStep: .constant(9), isOnboardingComplete: .constant(false))
    }
}
