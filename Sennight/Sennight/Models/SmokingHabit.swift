//
//  SmokingHabit.swift
//  Sennight
//
//  Created by 한유진 on 7/16/24.
//

import Foundation

struct smokingHabitsRequest: Codable {
    let userId: Int
    let dailyCigarettes: Int
    let cigarettePrice: Int
    let firstCigarette: String
    let smokingYears: Int
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case dailyCigarettes = "daily_cigarettes"
        case cigarettePrice = "cigarette_price"
        case firstCigarette = "first_cigarette"
        case smokingYears = "smoking_years"
    }
}

struct smokingHabitResponse: Codable {
    let status : Bool
    let detail : String
    let data : smokingHabitsData
}

struct smokingHabitsData: Codable {
    let id: Int
    let userId: Int
    let dailyCigarettes: Int
    let cigarettePrice: Int
    let firstCigarette: String
    let smokingYears: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case dailyCigarettes = "daily_cigarettes"
        case cigarettePrice = "cigarette_price"
        case firstCigarette = "first_cigarette"
        case smokingYears = "smoking_years"
    }
}
