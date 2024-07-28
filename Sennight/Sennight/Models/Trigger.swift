//
//  Trigger.swift
//  Sennight
//
//  Created by 한유진 on 7/27/24.
//

import Foundation

enum Trigger: Int, CaseIterable, Identifiable {
    case stress = 1
    case socialSituations
    case peerPressure
    case socialNorms
    case afterMeals
    case aCupOfCoffee
    case alcohol
    case withdrawalSymptoms
    case physicalCraving
    case anxiety
    case depression
    case seeingOthersSmoke
    case habitual
    case celebrations
    case boredom
    case places
    case driving
    case memory

    var id: Int { rawValue }

    var name: String {
        switch self {
        case .stress: return "Stress"
        case .socialSituations: return "Social Situations"
        case .peerPressure: return "Peer Pressure"
        case .socialNorms: return "Social Norms"
        case .afterMeals: return "After Meals"
        case .aCupOfCoffee: return "A Cup of Coffee"
        case .alcohol: return "Alcohol"
        case .withdrawalSymptoms: return "Withdrawal Symptoms"
        case .physicalCraving: return "Physical Craving"
        case .anxiety: return "Anxiety"
        case .depression: return "Depression"
        case .seeingOthersSmoke: return "Seeing Others Smoke"
        case .habitual: return "Habitual"
        case .celebrations: return "Celebrations"
        case .boredom: return "Boredom"
        case .places: return "Places"
        case .driving: return "Driving"
        case .memory: return "Memory"
        }
    }

    var description: String {
        switch self {
        case .stress: return "High-stress situations"
        case .socialSituations: return "Being in social settings where others are smoking"
        case .peerPressure: return "Social pressure or influence from friends, family, or colleagues who smoke"
        case .socialNorms: return "Being in a culture or environment where smoking is normalized"
        case .afterMeals: return "After eating meals"
        case .aCupOfCoffee: return "Drinking a cup of coffee"
        case .alcohol: return "Drinking alcohol"
        case .withdrawalSymptoms: return "Withdrawal symptoms"
        case .physicalCraving: return "Physical craving for nicotine"
        case .anxiety: return "Feelings of anxiety"
        case .depression: return "Feelings of sadness or depression"
        case .seeingOthersSmoke: return "Seeing people smoke"
        case .habitual: return "Routine or habit"
        case .celebrations: return "Celebrating an event"
        case .boredom: return "Feeling bored or needing a distraction"
        case .places: return "Certain locations, like bars, cafes, or smoking areas"
        case .driving: return "Driving"
        case .memory: return "Reminders of past smoking experiences or rewards"
        }
    }
}
