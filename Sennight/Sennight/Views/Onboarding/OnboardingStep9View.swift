//
//  OnboardingStep9View.swift
//  Sennight
//
//  Created by 한유진 on 7/15/24.
//  Edited by 김소연 on 2024-07-24: View model과 연결
//

import SwiftUI

struct OnboardingStep9View: View {
    @EnvironmentObject var motivationViewModel: MotivationViewModel
    @EnvironmentObject var quitAttemptViewModel: QuitAttemptViewModel
    @EnvironmentObject var smokingHabitViewModel: SmokingHabitViewModel
    @StateObject var signUpViewModel = SignUpViewModel()
    
    @Binding var currentStep: Int
    @Binding var isOnboardingComplete: Bool
    @State private var confirmPassword: String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    private var isSignUpDisabled: Bool {
        signUpViewModel.email.isEmpty ||
        signUpViewModel.password.isEmpty ||
        signUpViewModel.password != confirmPassword ||
        !isPasswordLengthValid ||
        !hasLetter ||
        !hasDigit
    }
    
    private var isPasswordLengthValid: Bool {
        signUpViewModel.password.count >= 8 && signUpViewModel.password.count <= 32
    }
    
    private var hasLetter: Bool {
        signUpViewModel.password.rangeOfCharacter(from: .letters) != nil
    }
    
    private var hasDigit: Bool {
        signUpViewModel.password.rangeOfCharacter(from: .decimalDigits) != nil
    }
    
    var body: some View {
        VStack {
            OnboardingDismissButton(isOnboardingComplete: $isOnboardingComplete)
            Spacer()
            HStack {
                Text("Keep track your smoking habits")
                    .font(.title)
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
                Text("monitor your progress, and stay informed about withdrawal symptoms and cessation support products.")
                    .padding(.horizontal)
                    .font(.subheadline)
                    .foregroundStyle(Color.secondary)
                Spacer()
            }
            
            VStack {
                TextField("Email address", text: $signUpViewModel.email)
                    .textFieldStyle(CustomGrayTextFieldStyle())
                    .textInputAutocapitalization(.never)
                
                TextField("Name", text: $signUpViewModel.name)
                    .textFieldStyle(CustomGrayTextFieldStyle())
                    .textInputAutocapitalization(.words)
                
                SecureField("Password", text: $signUpViewModel.password)
                    .textFieldStyle(CustomGrayTextFieldStyle())
                
                if !signUpViewModel.password.isEmpty {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Your password must:")
                                .fontWeight(.semibold)
                            Spacer()
                        }
                        
                        HStack {
                            Image(systemName: isPasswordLengthValid ? "checkmark" : "checkmark")
                                .foregroundStyle(isPasswordLengthValid ? Theme.poppy.mainColor : Theme.indigo.mainColor)
                                .fontWeight(isPasswordLengthValid ? .bold : .regular)
                            Text("be 8-32 characters long")
                        }
                        
                        HStack {
                            Image(systemName: hasLetter ? "checkmark" : "checkmark")
                                .foregroundStyle(hasLetter ? Theme.poppy.mainColor : Theme.indigo.mainColor)
                                .fontWeight(hasLetter ? .bold : .regular)
                            Text("have at least 1 letter (A-Z, a-z)")
                        }
                        
                        HStack {
                            Image(systemName: hasDigit ? "checkmark" : "checkmark")
                                .foregroundStyle(hasDigit ? Theme.poppy.mainColor : Theme.indigo.mainColor)
                                .fontWeight(hasDigit ? .bold : .regular)
                            Text("have at least 1 digit (0-9)")
                        }
                    }
                    .font(.footnote)
                }
                SecureField("Confirm Password", text: $confirmPassword)
                    .textFieldStyle(CustomGrayTextFieldStyle())
            }
            .padding()
            
            Spacer()
            
            Button(action: {
                signUpViewModel.register { response in
                    if response.status {
                        isOnboardingComplete = true
                        smokingHabitViewModel.createSmokingHabit { _ in
                            
                        }
                        
                        quitAttemptViewModel.createQuitAttempt { _ in
                            
                        }
                        
                        motivationViewModel.createMotivation { _ in
                            
                        }
                    } else {
                        if response.detail == "Email in use" {
                            alertMessage = "Email in use"
                        } else {
                            alertMessage = "An unknown error occurred."
                        }
                        showAlert = true
                    }
                }
            }, label: {
                Text("Get started")
                    .fontWeight(.semibold)
                    .padding(20)
                    .frame(maxWidth: .infinity)
                    .background(isSignUpDisabled ?
                                LinearGradient(gradient: Gradient(colors: [Color.secondary]), startPoint: .leading, endPoint: .trailing) :
                                    LinearGradient(
                                        gradient: Gradient(colors: [Theme.teal.mainColor, Theme.sky.mainColor]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    ))
                    .foregroundColor(Theme.sky.accentColor)
                    .cornerRadius(25)
            })
            .disabled(isSignUpDisabled)
            .alert("Error", isPresented: $showAlert, presenting: alertMessage) { _ in
                Button("OK", role: .cancel) { }
            } message: { alertMessage in
                Text(alertMessage)
            }
            .padding(.horizontal)
            
            Button(action: {
                currentStep = 8
            }) {
                Text("Previous")
                    .fontWeight(.semibold)
                    .padding(20)
                    .frame(maxWidth: .infinity)
                    .background(Theme.lightGray.mainColor)
                    .cornerRadius(25)
            }
            .padding([.horizontal, .bottom])
        }
        .onTapGesture {
            hideKeyboard()
        }
        .foregroundStyle(Theme.indigo.mainColor)
        .padding()
    }
}

struct OnboardingStep9View_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingStep9View(currentStep: .constant(9), isOnboardingComplete: .constant(false))
    }
}
