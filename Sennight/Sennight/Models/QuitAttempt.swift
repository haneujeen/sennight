//
//  QuitAttempt.swift
//  Sennight
//
//  Created by 한유진 on 7/16/24.
//  Edited by 김소연 on 2024-07-19: Quit Attempt 모델 정의
//  Edited by 김소연 on 2024-07-23: Quit Attempt 모델 수정
//

import Foundation

// 기본 응답 구조체
struct QuitAttemptResponse: Codable {
    let status: Bool
    let detail: String
    let data: QuitAttemptData
}

struct QuitAttemptData: Codable {
    let id: Int
    let userID: Int
    let startDate: String
    let endDate: String
    let isActive: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case startDate = "start_date"
        case endDate = "end_date"
        case isActive = "is_active"
    }
}

struct QuitAttemptRequest: Codable {
    let userID: Int?
    let startDate: String?
    let endDate: String?
    let isActive: Bool?
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case startDate = "start_date"
        case endDate = "end_date"
        case isActive = "is_active"
    }
}

