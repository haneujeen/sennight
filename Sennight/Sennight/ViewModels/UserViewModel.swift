//
//  UserViewModel.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//

import Foundation
import SwiftUI
import Combine

class UserViewModel: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var email: String = "user2@gmail.com"
    @Published var password: String = "123456"
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        isLoggedIn = UserService.shared.isLoggedIn()
    }
    
    func logout() {
        let auth = UserService.shared
        auth.logout()
        isLoggedIn = auth.isLoggedIn()
    }
    
    func login(completion: @escaping (Bool)->Void) {
        UserService.shared.login(email: email, password: password)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                    case .finished:
                    break
                    case .failure(let error):
                    //Alert 추가 필요
                    print(error.localizedDescription)
                }
            } receiveValue: { response in
                completion(response.status)
                if response.status{
                    UserService.shared.saveToken(response.data.accessToken)
                }
            }.store(in: &cancellables)
    }
}
