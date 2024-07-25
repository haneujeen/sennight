//
//  LoginView.swift
//  Sennight
//
//  Created by 김소연 on 7/14/24.
//  Edited by 한유진 on 2024-07-18: 코드 개선 문서 추가
//  Edited by 한유진 on 2024-07-20: Updated UI
//

/**
 * 코드 개선
 * 대상 파일: User.swift/UserService.swift/UserViewModel.swift/LoginView.swift/SignUpView.swift
 * 2024-07-18
 * 작성자: 한유진
 * Assignee: 김소연
 *
 * 1. UserViewModel이 LoginViewModel, SignUpViewModel, UpdateUserViewModel로 분리되었습니다.
 * 2. LoginView의 userViewModel 변수명을 loginViewModel로 수정하였습니다.
 * 3. signUpView의 userViewModel 변수명을 signUpViewModel로 수정하였습니다.
 * 4. LoginView의 사용되지 않는 변수 result가 삭제되었습니다.
 * 5. LoginView와 SignUpView의 TextField에 .textInputAutocapitalization(.never) 수정자가 추가되었습니다.
 * 6. 가독성을 위한 개행문자를 추가하였습니다.
 * 7. UserViewModel의 login 함수의 .receive(on: DispatchQueue.main) 운영자 (operator)가 삭제되었습니다. Login 과정에서 UI의 변경이 발생하지 않으므로 이후의 작업이 메인 스레드에서 처리될 필요가 없습니다.
 * 8. UserViewModel의 사용되지 않는 변수 errorMessage를 삭제했습니다.
 * 9. UserViewModel의 isSignUpDisabled 연산 프로퍼티가 수정되었습니다.
 * 10. 디버깅 문이 삭제되었습니다.
 *
 * 요청사항
 *
 * 1. UserViewModel와 UserService의 메서드에 대한 주석 개선
 * 2. // FIXME: 주석문 삭제
 */

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var loginViewModel: LoginViewModel
    @State private var showSignUpView = false
    @State private var isWelcoming = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                LottieView(name: Constants.yellowCrossingLine, loopMode: .autoReverse, animationSpeed: 0.2)
                    .rotationEffect(.degrees(60))
                    .scaleEffect(2.5)
                    .ignoresSafeArea()
                    
                VStack {
                    Spacer()
                    if !isWelcoming {
                        Text("Welcome back")
                            .foregroundStyle(Color.clear)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.bottom, 20)
                    }
                    
                    if isWelcoming {
                        Text("Welcome back")
                            .foregroundStyle(Theme.teal.mainColor)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding(.bottom, 20)
                            .transition(.blurReplace)
                    }
                    
                    TextField("Email address", text: $loginViewModel.email)
                        .textFieldStyle(CustomTextFieldStyle())
                        .padding(.horizontal)
                        .textInputAutocapitalization(.never)
                    
                    SecureField("Password", text: $loginViewModel.password)
                        .textFieldStyle(CustomTextFieldStyle())
                        .padding(.horizontal)
                    
                    // TODO: isLoginDisabled 변수 추가...
                    Button(action: {
                        loginViewModel.login { status in
                            if status {
                                loginViewModel.isLoggedIn = status
                            } else {
                            }
                        }
                    }) {
                        Text("Continue")
                            .fontWeight(.semibold)
                            .padding(20)
                            .frame(maxWidth: .infinity)
                            .background(Theme.indigo.mainColor)
                            .foregroundColor(Theme.indigo.accentColor)
                            .cornerRadius(25)
                    }
                    .padding([.horizontal, .top])
                    
                    Button(action: {
                        // TODO: Apple sign-in
                    }) {
                        HStack {
                            Image(systemName: "applelogo")
                            Text("Continue with Apple")
                                .fontWeight(.semibold)
                        }
                        .padding(20)
                        .frame(maxWidth: .infinity)
                        .background(Theme.poppy.mainColor)
                        .foregroundColor(Theme.poppy.accentColor)
                        .cornerRadius(25)
                    }
                    .padding(.horizontal)
                    
                    Button(action: {
                        showSignUpView = true
                    }) {
                        HStack(spacing: 0) {
                            Text("Don't have an account?")
                                .foregroundColor(Theme.indigo.mainColor)
                            Text(" Sign Up")
                                .foregroundColor(Theme.teal.mainColor)
                                .fontWeight(.bold)
                        }
                    }
                    .padding(.top, 15)
                    
                    Spacer()
                    
                    VStack {
                        Text("If you are creating a new account,")
                        
                        HStack(spacing: 0) {
                            Text("Terms & Conditions")
                                .foregroundColor(Theme.teal.mainColor)
                                .underline()
                                .onTapGesture {
                                    if let url = URL(string: "https://www.example.com/terms") {
                                        UIApplication.shared.open(url)
                                    }
                                }
                            Text(" and ")
                            Text("Privacy Policy")
                                .foregroundColor(Theme.teal.mainColor)
                                .underline()
                                .onTapGesture {
                                    if let url = URL(string: "https://www.example.com/privacy") {
                                        UIApplication.shared.open(url)
                                    }
                                }
                            Text(" will apply.")
                        }
                        
                    }
                    .font(.footnote)
                    .foregroundColor(Color.secondary)
                }
                .padding()
                .onAppear {
                    withAnimation(.easeIn(duration: 0.5)) {
                        isWelcoming = true
                    }
                }
                .onTapGesture {
                    hideKeyboard()
                }
                .sheet(isPresented: $showSignUpView) {
                    SignUpView()
                }
            }
            .background(Theme.buttercup.mainColor, ignoresSafeAreaEdges: .all)
            
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(LoginViewModel())
}
