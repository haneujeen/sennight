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
    @Binding var currentStep: Int
    @Binding var isOnboardingComplete: Bool
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
                    HStack {
                        Text("Step 9: 회원가입")
                            .font(.largeTitle)
                            .padding(.bottom, 40)
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
                            // 온보딩 토큰이 UserDefaults에 저장된 상태
                            if response.status {
                                guard let token = response.data?.onboardingToken else {
                                     return
                                }
                                //1
                                smokingHabitViewModel.onboardingToken = token
                                //isOnboardingComplete = true //온보딩 완료 처리
                                smokingHabitViewModel.create { status in
                                    if status{
                                        print("smokingHabit 추가 성공")
                                    } else {
                                        print("smokingHabit 추가 실패")
                                    }
                                }
                                //2
                                quitAttemptViewModel.onboardingToken = token
                                quitAttemptViewModel.create { status in
                                    if status{
                                        print("quitAttempt 추가 성공")
                                    } else {
                                        print("quitAttempt 추가 실패")
                                    }
                                }
                                //3
                                motivationViewModel.onboardingToken = token
                                motivationViewModel.create { status in
                                    if status{
                                        print("motivation 추가 성공")
                                    } else {
                                        print("motivation 추가 실패")
                                    }
                                }
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
                        Text("시작하세요")
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

struct OnboardingStep9View_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingStep9View(currentStep: .constant(9), isOnboardingComplete: .constant(false))
    }
}
