//
//  Milestone.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//  Edited by 김소연 on 2024-07-25: Milestone 모델 정의
//

import Foundation

struct MilestoneResponse: Codable {
    let status: Bool
    let detail: String
    let data: [UserMilestone]
}

struct UserMilestone: Codable, Identifiable {
    let id: Int
    let quitAttemptID: Int
    let userID: Int
    let milestoneID: Int
    let dateAchieved: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case quitAttemptID = "quit_attempt_id"
        case userID = "user_id"
        case milestoneID = "milestone_id"
        case dateAchieved = "date_achieved"
    }
}


