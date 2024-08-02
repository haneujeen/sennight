//
//  UserActivity.swift
//  Sennight
//
//  Created by 한유진 on 7/27/24.
//  Edited by 김소연 on 2024-07-29: Activity 모델 정의
//

import Foundation

//Read Activity 모델 구현
struct UserActivityResponse: Codable {
    let status: Bool
    let detail: String
    let data: [UserActivity]
}

struct UserActivity: Codable, Identifiable {
    let id: Int
    let activityID: Int
    let userID: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case activityID = "activity_id"
        case userID = "user_id"
    }
}

