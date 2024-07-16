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
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var name: String = ""
    @Published var profileImage: UIImage?
    @Published var errorMessage: String? = nil
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        isLoggedIn = UserService.shared.isLoggedIn()
    }
    //로그아웃
    func logout() {
        let auth = UserService.shared
        auth.logout()
        isLoggedIn = auth.isLoggedIn()
    }
    //로그인
    func login(completion: @escaping (Bool)->Void) {
        UserService.shared.login(email: email, password: password)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                    case .finished:
                    break
                    case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { response in
                print("서버 응답: \(response)") // 서버 응답 출력
                completion(response.status)
                if response.status{
                    UserService.shared.saveToken(response.data.accessToken)
                    self.isLoggedIn = true
                } else {
                    self.errorMessage = "Login failed"
                }
            }.store(in: &cancellables)
    }
    //회원가입
    func register(completionHandler: @escaping (Bool)->Void){
        //프로필 사진 등록
//        guard let profileImage, let profileData = profileImage.jpegData(compressionQuality: 0.8) else {
//            print("사진을 등록해주세요")
//            return
//        }
        UserService.shared.register(email: email, password: password, name: name)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { response in
                completionHandler(response.status)
            }.store(in: &cancellables)

    }
}
