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
    func createSmokingHabit(onboardingToken: String, userID: Int, dailyCigarettes: Int, cigarettePrice: Double, firstCigarette: String, smokingYears: Int) -> AnyPublisher<SmokingHabitResponse, AFError> {
        let url = "\(HOST)/smoking-habits"
        
        let body = SmokingHabitsRequest(userID: userID,
                                        dailyCigarettes: dailyCigarettes,
                                        cigarettePrice: cigarettePrice,
                                        firstCigarette: firstCigarette,
                                        smokingYears: smokingYears)
        
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
                .decode(type: SmokingHabitResponse.self, decoder: JSONDecoder())
                .mapError { error in
                    if let afError = error as? AFError {
                        return afError
                    } else {
                        return AFError.responseSerializationFailed(reason: .decodingFailed(error: error))
                    }
                }
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
    func updateSmokingHabit(habitID: Int, userID: Int, dailyCigarettes: Int, cigarettePrice: Double, firstCigarette: String, smokingYears: Int) -> AnyPublisher<SmokingHabitResponse, AFError> {
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
