//
//  UserMotivation.swift
//  Sennight
//
//  Created by 한유진 on 7/27/24.
//  Edited by 김소연 on 2024-07-19: Motivation 모델 정의
//  Edited by 한유진 on 2024-07-27: Motivation 모델 리팩터링
/// 1. 파일 이름 변경: Motivation.swift --> UserMotivation.swift
/// 2. MotivationReadRequest와 MotivationDeleteRequest 모델 삭제
/// 3. MotivationRequest와 MotivationUpdateRequest 모델 병합 (UserMotivationRequest)
//

import Foundation

struct UserMotivationRequest: Codable {
    let userID: Int?
    let motivationID: Int?
    let message: String?
   
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case motivationID = "motivation_id"
        case message
    }
}

struct UserMotivation: Codable {
    let id: Int
    let userID: Int
    let motivationID: Int
    let message: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case motivationID = "motivation_id"
        case message
    }
}

struct UserMotivationResponse: Codable {
    let status : Bool
    let detail : String
    let data : UserMotivation?
}
