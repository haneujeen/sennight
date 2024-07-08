//
//  User.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//

import Foundation

struct LoginRequest: Codable {
    let userName : String
    let password : String
}

struct Member : Codable {
    let userName : String
    let profile : String
}

struct LoginResponse : Codable {
    let success : Bool
    let token : String
    let member : Member
    let message : String
}

struct RegisterResponse : Codable {
    let success : Bool
    let message : String
}
