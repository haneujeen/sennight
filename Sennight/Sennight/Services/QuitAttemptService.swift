//
//  QuitAttemptService.swift
//  Sennight
//
//  Created by 한유진 on 7/16/24.
//  Edited by 김소연 on 2024-07-19: Quit Attempt Service 코드 생성
//

import Foundation
import Combine
import Alamofire

class QuitAttemptService {
    static let shared = QuitAttemptService()
    
    let HOST = Settings.shared.HOST
    
    func createQA(startDate: String) -> AnyPublisher<QuitAttemptResponse, AFError> {
        let url = "\(HOST)/quit-attempts"
        let body = CreateQARequest(startDate: startDate)
        return AF.request(url,
                          method: .post,
                          parameters: body,
                          encoder: JSONParameterEncoder.default)
            .publishDecodable(type: QuitAttemptResponse.self)
            .value()
            .eraseToAnyPublisher()
    }
    
    func readQA(userId: Int) -> AnyPublisher<QuitAttemptResponse, AFError> {
        let url = "\(HOST)/quit-attempts/\(userId)"
        let body = ReadQARequest(userId: userId)
        return AF.request(url,
                          method: .get,
                          parameters: body,
                          encoder: JSONParameterEncoder.default)
            .publishDecodable(type: QuitAttemptResponse.self)
            .value()
            .eraseToAnyPublisher()
    }
    
    func readAllQA(userId: Int) -> AnyPublisher<QuitAttemptResponse, AFError> {
        let url = "\(HOST)/quit-attempts/all/\(userId)"
        let body = ReadQARequest(userId: userId)
        return AF.request(url,
                          method: .get,
                          parameters: body,
                          encoder: JSONParameterEncoder.default)
            .publishDecodable(type: QuitAttemptResponse.self)
            .value()
            .eraseToAnyPublisher()
    }
    
    func updateQA(attemptId: Int, startDate: String, endDate: String, isActive: Bool) -> AnyPublisher<QuitAttemptResponse, AFError> {
        let url = "\(HOST)/quit-attempts/\(attemptId)"
        let body = UpdateDeleteQARequest(attemptId: attemptId, startDate: startDate, endDate: endDate, isActive: isActive)
        return AF.request(url,
                          method: .put,
                          parameters: body,
                          encoder: JSONParameterEncoder.default)
            .publishDecodable(type: QuitAttemptResponse.self)
            .value()
            .eraseToAnyPublisher()
    }
    
    func deleteQA(attemptId: Int, startDate: String, endDate: String, isActive: Bool) -> AnyPublisher<QuitAttemptResponse, AFError> {
        let url = "\(HOST)/quit-attempts/\(attemptId)"
        let body = UpdateDeleteQARequest(attemptId: attemptId, startDate: startDate, endDate: endDate, isActive: isActive)
        return AF.request(url,
                          method: .delete,
                          parameters: body,
                          encoder: JSONParameterEncoder.default)
            .publishDecodable(type: QuitAttemptResponse.self)
            .value()
            .eraseToAnyPublisher()
    }
    
    func ReadMilestionesQA(attemptId: Int, startDate: String, endDate: String, isActive: Bool) -> AnyPublisher<QuitAttemptResponse, AFError> {
        let url = "\(HOST)/quit-attempts/\(attemptId)/milestones"
        let body = ReadMilestonesQARequest(attemptId: attemptId, startDate: startDate, endDate: endDate, isActive: isActive)
        return AF.request(url,
                          method: .get,
                          parameters: body,
                          encoder: JSONParameterEncoder.default)
            .publishDecodable(type: QuitAttemptResponse.self)
            .value()
            .eraseToAnyPublisher()
    }
}
