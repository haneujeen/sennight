//
//  QuitAttempt.swift
//  Sennight
//
//  Created by 한유진 on 7/16/24.
//  Edited by 김소연 on 2024-07-19: Quit Attempt 모델 정의
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
    let userId: Int
    let startDate: String
    let endDate: String
    let isActive: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case startDate = "start_date"
        case endDate = "end_date"
        case isActive = "is_active"
    }
}

// createQA용 요청 모델
struct CreateQARequest: Codable {
    let startDate: String
    
    enum CodingKeys: String, CodingKey {
        case startDate = "start_date"
    }
}

// readQA와 readAllQA용 요청 모델
struct ReadQARequest: Codable {
    let userId: Int
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
    }
}

// updateQA와 deleteQA용 요청 모델
struct UpdateDeleteQARequest: Codable {
    let attemptId: Int
    let startDate: String
    let endDate: String
    let isActive: Bool
    
    enum CodingKeys: String, CodingKey {
        case attemptId = "attempt_id"
        case startDate = "start_date"
        case endDate = "end_date"
        case isActive = "is_active"
    }
}

// ReadMilestionesQA용 요청 모델
struct ReadMilestonesQARequest: Codable {
    let attemptId: Int
    let startDate: String
    let endDate: String
    let isActive: Bool
    
    enum CodingKeys: String, CodingKey {
        case attemptId = "attempt_id"
        case startDate = "start_date"
        case endDate = "end_date"
        case isActive = "is_active"
    }
}
