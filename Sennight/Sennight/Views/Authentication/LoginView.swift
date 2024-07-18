//
//  LoginView.swift
//  Sennight
//
//  Created by 김소연 on 7/14/24.
//  Edited by 한유진 on 2024-07-18: 코드 개선 문서 추가
//

/**
 * 코드 개선
 * 대상 파일: User.swift/UserService.swift/UserViewModel.swift/LoginView.swift/SignUpView.swift
 * 2024-07-18
 * 작성자: 한유진
 * Assignee: 김소연
 *
 * 1. LoginView의 loginVM과 SignUpView의 signupVM의 변수 명을 userViewModel로 수정하였습니다.
 * 2. LoginView와 SignUpView가 같은 UserViewModel 객체를 공유하도록 SignUpView의 state object를 environment object로 수정하였습니다. 이로 인해 발생하는 LoginView에 자동으로 비밀번호가 입력되는 현상을 해결하기 위해 SignUpView에 .onDisappear 수정자를 추가하였습니다.
 * 3. LoginView의 사용되지 않는 변수 result가 삭제되었습니다.
 * 4. 디버깅 문이 삭제되었습니다.
 * 5. LoginView와 SignUpView의 TextField에 .textInputAutocapitalization(.never) 수정자가 추가되었습니다.
 * 6. 가독성을 위한 개행문자를 추가하였습니다.
 * 7. UserViewModel의 login 함수의 .receive(on: DispatchQueue.main) 운영자 (operator)가 삭제되었습니다. Login 과정에서 UI의 변경이 발생하지 않으므로 이후의 작업이 메인 스레드에서 처리될 필요가 없습니다.
 * 8. UserViewModel의 사용되지 않는 변수 errorMessage를 삭제했습니다.
 * 9. UserViewModel의 isSignUpDisabled 연산 프로퍼티가 수정되었습니다.
 * 10. UserViewModel이 LoginViewModel, SignUpViewModel, UpdateUserViewModel로 분리되었습니다.
 *
 * 요청사항
 *
 * 1. UserViewModel와 UserService의 메서드에 대한 주석 개선
 * 2. // FIXME: 주석문 삭제
 */

import SwiftUI

struct LoginView: View {
    // FIXME: @EnvironmentObject var loginVM: UserViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    @State private var showSignUpView = false
    // FIXME: @State var result = "로그인 전"
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Login")
                    .font(.largeTitle)
                    .padding(.bottom, 20)
                
                TextField("Email", text: $userViewModel.email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.bottom)
                    .textInputAutocapitalization(.never)
                
                SecureField("Password", text: $userViewModel.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.bottom, 10)
                
                Button(action: {
                    userViewModel.login { status in
                        if status {
                            userViewModel.isLoggedIn = status
                            // FIXME: result = "로그인 성공"
                            // FIXME: print("로그인 성공!!")
                        } else {
                            // FIXME: result = "로그인 실패"
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
