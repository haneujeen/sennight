//
//  SmokingHabitService.swift
//  Sennight
//
//  Created by 한유진 on 7/16/24.
//  Edited by 김소연 on 2024-07-23: SmokingHabitService 코드 수정
//

import Foundation
import Combine
import Alamofire

class SmokingHabitService {
    static let shared = SmokingHabitService()
    
    let HOST = Settings.shared.HOST
    
    //smoking habits create Publisher 생성
    func createSmokingHabit(userID: Int, dailyCigarettes: Int, cigarettePrice: Int, firstCigarette: String, smokingYears: Int) -> AnyPublisher<SmokingHabitResponse, AFError> {
        let url = "\(HOST)/smoking-habits"
        //토큰이 없을 때 반환하는 에러로 변경됨
        guard let token = UserService.shared.getToken() else {
                    return Fail(error: AFError.createURLRequestFailed(error: URLError(.userAuthenticationRequired))).eraseToAnyPublisher()
                }
        let body = SmokingHabitsRequest(userID: userID,
                                        dailyCigarettes: dailyCigarettes,
                                        cigarettePrice: cigarettePrice,
                                        firstCigarette: firstCigarette,
                                        smokingYears: smokingYears)
        return AF.request(url,
                          method: .post,
                          parameters: body,
                          encoder: JSONParameterEncoder.default,
                          headers: ["Authorization": "Bearer \(token)"])
        .publishDecodable(type: SmokingHabitResponse.self)
        .value()
        .eraseToAnyPublisher()
    }
    
    //smoking habits read 생성
    func readSmokingHabit(userID: Int) -> AnyPublisher<SmokingHabitResponse, AFError> {
        let url = "\(HOST)/smoking-habits/\(userID)"
        return AF.request(url, method: .get)
        .publishDecodable(type: SmokingHabitResponse.self)
        .value()
        .eraseToAnyPublisher()
    }
    
    //smoking habits update 생성
    func updateSmokingHabit(habitID: Int, userID: Int, dailyCigarettes: Int, cigarettePrice: Int, firstCigarette: String, smokingYears: Int) -> AnyPublisher<SmokingHabitResponse, AFError> {
        let url = "\(HOST)/smoking-habits/:habit_id"
        let body = SmokingHabitsRequest(userID: userID,
                                        dailyCigarettes: dailyCigarettes,
                                        cigarettePrice: cigarettePrice,
                                        firstCigarette: firstCigarette,
                                        smokingYears: smokingYears)
        
        return AF.request(url,
                          method: .put,
                          parameters: body,
                          encoder: JSONParameterEncoder.default)
        .publishDecodable(type: SmokingHabitResponse.self)
        .value()
        .eraseToAnyPublisher()
    }
}
