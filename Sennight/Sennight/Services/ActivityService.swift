//
//  ActivityService.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//  Edited by 김소연 on 2024-07-29: Activity Service 코드 생성
//

import Foundation
import Combine
import Alamofire

class ActivityService {
    static let shared = ActivityService()
    let HOST = Settings.shared.HOST
    let tokenKey = "token"
    let userIDKey = "userID"
    
    func read() -> AnyPublisher<[UserActivity], AFError> {
        print("사용자의 활동을 읽어오려합니다")
        
        guard let token  = UserService.shared.getToken() else {
            return Fail(error: AFError.explicitlyCancelled).eraseToAnyPublisher()
        }
        guard let userID  = UserService.shared.getUserID() else {
            return Fail(error: AFError.explicitlyCancelled).eraseToAnyPublisher()
        }
        let URL = "\(HOST)/user-activities/\(userID)"
        let header : HTTPHeaders = ["Authorization": "Bearer \(token)"]
        return AF.request(URL, method: .get, headers: header)
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
                    .decode(type: UserActivityResponse.self, decoder: JSONDecoder())
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

