//
//  UserSymptom.swift
//  Sennight
//
//  Created by 한유진 on 7/27/24.
//  Edited by 김소연 on 2024-07-29: Symptom 모델 정의
//

//Read Symptom 모델 구현
struct UserSymptomResponse: Codable {
    let status: Bool
    let detail: String
    let data: [UserSymptom]
}

struct UserSymptom: Codable, Identifiable {
    let id: Int
    let symptomID: Int
    let userID: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case symptomID = "symptom_id"
        case userID = "user_id"
    }
}
