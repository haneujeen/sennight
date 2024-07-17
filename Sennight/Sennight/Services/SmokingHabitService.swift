//
//  SmokingHabitService.swift
//  Sennight
//
//  Created by 한유진 on 7/16/24.
//

import Foundation
import Combine
import Alamofire

class SmokingHabitService {
    static let shared = SmokingHabitService()
    
    let HOST = Settings.shared.HOST
    
    //smoking habits create Publisher 생성
    func createSH(userId: Int, dailyCigarettes: Int, cigarettePrice: Int, firstCigarette: String, smokingYears: Int) -> AnyPublisher<SmokingHabitResponse, AFError> {
        let url = "\(HOST)/smoking-habits"
        let body = SmokingHabitsRequest(userId: userId,
                                        dailyCigarettes: dailyCigarettes,
                                        cigarettePrice: cigarettePrice,
                                        firstCigarette: firstCigarette,
                                        smokingYears: smokingYears)
        return AF.request(url,
                          method: .post,
                          parameters: body,
                          encoder: JSONParameterEncoder.default)
        .publishDecodable(type: SmokingHabitResponse.self)
        .value()
        .eraseToAnyPublisher()
    }
    //smoking habits read 생성
    func readSH(userId: Int, dailyCigarettes: Int, cigarettePrice: Int, firstCigarette: String, smokingYears: Int) -> AnyPublisher<SmokingHabitResponse, AFError> {
        let url = "\(HOST)/smoking-habits/:user_id"
        let body = SmokingHabitsRequest(userId: userId,
                                        dailyCigarettes: dailyCigarettes,
                                        cigarettePrice: cigarettePrice,
                                        firstCigarette: firstCigarette,
                                        smokingYears: smokingYears)
        return AF.request(url,
                          method: .get,
                          parameters: body,
                          encoder: JSONParameterEncoder.default)
        .publishDecodable(type: SmokingHabitResponse.self)
        .value()
        .eraseToAnyPublisher()
    }
    //smoking habits update 생성
    func updateSH(habit_id: Int, userId: Int, dailyCigarettes: Int, cigarettePrice: Int, firstCigarette: String, smokingYears: Int) -> AnyPublisher<SmokingHabitResponse, AFError> {
        let url = "\(HOST)/smoking-habits/:habit_id"
        let body = SmokingHabitsRequest(userId: userId,
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
