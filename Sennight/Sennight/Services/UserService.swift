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

class UserService {
    static let shared = UserService()
    let HOST = Settings.shared.HOST
    let tokenKey = "token"
    let userIDKey = "userID"
    
    func saveToken(token: String, userID: Int) {
        UserDefaults.standard.set(token, forKey: tokenKey)
        UserDefaults.standard.set(userID, forKey: userIDKey)
    }
    
    func getToken() -> String? {
        UserDefaults.standard.string(forKey: tokenKey)
    }
    
    func getUserID() -> Int? {
        UserDefaults.standard.integer(forKey: userIDKey)
    }
    
    func isLoggedIn() -> Bool { getToken() != nil }
    
    func logout() {
        UserDefaults.standard.removeObject(forKey: tokenKey)
        UserDefaults.standard.removeObject(forKey: userIDKey)
    }
    
    func register(email: String, name: String, password: String, appleID: String?) -> AnyPublisher<UserResponse, AFError> {
        let URL = "\(HOST)/users/register"
        let parameters = UserRequest(email: email, name: name, password: password, photoFilename: nil, appleID: appleID)
        
        return AF.request(url,
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
        let parameters = UserRequest(email: email, name: nil, password: password, photoFilename: nil, appleID: nil)
        
        return AF.request(URL,
                          method: .post,
                          parameters: parameters,
                          encoder: JSONParameterEncoder.default)
        .publishDecodable(type: UserResponse.self)
        .value()
        .eraseToAnyPublisher()
    }
    
    func updatePassword(name: String?, password: String, photoFilename: String?) -> AnyPublisher<UserResponse, AFError> {
        guard let userID = UserService.shared.getUserID(), let token = UserService.shared.getToken() else {
            return Fail(error: AFError.explicitlyCancelled).eraseToAnyPublisher()
        }
        let URL = "\(HOST)/users/\(userID)"
        // TODO:
        let parameters = UserRequest(email: "-@a.b", name: nil, password: password, photoFilename: nil, appleID: nil)
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        return AF.request(URL,
                          method: .put,
                          parameters: parameters,
                          encoder: JSONParameterEncoder.default,
                          headers: headers)
        .validate(contentType: ["application/json"])
        .publishDecodable(type: UserResponse.self)
        .value()
        .eraseToAnyPublisher()
    }
    
    func updateWithAppleID(appleID: String) -> AnyPublisher<UserResponse, AFError> {
        guard let userID = UserService.shared.getUserID(), let token = UserService.shared.getToken() else {
            return Fail(error: AFError.explicitlyCancelled).eraseToAnyPublisher()
        }
        let URL = "\(HOST)/users/\(userID)"
        // TODO:
        let parameters = UserRequest(email: "-@a.b", name: nil, password: nil, photoFilename: nil, appleID: appleID)
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        return AF.request(URL,
                          method: .put,
                          parameters: parameters,
                          encoder: JSONParameterEncoder.default,
                          headers: headers)
        .validate(contentType: ["application/json"])
        .publishDecodable(type: UserResponse.self)
        .value()
        .eraseToAnyPublisher()
    }
    
    func sendAppleUserIdentifier(userIdentifier: String) -> AnyPublisher<AppleSignInResponse, AFError> {
        let URL = "\(HOST)/apple-sign-in"
        return AF.request(URL,
                          method: .post,
                          parameters: ["apple_id": userIdentifier],
                          encoder: JSONParameterEncoder.default)
        .validate(contentType: ["application/json"])
        .publishDecodable(type: AppleSignInResponse.self)
        .value()
        .eraseToAnyPublisher()
    }
}
