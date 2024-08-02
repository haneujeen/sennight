//
//  MilestoneService.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//  Edited by 김소연 on 2024-07-25: Milestone service 정의
//

import Foundation
import Alamofire
import Combine

class MilestoneService {
    let HOST = Settings.shared.HOST
    static let shared = MilestoneService()
    
    func addMilestoneForUser(milestoneID: Int, quitAttemptID: Int) -> AnyPublisher<UserMilestone, AFError> {
        guard let userID = UserService.shared.getUserID(), let token = UserService.shared.getToken() else {
            return Fail(error: AFError.explicitlyCancelled).eraseToAnyPublisher()
        }
        
        let URL = "\(HOST)/user-milestones"
        let parameters = UserMilestoneRequest(userID: userID, milestoneID: milestoneID, quitAttemptID: quitAttemptID)
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        return AF.request(URL,
                          method: .post,
                          parameters: parameters,
                          encoder: JSONParameterEncoder.default,
                          headers: headers)
        .validate(contentType: ["application/json"])
        .publishDecodable(type: UserMilestoneResponse.self)
        .value()
        .tryMap { response -> UserMilestone in // `.tryMap`: 데이터 처리 과정이 실패할 수도 있을 때
                                                // `.map`: 데이터 처리 과정이 항상 성공한다고 확신할 수 있을 때
            guard let data = response.data else {
                print("Error: UserMilestoneResponse data is nil, failed to add user milestone: \(response)")
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
    
    func getAllMilestones() -> AnyPublisher<[UserMilestone], AFError> {
        guard let userID = UserService.shared.getUserID(), let token = UserService.shared.getToken() else {
            return Fail(error: AFError.explicitlyCancelled).eraseToAnyPublisher()
        }
        
        let url = "\(HOST)/user-milestones/\(userID)"
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        return AF.request(url, method: .get, headers: headers)
            .validate(contentType: ["application/json"])
            .publishDecodable(type: UserMilestonesResponse.self)
            .value()
            .map { $0.data ?? [] }
            .eraseToAnyPublisher()
    }
    
    func getMaxMilestoneID() -> AnyPublisher<Int, AFError> {
        guard let userID = UserService.shared.getUserID(), let token = UserService.shared.getToken() else {
            return Fail(error: AFError.explicitlyCancelled).eraseToAnyPublisher()
        }
        
        let url = "\(HOST)/user-milestones/max-id/\(userID)"
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        return AF.request(url, method: .get, headers: headers)
            .validate(contentType: ["application/json"])
            .publishDecodable(type: UserMaxMilestoneIDResponse.self)
            .value()
            .map { $0.data ?? 0 }
            .eraseToAnyPublisher()
    }
}
