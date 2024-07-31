//
//  Motivation.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//  Edited by 김소연 on 2024-07-19: Motivation 모델 정의
//

import Foundation

struct MotivationRequest: Codable {
    let userID: Int?
    let motivationID: Int?
    let userMotivationID: Int?
   
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case motivationID = "motivation_id"
        case userMotivationID = "user_motivation_id"
    }
}

struct MotivationReadRequest: Codable {
    let userID: Int
   
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
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
    let userID: Int
    let motivationID: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case message
        case userID = "user_id"
        case motivationID = "motivation_id"
    }
}
