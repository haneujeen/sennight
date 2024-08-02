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
    let tokenKey = "token"
    let userIDKey = "userID"
    
    func createMotivation(motivationID: Int, message: String?) -> AnyPublisher<UserMotivationResponse, AFError> {
        guard let userID = UserService.shared.getUserID(), let token = UserService.shared.getToken() else {
            return Fail(error: AFError.explicitlyCancelled).eraseToAnyPublisher()
        }
        let URL = "\(HOST)/user-motivations"
        let parameters = UserMotivationRequest(userId: userID, motivationId: motivationID, message: message)
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        return AF.request(URL,
                          method: .post,
                          parameters: parameters,
                          encoder: JSONParameterEncoder.default,
                          headers: headers)
        .publishData()
        .tryMap { result -> Data in
            if let data = result.data {
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
        .decode(type: UserMotivationResponse.self, decoder: JSONDecoder())
        .mapError { error in
            if let afError = error as? AFError {
                return afError
            } else {
                return AFError.responseSerializationFailed(reason: .decodingFailed(error: error))
            }
        }
        .eraseToAnyPublisher()
        
    func read() -> AnyPublisher<UserMotivationResponse, AFError> {
        print("금연동기 읽어오기")
        
        guard let token = UserService.shared.getToken() else {
            return Fail(error: AFError.explicitlyCancelled).eraseToAnyPublisher()
        }
        
        guard let userID = UserService.shared.getUserID() else {
            return Fail(error: AFError.explicitlyCancelled).eraseToAnyPublisher()
        }
        
        let url = "\(HOST)/user-motivations/\(userID)"
        let header: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        
        return AF.request(url, method: .get, headers: header)
            .validate()
            .responseDecodable(of: UserMotivationResponse.self) { response in
                switch response.result {
                case .success(_):
                    if let data = response.data, let jsonString = String(data: data, encoding: .utf8) {
                        print("Raw JSON response: \(jsonString)")
                    }
                case .failure(let error):
                    print("Request failed with error: \(error)")
                    if let data = response.data, let jsonString = String(data: data, encoding: .utf8) {
                        print("Error response: \(jsonString)")
                    }
                }
            }
            .publishDecodable(type: UserMotivationResponse.self)
            .value()
            .eraseToAnyPublisher()
    }
}
