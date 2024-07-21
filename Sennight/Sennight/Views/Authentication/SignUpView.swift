//
//  SignUpView.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//  Edited by 김소연 on :
//  Edited by 한유진 on 2024-07-18: Refactored SignUpView
//  Edited by 한유진 on 2024-07-18: UI 수정과 비밀번호 조건 메시지 추가
//  Edited by 김소연 on 2024-07-21: FIXME 주석문 삭제하고 들여쓰기 수정
//

import SwiftUI
import Combine

struct SignUpView: View {
    @StateObject var signUpViewModel = SignUpViewModel()
    @State private var confirmPassword: String = ""
    @Environment(\.dismiss) var dismiss
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    // 비밀번호와 확인 비밀번호가 같은지 확인하는 연산 프로퍼티
    private var isSignUpDisabled: Bool {
        signUpViewModel.email.isEmpty ||
        signUpViewModel.password.isEmpty ||
        signUpViewModel.password != confirmPassword ||
        !isPasswordLengthValid ||
        !hasLetter ||
        !hasDigit
    }
    
    // 비밀번호 길이 확인하는 연산 프로퍼티
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
        NavigationStack {
            ZStack {
                LottieView(name: Constants.lavenderCrossingLine, loopMode: .autoReverse, animationSpeed: 0.2)
                    .rotationEffect(.degrees(290))
                    .scaleEffect(2.5)
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Create your account.")
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
                            .foregroundColor(Theme.indigo.mainColor)
                        }
                        
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
                    })
                    .padding(20)
                    .frame(maxWidth: .infinity)
                    .background(isSignUpDisabled ? Color.secondary : Theme.sky.mainColor)
                    .foregroundColor(Theme.sky.accentColor)
                    .cornerRadius(25)
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
                .onTapGesture {
                    hideKeyboard()
                }
            }
            .background(Theme.seafoam.mainColor, ignoresSafeAreaEdges: .all)
        }
    }
}


#Preview {
    SignUpView()
}
