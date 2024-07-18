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

class LoginViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var email: String = ""
    @Published var password: String = ""
    // FIXME: @Published var errorMessage: String? = nil
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        isLoggedIn = UserService.shared.isLoggedIn()
    }
    
    //로그아웃
    func logout() {
        UserService.shared.logout()
        isLoggedIn = UserService.shared.isLoggedIn()
    }
    
    //로그인
    func login(completion: @escaping (Bool) -> Void) {
        UserService.shared.login(email: email, password: password)
        // FIXME: .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { response in
                // FIXME: print("서버 응답: \(response)") // 서버 응답 출력
                completion(response.status)
                if response.status {
                    UserService.shared.saveToken(response.data!.accessToken!)
                    self.isLoggedIn = response.status
                }
            }.store(in: &cancellables)
    }
}
