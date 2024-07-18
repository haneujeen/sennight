//
//  UserService.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//  Edited by 김소연 on :
//  Edited by 한유진 on 2024-07-18: Refactored register and login methods
//

import Foundation
import Combine
import Alamofire

class UserService {
    static let shared = UserService() // 싱글톤 패턴 공유 인스턴스 생성
    let HOST = Settings.shared.HOST
    let tokenKey = "token"
    
    // 토큰을 UserDefaults에 저장
    func saveToken(_ token: String) {
        UserDefaults.standard.set(token, forKey: tokenKey)
    }
    
    // UserDefaults에서 토큰을 가져오는 메소드
    func getToken() -> String? {
        UserDefaults.standard.string(forKey: tokenKey)
    }
    
    // 로그인 상태인지 확인
    func isLoggedIn() -> Bool { getToken() != nil }
    
    // 로그아웃, 토큰을 UserDefaults에서 삭제
    func logout() {
        UserDefaults.standard.removeObject(forKey: tokenKey)
    }
    
    // 회원가입 Publisher 생성
//    func register(email: String, name: String?, password: String) -> AnyPublisher<RegisterResponse, AFError> {
//        let url = "\(HOST)/users/register"
//        let body = RegisterRequest(email: email, password: password, name: name)
//        return AF.request(url,
//                          method: .post,
//                          parameters: body,
//                          encoder: JSONParameterEncoder.default)
//        .publishData()
//        .tryMap { result -> Data in
//            if let data = result.data {
//                // 응답 데이터를 로그로 출력
//                if let jsonString = String(data: data, encoding: .utf8) {
//                    print("Raw JSON response: \(jsonString)")
//                } else {
//                    print("Failed to convert data to string")
//                }
//                return data
//            } else {
//                throw AFError.responseValidationFailed(reason: .dataFileNil)
//            }
//        }
//        .decode(type: RegisterResponse.self, decoder: JSONDecoder())
//        .mapError { error in
//            if let afError = error as? AFError {
//                return afError
//            } else {
//                return AFError.responseSerializationFailed(reason: .decodingFailed(error: error))
//            }
//        }
//        .eraseToAnyPublisher()
//    }
    
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
    
    // 로그인 Publisher 생성
//    func login(email: String, password: String) -> AnyPublisher<LoginResponse, AFError> {
//        let url = "\(HOST)/users" // 로그인 URL 설정
//        let body = LoginRequest(email: email, password: password) // 로그인 요청 바디 생성
//        
//        return AF.request(url,
//                          method: .post, // HTTP 메서드 POST로 설정
//                          parameters: body, // 요청 바디 설정
//                          encoder: JSONParameterEncoder.default) // 요청 바디를 JSON 형식으로 인코딩
//        .publishDecodable(type: LoginResponse.self) // 응답을 LoginResponse 타입으로 디코딩
//        .value() // 디코딩된 값을 반환
//        .eraseToAnyPublisher()
//    }
    
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
}
