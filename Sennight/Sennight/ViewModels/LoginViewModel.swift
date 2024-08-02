//
//  UserViewModel.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//  Edited by 김소연 on :
//  Edited by 한유진 on 2024-07-18: Refactored UserViewModel
//  Edited by 한유진 on 2024-07-18: Separated view models (to follow single responsibility principle)
//  Edited by 한유진 on 2024-07-19: saveToken에서 token과 userID를 함께 저장하도록 수정
//

import Foundation
import SwiftUI
import Combine

class LoginViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var email: String = ""
    @Published var password: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        isLoggedIn = UserService.shared.isLoggedIn()
    }
    
    func logout() {
        UserService.shared.logout()
        isLoggedIn = UserService.shared.isLoggedIn()
    }
    
    func login(completionHandler: @escaping (Bool) -> Void) {
        UserService.shared.login(email: email, password: password)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { response in
                completionHandler(response.status)
                if response.status {
                    UserService.shared.saveToken(token: response.data!.accessToken!, userID: response.data!.id!)
                    self.email = response.data?.email ?? ""
                    self.password = response.data?.password ?? ""
                }
            }.store(in: &cancellables)
    }
}
