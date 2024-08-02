//
//  QuitAttemptService.swift
//  Sennight
//
//  Created by 한유진 on 7/16/24.
//  Edited by 김소연 on 2024-07-19: Quit Attempt Service 코드 생성
//  Edited by 김소연 on 2024-07-23: Quit Attempt Service 코드 수정
//  Edited by 한유진 on 2024-07-24: Added getLatestQuitAttempt(userID:)
//  Edited by 한유진 on 2024-07-24: 함수 이름 getLatestQuitAttempt을 getActiveQuitAttempt로 수정
//  Edited by 한유진 on 2024-07-31: 온보딩 스크린 리팩터
//

import SwiftUI
import Combine
import Alamofire

class QuitAttemptService {
    static let shared = QuitAttemptService()
    
    let HOST = Settings.shared.HOST
    
    func createQuitAttempt(startDate: String) -> AnyPublisher<QuitAttemptResponse, AFError> {
        guard let userID = UserService.shared.getUserID(), let token = UserService.shared.getToken() else {
            return Fail(error: AFError.explicitlyCancelled).eraseToAnyPublisher()
        }
        let URL = "\(HOST)/quit-attempts"
        let parameters = QuitAttemptRequest(userID: userID, startDate: startDate, endDate: nil, isActive: true)
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
        .decode(type: QuitAttemptResponse.self, decoder: JSONDecoder())
        .mapError { error in
            if let afError = error as? AFError {
                return afError
            } else {
                return AFError.responseSerializationFailed(reason: .decodingFailed(error: error))
            }
        }
        .eraseToAnyPublisher()
    }
    
    /// Retrieves user's most recent quitting smoking attempt.
    func getActiveQuitAttempt() -> AnyPublisher<QuitAttempt, AFError> {
        guard let userID = UserService.shared.getUserID(), let token = UserService.shared.getToken() else {
            return Fail(error: AFError.explicitlyCancelled).eraseToAnyPublisher()
        }
        let URL = "\(HOST)/quit-attempts/\(userID)"
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        return AF.request(URL,
                          method: .get,
                          headers: headers)
        .validate(contentType: ["application/json"])
        .publishDecodable(type: QuitAttemptResponse.self)
        .value()
        .tryMap { quitAttemptResponse -> QuitAttempt in // `.tryMap`: 데이터 처리 과정이 실패할 수도 있을 때
                                                        // `.map`: 데이터 처리 과정이 항상 성공한다고 확신할 수 있을 때
            guard let data = quitAttemptResponse.data else {
                print("Error: QuitAttemptResponse data is nil: \(quitAttemptResponse)")
                throw URLError(.badServerResponse)
            }
            return data
        }
        .mapError { error -> AFError in // Converts `any Error` to `AFError`.
            if let afError = error as? AFError {
                return afError
            } else {
                return AFError.createURLRequestFailed(error: error)
            }
        }
        .eraseToAnyPublisher()
    }
    
        /// Retrieves all of user's quitting smoking attempts.
        func getAllQuitAttempts() -> AnyPublisher<[QuitAttempt], AFError> {
            guard let userID = UserService.shared.getUserID(), let token = UserService.shared.getToken() else {
                return Fail(error: AFError.explicitlyCancelled).eraseToAnyPublisher()
            }
            let URL = "\(HOST)/quit-attempts/all/\(userID)"
            let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
            return AF.request(URL,
                              method: .get,
                              headers: headers)
            .validate(contentType: ["application/json"])
            .publishDecodable(type: QuitAttemptsResponse.self)
            .value()
            .tryMap { quitAttemptsResponse -> [QuitAttempt] in
                guard let data = quitAttemptsResponse.data else {
                    print("Error: QuitAttemptsResponse data is nil: \(quitAttemptsResponse)")
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .mapError { error -> AFError in
                if let afError = error as? AFError {
                    return afError
                } else {
                    return AFError.createURLRequestFailed(error: error)
                }
            }
            .eraseToAnyPublisher()
        }
    
    //    /// Deletes a quitting smoking attempt.
    //    func deleteQuitAttempt(userID: Int, attemptID: Int) {
    //        // Implementation here
    //    }
    //
    //    /// Updates a quitting smoking attempt.
    //    func updateQuitAttempt(userID: Int, attemptID: Int, quitAttemptData: [String: Any]) -> QuitAttempt {
    //        // Implementation here
    //    }
    //
    //    /// Retrieves milestones associated with a quitting smoking attempt.
    //    func getMilestonesForQuitAttempt(userId: Int, attemptId: Int) -> [Milestone] {
    //        // Implementation here
    //    }
}
