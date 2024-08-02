//
//  SmokingHabitService.swift
//  Sennight
//
//  Created by 한유진 on 7/16/24.
//  Edited by 김소연 on 2024-07-23: SmokingHabitService 코드 수정
//  Edited by 한유진 on 2024-07-27: Refactor SmokingHabitService.swift
//

import Foundation
import Combine
import Alamofire

class SmokingHabitService {
    static let shared = SmokingHabitService()
    
    let HOST = Settings.shared.HOST
    
    func createSmokingHabit(dailyCigarettes: Int, cigarettePrice: Double, firstCigarette: String, smokingYears: Int) -> AnyPublisher<SmokingHabitResponse, AFError> {
        guard let userID = UserService.shared.getUserID(), let token = UserService.shared.getToken() else {
            return Fail(error: AFError.explicitlyCancelled).eraseToAnyPublisher()
        }
        let url = "\(HOST)/smoking-habits"
        let parameters = SmokingHabitRequest(userID: userID,
                                             dailyCigarettes: dailyCigarettes,
                                             cigarettePrice: cigarettePrice,
                                             firstCigarette: firstCigarette,
                                             smokingYears: smokingYears)
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        return AF.request(url,
                          method: .post,
                          parameters: parameters,
                          encoder: JSONParameterEncoder.default,
                          headers: headers)
        .publishDecodable(type: SmokingHabitResponse.self)
        .value()
        .eraseToAnyPublisher()
    }
    
    func getSmokingHabit() -> AnyPublisher<SmokingHabitResponse, AFError> {
        guard let userID = UserService.shared.getUserID(), let token = UserService.shared.getToken() else {
            return Fail(error: AFError.explicitlyCancelled).eraseToAnyPublisher()
        }
        let url = "\(HOST)/smoking-habits/\(userID)"
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        return AF.request(url, method: .get, headers: headers)
            .publishDecodable(type: SmokingHabitResponse.self)
            .value()
            .eraseToAnyPublisher()
    }
    
    func updateSmokingHabit(habitID: Int, dailyCigarettes: Int, cigarettePrice: Double, firstCigarette: String, smokingYears: Int) -> AnyPublisher<SmokingHabitResponse, AFError> {
        guard let userID = UserService.shared.getUserID(), let token = UserService.shared.getToken() else {
            return Fail(error: AFError.explicitlyCancelled).eraseToAnyPublisher()
        }
        let url = "\(HOST)/smoking-habits/\(habitID)"
        let parameters = SmokingHabitRequest(userID: userID,
                                             dailyCigarettes: dailyCigarettes,
                                             cigarettePrice: cigarettePrice,
                                             firstCigarette: firstCigarette,
                                             smokingYears: smokingYears)
        let headers: HTTPHeaders = ["Authorization": "Bearer \(token)"]
        return AF.request(url,
                          method: .put,
                          parameters: parameters,
                          encoder: JSONParameterEncoder.default,
                          headers: headers)
        .publishDecodable(type: SmokingHabitResponse.self)
        .value()
        .eraseToAnyPublisher()
    }
}
