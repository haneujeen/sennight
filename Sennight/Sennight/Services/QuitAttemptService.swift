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
    func createQuitAttempt(startDate: String, userID: Int) -> AnyPublisher<QuitAttemptResponse, AFError> {
        let url = "\(HOST)/quit-attempts"
        guard let token = UserService.shared.getToken() else {
                    return Fail(error: AFError.createURLRequestFailed(error: URLError(.userAuthenticationRequired))).eraseToAnyPublisher()
                }
        let body = QuitAttemptRequest(userID: userID, startDate: startDate, endDate: nil, isActive: nil)
        return AF.request(url,
                          method: .post,
                          parameters: body,
                          encoder: JSONParameterEncoder.default,
                          headers: ["Authorization": "Bearer \(token)"])
            .publishDecodable(type: QuitAttemptResponse.self)
            .value()
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
