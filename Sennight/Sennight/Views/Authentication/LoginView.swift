//
//  LoginView.swift
//  Sennight
//
//  Created by 김소연 on 7/14/24.
//  Edited by 한유진 on 2024-07-18: 코드 개선 문서 추가
//  Edited by 한유진 on 2024-07-20: Updated UI
//  Edited by 한유진 on 2024-08-02: Sign in with Apple 기능 추가, UI 수정
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
    @StateObject var signUpViewModel = SignUpViewModel()
    @StateObject var signInWithAppleViewModel = SignInWithAppleViewModel()
    @StateObject var updateUserViewModel = UpdateUserViewModel()
    
    @State private var showSignUpView = false
    @State private var showTermsView = false
    @State private var showPrivacyPolicyView = false
    @State private var isWelcoming = false
    @State private var isLoading = false
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var alertType: AlertType? = nil
    
    enum AlertType {
        case linkAccount
        case signUp
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                LottieView(name: Constants.yellowCrossingLine, loopMode: .autoReverse, animationSpeed: 0.1)
                    .rotationEffect(.degrees(70))
                    .scaleEffect(5)
                    .ignoresSafeArea()
                
                // MARK: VStack
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
                        .disableAutocorrection(true)
                    
                    SecureField("Password", text: $loginViewModel.password)
                        .textFieldStyle(CustomTextFieldStyle())
                        .padding(.horizontal)
                    
                    // TODO: isLoginDisabled 변수 추가...
                    Button(action: {
                        isLoading = true
                        loginViewModel.login { status in
                            if status {
                                isLoading = false
                                if signInWithAppleViewModel.userIdentifier != nil {
                                    alertMessage = "Do you want to link your account with Apple?"
                                    alertType = .linkAccount
                                    showAlert = true
                                } else {
                                    loginViewModel.isLoggedIn = true
                                }
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
                        Task {
                            await signInWithAppleViewModel.startSignInWithAppleFlow()
                            let isUserWithAppleID = await signInWithAppleViewModel.sendAppleUserIdentifier()
                            if isUserWithAppleID {
                                loginViewModel.isLoggedIn = true
                            } else {
                                signUpViewModel.email = signInWithAppleViewModel.userEmail
                                signUpViewModel.name = signInWithAppleViewModel.userName
                                signUpViewModel.appleID = signInWithAppleViewModel.userIdentifier
                                alertMessage = "Sign up or log in with your Sennight account.\nYou only need to do this once."
                                alertType = .signUp
                                showAlert = true
                            }
                        }
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
                                    showTermsView = true
                                }
                            Text(" and ")
                            Text("Privacy Policy")
                                .foregroundColor(Theme.teal.mainColor)
                                .underline()
                                .onTapGesture {
                                    showPrivacyPolicyView = true
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
                        .environmentObject(signUpViewModel)
                }
                .sheet(isPresented: $showTermsView) {
                    NavigationStack {
                        TermsAndConditionsView()
                            .navigationTitle("Terms & Conditions")
                            .toolbar {
                                ToolbarItem(placement: .cancellationAction) {
                                    Button("Close") {
                                        showTermsView = false
                                    }
                                }
                            }
                    }
                }
                .sheet(isPresented: $showPrivacyPolicyView) {
                    NavigationStack {
                        PrivacyPolicyView()
                            .navigationTitle("Privacy Policy")
                            .toolbar {
                                ToolbarItem(placement: .cancellationAction) {
                                    Button("Close") {
                                        showPrivacyPolicyView = false
                                    }
                                }
                            }
                    }
                }
                .alert(isPresented: $showAlert) {
                    switch alertType {
                    case .linkAccount:
                        return Alert(
                            title: Text("You're Logging In..."),
                            message: Text(alertMessage),
                            primaryButton: .default(Text("Yes")) {
                                updateUserViewModel.appleID = signInWithAppleViewModel.userIdentifier
                                updateUserViewModel.updateWithAppleID { _ in }
                                loginViewModel.isLoggedIn = true
                            },
                            secondaryButton: .cancel(Text("Not Now")) {
                                loginViewModel.isLoggedIn = true
                            }
                        )
                    case .signUp:
                        return Alert(
                            title: Text("No Account Linked"),
                            message: Text(alertMessage),
                            dismissButton: .default(Text("OK")) {
                                showSignUpView = true
                            }
                        )
                    case .none:
                        return Alert(
                            title: Text("Error"),
                            message: Text("An unknown error occurred."),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                }
                // MARK: VStack
                
                if isLoading {
                    LottieView(name: Constants.sparklesLoader)
                        .frame(width: 100, height: 100)
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
