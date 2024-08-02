//
//  User.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//  Edited by 김소연 on :
//  Edited by 한유진 on 2024-07-18: 통합 모델 정의 추가 (to reduce redundancy and simplify maintenance)
//

import Foundation

// Unified Models
// Combines request data for registration, login, and update.
struct UserRequest: Codable {
    let email: String?
    let name: String?
    let password: String?
    let photoFilename: String?
    let appleID: String?
    
    enum CodingKeys: String, CodingKey {
        case email, name, password
        case photoFilename = "photo_filename"
        case appleID = "apple_id"
    }
}

struct User: Codable {
    let id: Int?
    let email: String
    let name: String?
    let password: String?
    let photoFilename: String?
    let accessToken: String?
    let onboardingToken: String?
    let createdAt: String?
    let updatedAt: String?
    let deletedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id, email, name, password
        case photoFilename = "photo_filename"
        case accessToken = "access_token"
        case onboardingToken = "onboarding_token"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case deletedAt = "deleted_at"
    }
}

// General response structure for user-related operations.
struct UserResponse: Codable {
    let status: Bool
    let detail: String
    let data: User?
}

struct AppleSignInResponse: Codable {
    let isUserWithAppleID: Bool
    let detail: String
    let data: User?
    
    enum CodingKeys: String, CodingKey {
        case isUserWithAppleID = "is_user_with_apple_id"
        case detail, data
    }
}
