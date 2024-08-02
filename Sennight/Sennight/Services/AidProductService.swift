//
//  FactorService.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//  Edited by 김소연 on 2024-07-27: AidProduct service 정의
//

import Foundation
import Combine
import Alamofire

class AidProductService {
    static let shared = AidProductService()
    let HOST = Settings.shared.HOST
    let tokenKey = "token"
    let userIDKey = "userID"
    
    func read() -> AnyPublisher<[UserAidProduct], AFError> {
        print("금연보조제를 읽어오려합니다")
        
        guard let token  = UserService.shared.getToken() else {
            return Fail(error: AFError.explicitlyCancelled).eraseToAnyPublisher()
        }
        guard let userID  = UserService.shared.getUserID() else {
            return Fail(error: AFError.explicitlyCancelled).eraseToAnyPublisher()
        }
        let url = "\(HOST)/user-aid-products/\(userID)"
        let header : HTTPHeaders = ["Authorization": "Bearer \(token)"]
        return AF.request(url, method: .get, headers: header)
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
            .decode(type: UserAidProductResponse.self, decoder: JSONDecoder())
            .map { $0.data }
            .mapError { error in
                if let afError = error as? AFError {
                    return afError
                } else {
                    return AFError.responseSerializationFailed(reason: .decodingFailed(error: error))
                }
            }
            .eraseToAnyPublisher()
    }
}
