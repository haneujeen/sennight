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
    
    func createMotivation(onboardingToken: String, userID: Int, motivationID: Int) -> AnyPublisher<MotivationResponse, AFError> {
        let url = "\(HOST)/user-motivations"
//        guard let token = UserService.shared.getToken() else {
//                    return Fail(error: AFError.createURLRequestFailed(error: URLError(.userAuthenticationRequired))).eraseToAnyPublisher()
//                }
        let body = MotivationRequest(userID: userID, motivationID: motivationID, userMotivationID: nil)
        
        do {
            let jsonData = try JSONEncoder().encode(body)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print("Request: \(jsonString)")
            }
        } catch {
            print("Failed to encode: \(error)")
        }
        return AF.request(url,
                          method: .post,
                          parameters: body,
                          encoder: JSONParameterEncoder.default,
                          headers: ["Authorization": "Bearer \(onboardingToken)"])
        .publishData()
                .tryMap { result -> Data in
                    if let data = result.data {
                        // 응답 데이터를 로그로 출력
                        if let jsonString = String(data: data, encoding: .utf8) {
                            print("Raw JSON response: \(jsonString)")
                        } else {
                            print("Failed to convert data to string")
                        }
                        return data
                    } else {
                        throw AFError.responseValidationFailed(reason: .dataFileNil)
                    }
                }
                .decode(type: MotivationResponse.self, decoder: JSONDecoder())
                .mapError { error in
                    if let afError = error as? AFError {
                        return afError
                    } else {
                        return AFError.responseSerializationFailed(reason: .decodingFailed(error: error))
                    }
                }
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
