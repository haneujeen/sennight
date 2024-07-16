//
//  SignUpView.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//

import SwiftUI
import Combine

struct SignUpView: View {
    @StateObject var signupVM = UserViewModel()
    @State private var confirmPassword = ""
    @Environment(\.dismiss) var dismiss
    
    // 비밀번호와 확인 비밀번호가 같은지 확인하는 연산 프로퍼티
    private var isSignUpDisabled: Bool {
        signupVM.password.isEmpty || confirmPassword.isEmpty || signupVM.password != confirmPassword
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Sign Up")
                    .font(.largeTitle)
                    .padding(.bottom, 20)
                
                TextField("Name", text: $signupVM.name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextField("Email", text: $signupVM.email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                SecureField("Password", text: $signupVM.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                SecureField("Confirm Password", text: $confirmPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: {
                    signupVM.register { status in
                        if status {
                            dismiss()
                        } else {
                            // 등록 실패 시 처리 로직 추가
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
