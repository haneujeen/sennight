//
//  UserViewModel.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//  Edited by 김소연 on :
//  Edited by 한유진 on 2024-07-18: Refactored UserViewModel
//  Edited by 김소연 on 2024-07-21: FIXME 주석문 삭제
//

import Foundation
import SwiftUI
import Combine

class UserViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var email: String = ""
    @Published var name: String = ""
    @Published var password: String = ""
    @Published var photoFilename: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        isLoggedIn = UserService.shared.isLoggedIn()
    }
    
    //로그아웃
    func logout() {
        UserService.shared.logout()
        isLoggedIn = UserService.shared.isLoggedIn()
    }
    
    //회원가입
    func register(completionHandler: @escaping (UserResponse) -> Void){
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
            }
            .store(in: &cancellables)
    }
    
    //로그인
    func login(completion: @escaping (Bool) -> Void) {
        UserService.shared.login(email: email, password: password)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { response in
                completion(response.status)
                if response.status {
                    //UserService.shared.saveToken(response.data!.accessToken!)
                    self.isLoggedIn = response.status
                }
            }.store(in: &cancellables)
    }
}
