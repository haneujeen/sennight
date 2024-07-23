//
//  UserService.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//  Edited by 김소연 on :
//  Edited by 한유진 on 2024-07-18: Refactored register and login methods
//  Edited by 한유진 on 2024-07-19: saveToken에서 token과 userID를 함께 저장하도록 수정
//  Edited by 김소연 on 2024-07-21: userID를 가져오는 메서드 추가
//  Edited by 한유진 on 2024-07-19: updateUser 메서드 추가
//

import Foundation
import Combine
import Alamofire

// TODO: UserService TokenService 분리
class UserService {
    static let shared = UserService() // 싱글톤 패턴 공유 인스턴스 생성
    let HOST = Settings.shared.HOST
    let tokenKey = "token"
    let userIDKey = "userID"
    
    // 토큰을 UserDefaults에 저장
    func saveToken(token: String, userID: Int) {
        UserDefaults.standard.set(token, forKey: tokenKey)
        UserDefaults.standard.set(userID, forKey: userIDKey)
    }
    
    // UserDefaults에서 토큰을 가져오는 메소드
    func getToken() -> String? {
        UserDefaults.standard.string(forKey: tokenKey)
    }
    
    func getUserID() -> Int? {
        UserDefaults.standard.integer(forKey: userIDKey)
    }
    
    // 로그인 상태인지 확인
    func isLoggedIn() -> Bool { getToken() != nil }
    
    // 로그아웃, 토큰을 UserDefaults에서 삭제
    func logout() {
        UserDefaults.standard.removeObject(forKey: tokenKey)
        UserDefaults.standard.removeObject(forKey: userIDKey)
    }
    
    func register(email: String, name: String, password: String) -> AnyPublisher<UserResponse, AFError> {
        let URL = "\(HOST)/users/register"
        let parameters = UserRequest(email: email, name: name, password: password, photoFilename: nil)
        
        return AF.request(URL,
                          method: .post,
                          parameters: parameters,
                          encoder: JSONParameterEncoder.default)
        .validate(contentType: ["application/json"])
        .publishDecodable(type: UserResponse.self)
        .value()
        .eraseToAnyPublisher()
    }
    
    func login(email: String, password: String) -> AnyPublisher<UserResponse, AFError> {
        let URL = "\(HOST)/users"
        let parameters = UserRequest(email: email, name: nil, password: password, photoFilename: nil)
        
        // Encode parameters to JSON
        // Remove this before deploying
        // Out: Request: {"password":"1234","email":"test6@gmail.com"}
        do {
            let jsonData = try JSONEncoder().encode(parameters)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print("Request: \(jsonString)")
            }
        } catch {
            print("Failed to encode: \(error)")
        }
        
        return AF.request(URL,
                          method: .post,
                          parameters: parameters,
                          encoder: JSONParameterEncoder.default)
        .publishDecodable(type: UserResponse.self)
        .value()
        .eraseToAnyPublisher()
    }
    
    func updateUser(userID: Int, name: String?, password: String, photoFilename: String?) -> AnyPublisher<UserResponse, AFError> {
        let URL = "\(HOST)/users/\(userID)"
        let parameters = UserRequest(email: nil, name: name, password: password, photoFilename: photoFilename)
        
        return AF.request(URL,
                          method: .put,
                          parameters: parameters,
                          encoder: JSONParameterEncoder.default)
        .validate(contentType: ["application/json"])
        .publishDecodable(type: UserResponse.self)
        .value()
        .eraseToAnyPublisher()
    }
}
