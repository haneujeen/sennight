//
//  User.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//

import Foundation

//회원가입 모델

struct Register : Codable {
    let email : String
    let password : String
    let name : String
}

struct RegisterData : Codable {
    let email : String
    let name : String
    let photoFilename : String
    let createdAt : String
    
    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case photoFilename = "photo_filename"
        case email
        case name
    }
}

struct RegisterResponse : Codable {
    let status : Bool
    let detail : String
    let data : RegisterData
}

//로그인 모델

struct LoginRequest: Codable {
    let email : String
    let password : String
}

struct LoginData : Codable {
    let id : Int
    let email : String
    let name : String
    let accessToken : String

    
    enum CodingKeys: String, CodingKey {
        case email
        case name
        case accessToken = "access_token"
        case id
    }
}

struct LoginResponse : Codable {
    let status : Bool
    let detail : String
    let data : LoginData
}

