//
//  UserMotivation.swift
//  Sennight
//
//  Created by 한유진 on 7/27/24.
//  Edited by 김소연 on 2024-07-19: Motivation 모델 정의
//

import Foundation

struct MotivationRequest: Codable {
    let userId: Int
    let motivationId: Int
   
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case motivationId = "motivation_id"
    }
}

struct MotivationReadRequest: Codable {
    let userId: Int
   
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
    }
}

struct MotivationUpdateRequest: Codable {
    let userId: Int
    let motivationId: Int
    let userMotivationId: Int
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case motivationId = "motivation_id"
        case userMotivationId = "user_motivation_id"
    }
}

struct MotivationDeleteRequest: Codable {
    let userMotivationId: Int
    
    enum CodingKeys: String, CodingKey {
        case userMotivationId = "user_motivation_id"
    }
}

struct MotivationResponse: Codable {
    let status : Bool
    let detail : String
    let data : MotivationData
}

struct MotivationData: Codable {
    let id: Int
    let message: String?
    let userId: Int
    let motivationId: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case message
        case userId = "user_id"
        case motivationId = "motivation_id"
    }
}
