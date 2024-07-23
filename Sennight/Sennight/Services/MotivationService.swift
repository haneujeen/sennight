//
//  MotivationService.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//  Edited by 김소연 on 2024-07-19: Motivation Service 코드 생성
//  Edited by 김소연 on 2024-07-23: Motivation Service 코드 수정
//

import Foundation
import Combine
import Alamofire

class MotivationService {
    static let shared = MotivationService()
    
    let HOST = Settings.shared.HOST
    
    func createMotivation(userID: Int, motivationID: Int) -> AnyPublisher<MotivationResponse, AFError> {
        let url = "\(HOST)/user-motivations"
        guard let token = UserService.shared.getToken() else {
                    return Fail(error: AFError.createURLRequestFailed(error: URLError(.userAuthenticationRequired))).eraseToAnyPublisher()
                }
        let body = MotivationRequest(userID: userID, motivationID: motivationID, userMotivationID: nil)
        return AF.request(url,
                          method: .post,
                          parameters: body,
                          encoder: JSONParameterEncoder.default,
                          headers: ["Authorization": "Bearer \(token)"])
            .publishDecodable(type: MotivationResponse.self)
            .value()
            .eraseToAnyPublisher()
    }
    
    func readMotivation(userID: Int) -> AnyPublisher<MotivationResponse, AFError> {
        let url = "\(HOST)/user-motivations/\(userID)"
        return AF.request(url, method: .get)
            .publishDecodable(type: MotivationResponse.self)
            .value()
            .eraseToAnyPublisher()
    }
    
    func updateMotivation(userID: Int, motivationID: Int, userMotivationID: Int) -> AnyPublisher<MotivationResponse, AFError> {
        let url = "\(HOST)/user-motivations/\(userMotivationID)"
        let body = MotivationRequest(userID: userID, motivationID: motivationID, userMotivationID: userMotivationID)
        return AF.request(url,
                          method: .put,
                          parameters: body,
                          encoder: JSONParameterEncoder.default)
            .publishDecodable(type: MotivationResponse.self)
            .value()
            .eraseToAnyPublisher()
    }
    
    func deleteMotivation(userMotivationID: Int) -> AnyPublisher<MotivationResponse, AFError> {
        let url = "\(HOST)/user-motivations/\(userMotivationID)"
        return AF.request(url, method: .delete)
            .publishDecodable(type: MotivationResponse.self)
            .value()
            .eraseToAnyPublisher()
    }
}
