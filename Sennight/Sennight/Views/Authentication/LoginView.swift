//
//  LoginView.swift
//  Sennight
//
//  Created by 김소연 on 7/14/24.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var loginVM: UserViewModel
    @State private var showSignUpView = false
    @State var result = "로그인 전"
    var body: some View {
        NavigationStack {
            VStack {
                Text("Login")
                    .font(.largeTitle)
                    .padding(.bottom, 20)

                TextField("Email", text: $loginVM.email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.bottom)
                SecureField("Password", text: $loginVM.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.bottom, 10)

                Button(action: {
                    loginVM.login { success in
                        if success {
                            loginVM.isLoggedIn = true
                            result = "로그인 성공"
                            print("로그인 성공!!")
                        } else {
                            result = "로그인 실패"
                        }
                    }
                }) {
                    Text("Login")
                        .font(.title2)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()

                Button(action: {
                    showSignUpView = true
                }) {
                    Text("Don't have an account? Sign Up")
                        .foregroundColor(.blue)
                }
                .padding(.top, 20)
            }
            .padding()
            .sheet(isPresented: $showSignUpView) {
                SignUpView()
        }
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(UserViewModel())
}
