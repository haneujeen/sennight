//
//  SignUpView.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//  Edited by 김소연 on :
//  Edited by 한유진 on 2024-07-18: Refactored SignUpView
//

import SwiftUI
import Combine

struct SignUpView: View {
    // FIXME: @StateObject var signupVM = UserViewModel()
    @StateObject var signUpViewModel = SignUpViewModel()
    @State private var confirmPassword: String = ""
    @Environment(\.dismiss) var dismiss
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    // 비밀번호와 확인 비밀번호가 같은지 확인하는 연산 프로퍼티
    private var isSignUpDisabled: Bool {
        // FIXME: userViewModel.password.isEmpty || confirmPassword.isEmpty || userViewModel.password != confirmPassword
        signUpViewModel.email.isEmpty || signUpViewModel.password.isEmpty || signUpViewModel.password != confirmPassword
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Sign Up")
                    .font(.largeTitle)
                    .padding(.bottom, 20)
                
                TextField("Email", text: $signUpViewModel.email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .textInputAutocapitalization(.never)
                
                TextField("Name", text: $signUpViewModel.name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .textInputAutocapitalization(.words)
                
                SecureField("Password", text: $signUpViewModel.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                SecureField("Confirm Password", text: $confirmPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: {
                    signUpViewModel.register { response in
                        if response.status {
                            dismiss()
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
                    Text("Sign Up")
                        .font(.title2)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(isSignUpDisabled ? Color.gray : Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                })
                .disabled(isSignUpDisabled)
                .padding()
                .alert("Error", isPresented: $showAlert, presenting: alertMessage) { _ in
                    Button("OK", role: .cancel) { }
                } message: { alertMessage in
                    Text(alertMessage)
                }
                
                Button(action: {
                    dismiss()
                }, label: {
                    Text("Already have an account? Log In")
                        .foregroundColor(.blue)
                })
                .padding(.top, 20)
            }
            .padding()
        }
    }
}


#Preview {
    SignUpView()
}
