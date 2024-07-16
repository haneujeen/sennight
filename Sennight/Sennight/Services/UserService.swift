//
//  UserService.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//

import Foundation
import Combine
import Alamofire

class UserService {
    static let shared = UserService() // 싱글톤 패턴 공유 인스턴스 생성
    let tokenKey = "token"
    
    let HOST = Settings.shared.HOST
    
    // 토큰을 UserDefaults에 저장
    func saveToken(_ token: String) {
        UserDefaults.standard.set(token, forKey: tokenKey)
    }
    
    // UserDefaults에서 토큰을 가져오는 메소드
    func getToken() -> String? {
        UserDefaults.standard.string(forKey: tokenKey)
    }
    
    // 로그인 상태인지 확인
    func isLoggedIn() -> Bool {
        getToken() != nil
    }
    
    // 로그아웃, 토큰을 UserDefaults에서 삭제
    func logout() {
        UserDefaults.standard.removeObject(forKey: tokenKey)
    }
    
    // 회원가입 Publisher 생성
    func register(email: String, password: String, name: String) -> AnyPublisher<RegisterResponse, AFError> {
        let url = "\(HOST)/users/register"
        return AF.upload(multipartFormData: { MultipartFormData in
            MultipartFormData.append(email.data(using: .utf8)!, withName: "email")
            MultipartFormData.append(password.data(using: .utf8)!, withName: "password")
            MultipartFormData.append(name.data(using: .utf8)!, withName: "name")
        }, to: url)
        .publishDecodable(type: RegisterResponse.self) // 응답을 RegisterResponse 타입으로 디코딩
        .value() // 디코딩된 값을 반환
        .eraseToAnyPublisher()
    }
    
    // 로그인 Publisher 생성
    func login(email: String, password: String) -> AnyPublisher<LoginResponse, AFError> {
        let url = "\(HOST)/users" // 로그인 URL 설정
        let body = LoginRequest(email: email, password: password) // 로그인 요청 바디 생성
        
        return AF.request(url,
                          method: .post, // HTTP 메서드 POST로 설정
                          parameters: body, // 요청 바디 설정
                          encoder: JSONParameterEncoder.default) // 요청 바디를 JSON 형식으로 인코딩
        .publishDecodable(type: LoginResponse.self) // 응답을 LoginResponse 타입으로 디코딩
        .value() // 디코딩된 값을 반환
        .eraseToAnyPublisher()
    }
}
