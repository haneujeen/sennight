//
//  UserViewModel.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//  Edited by 김소연 on :
//  Edited by 한유진 on 2024-07-18: Refactored UserViewModel
//  Edited by 한유진 on 2024-07-18: Separated view models (to follow single responsibility principle)
//

import Foundation
import SwiftUI
import Combine

class SignUpViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var name: String = ""
    @Published var password: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    //회원가입
    func register(completionHandler: @escaping (UserResponse) -> Void) {
        UserService.shared.register(email: email, name: name, password: password)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { response in
                completionHandler(response)
                if response.status {
                    // 응답 상태가 성공인 경우
                    UserService.shared.saveToken(token: response.data!.onboardingToken!, userID: response.data!.id!)
                }
            }
            .store(in: &cancellables)
    }
}
