//
//  MotivationService.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//  Edited by 김소연 on 2024-07-19: Motivation Service 코드 생성
//

import Foundation
import Combine
import Alamofire

class MotivationService {
    static let shared = MotivationService()
    
    let HOST = Settings.shared.HOST
    
    func createMO(userId: Int, motivationId: Int) -> AnyPublisher<MotivationResponse, AFError> {
        let url = "\(HOST)/user-motivations"
        let body = MotivationRequest(userId: userId, motivationId: motivationId)
        return AF.request(url,
                          method: .post,
                          parameters: body,
                          encoder: JSONParameterEncoder.default)
            .publishDecodable(type: MotivationResponse.self)
            .value()
            .eraseToAnyPublisher()
    }
    
    func readMO(userId: Int) -> AnyPublisher<MotivationResponse, AFError> {
        let url = "\(HOST)/user-motivations/\(userId)"
        let body = MotivationReadRequest(userId: userId)
        return AF.request(url,
                          method: .get,
                          parameters: body,
                          encoder: JSONParameterEncoder.default)
            .publishDecodable(type: MotivationResponse.self)
            .value()
            .eraseToAnyPublisher()
    }
    
    func updateMO(userId: Int, motivationId: Int, userMotivationId: Int) -> AnyPublisher<MotivationResponse, AFError> {
        let url = "\(HOST)/user-motivations/\(userMotivationId)"
        let body = MotivationUpdateRequest(userId: userId, motivationId: motivationId, userMotivationId: userMotivationId)
        return AF.request(url,
                          method: .put,
                          parameters: body,
                          encoder: JSONParameterEncoder.default)
            .publishDecodable(type: MotivationResponse.self)
            .value()
            .eraseToAnyPublisher()
    }
    
    func deleteMO(userMotivationId: Int) -> AnyPublisher<MotivationResponse, AFError> {
        let url = "\(HOST)/user-motivations/\(userMotivationId)"
        let body = MotivationDeleteRequest(userMotivationId: userMotivationId)
        return AF.request(url,
                          method: .delete,
                          parameters: body,
                          encoder: JSONParameterEncoder.default)
            .publishDecodable(type: MotivationResponse.self)
            .value()
            .eraseToAnyPublisher()
    }
}
