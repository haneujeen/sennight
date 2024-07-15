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
    static let shared = UserService() //싱글톤 패턴 공유 인스턴스 생성
    let tokenkey = "token"
    //토큰을 UserDefaults에 저장
    let HOST = Settings.shared.HOST
    let PORT = Settings.shared.PORT
    func saveToken(_ token: String) {
        UserDefaults.standard.set(token, forKey: tokenkey)
    }
    //UserDefaults에서 토큰을 가져오는 메소드
    func getToken() -> String? {
        UserDefaults.standard.string(forKey: tokenkey)
    }
    //로그인 상태인지 확인
    func isLoggedIn() -> Bool {
        getToken() != nil
    }
    //로그아웃, 토큰을 UserDefaults에서 삭제
    func logout() {
        UserDefaults.standard.removeObject(forKey: tokenkey)
    }
    
    //회원가입 Publisher 생성
    func register(email: String, password: String, name: String)->AnyPublisher<Register, AFError> {
        let url = "\(HOST):\(PORT)/users/register"
        return AF.upload(multipartFormData: { MultipartFormData in
            MultipartFormData.append(email.data(using: .utf8)!, withName: "email")
            MultipartFormData.append(password.data(using: .utf8)!, withName: "password")
            MultipartFormData.append(name.data(using: .utf8)!, withName: "name")
        }, to: url)
        .publishDecodable(type: Register.self) //응답을 Register 타입으로 디코딩
        .value() //디코딩된 값을 반환
        .eraseToAnyPublisher()
    }
    
    //로그인 Publisher 생성
    func login(email: String, password: String)->AnyPublisher<LoginResponse, AFError> {
        let body = LoginRequest(email: email, password: password)
        let url = "\(HOST):\(PORT)/users" // 로그인 URL 설정
        
        return AF.request(url, method: .post, parameters: body, encoder: JSONParameterEncoder.default)
            .publishDecodable(type: LoginResponse.self) //응답을 LoginResponse 타입으로 디코딩
            .value() //디코딩된 값을 반환
            .eraseToAnyPublisher()
    }
}
