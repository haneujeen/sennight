//
//  Motivation.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//
//

import SwiftUI

enum Motivation: Int, CaseIterable, Identifiable {
    case health1 = 1
    case health2
    case health3
    case health4
    case health5
    case health6
    case family1
    case family2
    case family3
    case family4
    case personal1
    case personal2
    case personal3
    case environment1
    case environment2
    case user = 99
    
    var id: Int { rawValue }
    
    var category: String {
        switch self {
        case .health1, .health2, .health3, .health4, .health5, .health6:
            return "Health"
        case .family1, .family2, .family3, .family4:
            return "Family/Relationship"
        case .personal1, .personal2, .personal3:
            return "Personal"
        case .environment1, .environment2:
            return "Environment"
        case .user:
            return "User"
        }
    }
    
    var message: String {
        switch self {
        case .health1:
            return "To lower risk of cancer, heart disease, stroke, and lung diseases."
        case .health2:
            return "To live longer and healthier."
        case .health3:
            return "To reduce coughing, breathlessness, and infections."
        case .health4:
            return "To boost endurance, lung capacity, and fitness."
        case .health5:
            return "To decrease anxiety and stress from nicotine addiction."
        case .health6:
            return "To regain smell and taste."
        case .family1:
            return "To spend more time with loved ones."
        case .family2:
            return "To set a good example."
        case .family3:
            return "To reduce secondhand smoke."
        case .family4:
            return "To prevent others from starting smoking."
        case .personal1:
            return "To save money spent on cigarettes."
        case .personal2:
            return "To be healthy for future activities and plans."
        case .personal3:
            return "To smell better without smoke odor from clothes, hair, and breath."
        case .environment1:
            return "To keep home, car, and surroundings cleaner."
        case .environment2:
            return "To reduce pollution and cigarette litter."
        case .user:
            return ""
        }
    }
    
    var icon: Image {
        switch self {
        case .health1:
            return Image(systemName: "heart.fill")
        case .health2:
            return Image(systemName: "heart")
        case .health3:
            return Image(systemName: "lungs")
        case .health4:
            return Image(systemName: "bolt.heart")
        case .health5:
            return Image(systemName: "ant.circle")
        case .health6:
            return Image(systemName: "nose")
        case .family1:
            return Image(systemName: "person.2")
        case .family2:
            return Image(systemName: "person.3")
        case .family3:
            return Image(systemName: "shield")
        case .family4:
            return Image(systemName: "exclamationmark.triangle")
        case .personal1:
            return Image(systemName: "dollarsign.circle")
        case .personal2:
            return Image(systemName: "star")
        case .personal3:
            return Image(systemName: "sparkles")
        case .environment1:
            return Image(systemName: "house")
        case .environment2:
            return Image(systemName: "leaf")
        case .user:
            return Image(systemName: "pencil.and.outline")
        }
    }
}
