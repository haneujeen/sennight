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
                Spacer()
                HStack {
                    VStack(alignment: .leading) {
                        Text("Create your account")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(Theme.indigo.mainColor)
                    }
                    Spacer()
                }
                .padding(.horizontal)
                
                VStack {
                    TextField("Email address", text: $signUpViewModel.email)
                        .textFieldStyle(CustomTextFieldStyle())
                        .textInputAutocapitalization(.never)
                    
                    TextField("Name", text: $signUpViewModel.name)
                        .textFieldStyle(CustomTextFieldStyle())
                        .textInputAutocapitalization(.words)
                    
                    SecureField("Password", text: $signUpViewModel.password)
                        .textFieldStyle(CustomTextFieldStyle())
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Your password must:")
                                .fontWeight(.semibold)
                            Spacer()
                        }
                        
                        HStack {
                            Image(systemName: "checkmark")
                                .foregroundStyle(.poppy)
                                .fontWeight(.bold)
                            Text("be 8-32 characters long")
                        }
                        
                        HStack {
                            Image(systemName: "checkmark")
                            Text("have at least 1 letter (A-Z, a-z)")
                        }
                        
                        HStack {
                            Image(systemName: "checkmark")
                            Text("have at least 1 digit (0-9)")
                        }
                        
                    }
                    .font(.footnote)
                    .foregroundColor(Theme.indigo.mainColor)
                    
                    SecureField("Confirm Password", text: $confirmPassword)
                        .textFieldStyle(CustomTextFieldStyle())
                }
                .padding()
                
                Spacer()
                
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
                    Text("Continue")
                        .fontWeight(.semibold)
                        .padding(20)
                        .frame(maxWidth: .infinity)
                        .background(isSignUpDisabled ? Color.secondary : Theme.sky.mainColor)
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
                    dismiss()
                }, label: {
                    HStack(spacing: 0) {
                        Text("Already have an account?")
                            .foregroundColor(Theme.indigo.mainColor)
                        Text(" Log In")
                            .foregroundColor(Theme.poppy.mainColor)
                            .fontWeight(.bold)
                    }
                })
                .padding(.top)
            }
            .padding()
            .background(Theme.seafoam.mainColor, ignoresSafeAreaEdges: .all)
            .onAppear {
                withAnimation(.easeIn(duration: 0.5)) {
                    
                }
            }
            .onTapGesture {
                hideKeyboard()
            }
        }
    }
}


#Preview {
    SignUpView()
}
