//
//  SmokingHabit.swift
//  Sennight
//
//  Created by 한유진 on 7/16/24.
//

import Foundation

struct SmokingHabitsRequest: Codable {
    let userID: Int
    let dailyCigarettes: Int
    let cigarettePrice: Int
    let firstCigarette: String
    let smokingYears: Int
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case dailyCigarettes = "daily_cigarettes"
        case cigarettePrice = "cigarette_price"
        case firstCigarette = "first_cigarette"
        case smokingYears = "smoking_years"
    }
}

struct SmokingHabitResponse: Codable {
    let status : Bool
    let detail : String
    let data : SmokingHabitsData
}

struct SmokingHabitsData: Codable {
    let id: Int
    let userID: Int
    let dailyCigarettes: Int
    let cigarettePrice: Int
    let firstCigarette: String
    let smokingYears: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case dailyCigarettes = "daily_cigarettes"
        case cigarettePrice = "cigarette_price"
        case firstCigarette = "first_cigarette"
        case smokingYears = "smoking_years"
    }
}
