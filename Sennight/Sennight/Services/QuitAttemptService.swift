//
//  QuitAttemptService.swift
//  Sennight
//
//  Created by 한유진 on 7/16/24.
//  Edited by 김소연 on 2024-07-19: Quit Attempt Service 코드 생성
//  Edited by 김소연 on 2024-07-23: Quit Attempt Service 코드 수정
//

import Foundation
import Combine
import Alamofire

class QuitAttemptService {
    static let shared = QuitAttemptService()
    
    let HOST = Settings.shared.HOST
    
    // 현재 진행중인 금연 도전 생성
    func createQuitAttempt(onboardingToken: String, startDate: String, userID: Int) -> AnyPublisher<QuitAttemptResponse, AFError> {
        let url = "\(HOST)/quit-attempts"
        let body = QuitAttemptRequest(userID: userID, startDate: startDate, endDate: nil, isActive: nil)
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
    
    // HTTP get,delete request는 body를 보내지 않음
    func readQuitAttempt(userID: Int) -> AnyPublisher<QuitAttemptResponse, AFError> {
        let url = "\(HOST)/quit-attempts/\(userID)"
        return AF.request(url, method: .get)
            .publishDecodable(type: QuitAttemptResponse.self)
            .value()
            .eraseToAnyPublisher()
    }
    
    func readAllQuitAttempt(userID: Int) -> AnyPublisher<[QuitAttemptResponse], AFError> {
        let url = "\(HOST)/quit-attempts/all/\(userID)"
        return AF.request(url, method: .get)
            .publishDecodable(type: [QuitAttemptResponse].self)
            .value()
            .eraseToAnyPublisher()
    }
    
    func updateQuitAttempt(attemptID: Int, startDate: String, endDate: String, isActive: Bool) -> AnyPublisher<QuitAttemptResponse, AFError> {
        let url = "\(HOST)/quit-attempts/\(attemptID)"
        let body = QuitAttemptRequest(userID: nil, startDate: startDate, endDate: endDate, isActive: isActive)
        return AF.request(url,
                          method: .put,
                          parameters: body,
                          encoder: JSONParameterEncoder.default)
            .publishDecodable(type: QuitAttemptResponse.self)
            .value()
            .eraseToAnyPublisher()
    }
    
    func deleteQuitAttempt(attemptID: Int, startDate: String, endDate: String, isActive: Bool) -> AnyPublisher<QuitAttemptResponse, AFError> {
        let url = "\(HOST)/quit-attempts/\(attemptID)"
        let body = QuitAttemptRequest(userID: nil, startDate: startDate, endDate: endDate, isActive: isActive)
        return AF.request(url,
                          method: .delete,
                          parameters: body,
                          encoder: JSONParameterEncoder.default)
            .publishDecodable(type: QuitAttemptResponse.self)
            .value()
            .eraseToAnyPublisher()
    }
    
    func ReadMilestionesQuitAttempt(attemptID: Int, startDate: String, endDate: String, isActive: Bool) -> AnyPublisher<QuitAttemptResponse, AFError> {
        let url = "\(HOST)/quit-attempts/\(attemptID)/milestones"
        let body = QuitAttemptRequest(userID: nil, startDate: startDate, endDate: endDate, isActive: isActive)
        return AF.request(url,
                          method: .get,
                          parameters: body,
                          encoder: JSONParameterEncoder.default)
            .publishDecodable(type: QuitAttemptResponse.self)
            .value()
            .eraseToAnyPublisher()
    }
}
