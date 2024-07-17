//
//  SmokingHabit.swift
//  Sennight
//
//  Created by 한유진 on 7/16/24.
//

import Foundation

struct SmokingHabitsRequest: Codable {
    let userId: Int
    let dailyCigarettes: Int
    let cigarettePrice: Int
    let firstCigarette: Date
    let smokingYears: Int
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case dailyCigarettes = "daily_cigarettes"
        case cigarettePrice = "cigarette_price"
        case firstCigarette = "first_cigarette"
        case smokingYears = "smoking_years"
    }
    
    // Custom Encoder to handle Date
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        try container.encode(userId, forKey: .userId)
        try container.encode(dailyCigarettes, forKey: .dailyCigarettes)
        try container.encode(cigarettePrice, forKey: .cigarettePrice)
        try container.encode(dateFormatter.string(from: firstCigarette), forKey: .firstCigarette)
        try container.encode(smokingYears, forKey: .smokingYears)
    }
    
    // Custom Decoder to handle Date
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        userId = try container.decode(Int.self, forKey: .userId)
        dailyCigarettes = try container.decode(Int.self, forKey: .dailyCigarettes)
        cigarettePrice = try container.decode(Int.self, forKey: .cigarettePrice)
        let firstCigaretteString = try container.decode(String.self, forKey: .firstCigarette)
        firstCigarette = dateFormatter.date(from: firstCigaretteString)!
        smokingYears = try container.decode(Int.self, forKey: .smokingYears)
    }
}

struct SmokingHabitResponse: Codable {
    let status: Bool
    let detail: String
    let data: SmokingHabitsData
}

struct SmokingHabitsData: Codable {
    let id: Int
    let userId: Int
    let dailyCigarettes: Int
    let cigarettePrice: Int
    let firstCigarette: Date
    let smokingYears: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case dailyCigarettes = "daily_cigarettes"
        case cigarettePrice = "cigarette_price"
        case firstCigarette = "first_cigarette"
        case smokingYears = "smoking_years"
    }
    
    // Custom Encoder to handle Date
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        try container.encode(id, forKey: .id)
        try container.encode(userId, forKey: .userId)
        try container.encode(dailyCigarettes, forKey: .dailyCigarettes)
        try container.encode(cigarettePrice, forKey: .cigarettePrice)
        try container.encode(dateFormatter.string(from: firstCigarette), forKey: .firstCigarette)
        try container.encode(smokingYears, forKey: .smokingYears)
    }
    
    // Custom Decoder to handle Date
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        id = try container.decode(Int.self, forKey: .id)
        userId = try container.decode(Int.self, forKey: .userId)
        dailyCigarettes = try container.decode(Int.self, forKey: .dailyCigarettes)
        cigarettePrice = try container.decode(Int.self, forKey: .cigarettePrice)
        let firstCigaretteString = try container.decode(String.self, forKey: .firstCigarette)
        firstCigarette = dateFormatter.date(from: firstCigaretteString)!
        smokingYears = try container.decode(Int.self, forKey: .smokingYears)
    }
}
