//
//  QuitAttempt.swift
//  Sennight
//
//  Created by 한유진 on 7/16/24.
//  Edited by 김소연 on 2024-07-19: Quit Attempt 모델 정의
//  Edited by 김소연 on 2024-07-23: Quit Attempt 모델 수정
//  Edited by 한유진 on 2024-07-24:
//      QuitAttempt 예시 응답 및 요청 주석 추가
//      QuitAttempt.swift 수정
//

import Foundation
/**
 - 요청 JSON:
     {
         "user_id": 1,
         "start_date": "2024-07-10",
         "end_date": "2024-07-24",
         "is_active": false
     }
 
 - 응답:
     {
         "status": true,
         "detail": "",
         "data": {
             "id": 4,
             "end_date": null,
             "user_id": 1,
             "start_date": "2024-07-10T00:00:00",
             "is_active": true
         }
     }
 */

struct QuitAttemptRequest: Codable {
    let userID: Int
    let startDate: String
    let endDate: String?
    let isActive: Bool?
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case startDate = "start_date"
        case endDate = "end_date"
        case isActive = "is_active"
    }
}

struct QuitAttempt: Codable {
    let id: Int
    let userID: Int
    let startDate: String
    let endDate: String?
    let isActive: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case startDate = "start_date"
        case endDate = "end_date"
        case isActive = "is_active"
    }
}

struct QuitAttemptResponse: Codable {
    let status: Bool
    let detail: String
    let data: QuitAttempt?
}

struct QuitAttemptsResponse: Codable {
    let status: Bool
    let detail: String
    let data: [QuitAttempt]?
}

struct MilestonesForQuitAttemptResponse: Codable {
    let status: Bool
    let detail: String
    let data: [UserMilestone]?
}
