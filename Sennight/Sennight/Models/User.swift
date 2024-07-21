//
//  User.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//  Edited by 김소연 on :
//  Edited by 한유진 on 2024-07-18: 통합 모델 정의 추가 (to reduce redundancy and simplify maintenance)
//

import Foundation

//회원가입 모델
struct RegisterRequest: Codable {
    let email: String
    let password: String
    let name: String
}

struct RegisterData: Codable {
    let email: String
    let name: String
    let photoFilename: String?
    let createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case photoFilename = "photo_filename"
        case email
        case name
    }
}

struct RegisterResponse : Codable {
    let status: Bool
    let detail: String
    let data: RegisterData
}

//로그인 모델

struct LoginRequest: Codable {
    let email: String
    let password: String
}

struct LoginData: Codable {
    let id: Int
    let email: String
    let name: String
    let accessToken: String

    
    enum CodingKeys: String, CodingKey {
        case email
        case name
        case accessToken = "access_token"
        case id
    }
}

struct LoginResponse : Codable {
    let status: Bool
    let detail: String
    let data: LoginData
}

// Unified Models
// Combines request data for registration, login, and update.
struct UserRequest: Codable {
    let email: String
    let name: String?
    let password: String
    let photoFilename: String?
    
    enum CodingKeys: String, CodingKey {
        case email, name, password
        case photoFilename = "photo_filename"
    }
}

struct User: Codable {
    let id: Int?
    let email: String
    let name: String?
    let password: String?
    let photoFilename: String?
    let accessToken: String?
    let createdAt: String?
    let updatedAt: String?
    let deletedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id, email, name, password
        case photoFilename = "photo_filename"
        case accessToken = "access_token"
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
