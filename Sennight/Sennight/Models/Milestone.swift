//
//  Milestone.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//  Edited by 한유진 on 2024-07-24: Milestone, MilestoneRequest,  MilestoneResponse 모델 추가
//

/**
 - 요청:
     {
         "user_id": 1,
         "milestone_id": 1,
         "quit_attempt_id": 2
     }
 
 - 응답:
     {
         "status": true,
         "detail": "User's milestone created successfully",
         "data": {
             "id": 8,
             "user_id": 1,
             "milestone_id": 1,
             "quit_attempt_id": 2,
             "date_achieved": "2024-07-24T01:50:27"
         }
     }
 */

import SwiftUI

struct MilestoneRequest: Codable {
    let userID: Int
    let milestoneID: Int
    let quitAttemptID: Int
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case milestoneID = "milestone_id"
        case quitAttemptID = "quit_attempt_id"
    }
}

struct Milestone: Codable {
    let id: Int
    let userID: Int
    let milestoneID: Int
    let quitAttemptID: Int
    let dateAchieved: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case milestoneID = "milestone_id"
        case quitAttemptID = "quit_attempt_id"
        case dateAchieved = "date_achieved"
    }
}

struct MilestoneResponse: Codable {
    let status: Bool
    let detail: String
    let data: Milestone?
}

