//
//  Activity.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//

import SwiftUI

enum Activity: Int, CaseIterable, Identifiable {
    case running = 1
    case jogging
    case cycling
    case swimming
    case strengthTraining
    case yoga
    case rehabilitation
    case cardiovascular
    case hiking
    case playingSports
    case gardening
    case painting
    case reading
    case cooking
    case cleaning
    case writing
    case chewingGum
    case healthySnacks
    case toothpicks
    case deepBreathing
    case drinkingWater
    case watchingMovies
    case listeningToMusic

    var id: Int { rawValue }

    var category: String {
        switch self {
        case .running, .jogging, .cycling, .swimming, .strengthTraining, .yoga, .rehabilitation, .cardiovascular, .hiking:
            return "workout"
        case .playingSports, .gardening, .painting, .reading, .cooking, .cleaning, .writing:
            return "hobby"
        case .chewingGum, .healthySnacks, .toothpicks:
            return "hand-to-mouth"
        case .deepBreathing:
            return "relaxation"
        case .drinkingWater:
            return "oral fixation"
        case .watchingMovies, .listeningToMusic:
            return "entertainment"
        }
    }

    var name: String {
        switch self {
        case .running: return "Running"
        case .jogging: return "Jogging"
        case .cycling: return "Cycling"
        case .swimming: return "Swimming"
        case .strengthTraining: return "Strength Training"
        case .yoga: return "Yoga"
        case .rehabilitation: return "Rehabilitation"
        case .cardiovascular: return "Cardiovascular"
        case .hiking: return "Hiking"
        case .playingSports: return "Playing Sports"
        case .gardening: return "Gardening"
        case .painting: return "Painting"
        case .reading: return "Reading"
        case .cooking: return "Cooking"
        case .cleaning: return "Cleaning"
        case .writing: return "Writing"
        case .chewingGum: return "Chewing Gum"
        case .healthySnacks: return "Healthy Snacks"
        case .toothpicks: return "Toothpicks"
        case .deepBreathing: return "Deep Breathing"
        case .drinkingWater: return "Drinking Water"
        case .watchingMovies: return "Watching Movies"
        case .listeningToMusic: return "Listening to Music"
        }
    }
}
