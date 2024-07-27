//
//  Milestone.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//

/// Milestone enum 케이스의 id로 PK 대신 days가 사용되었습니다.
enum Milestone: Int, CaseIterable, Identifiable {
    case oneWeek = 7
    case twoWeeks = 14
    case threeWeeks = 21
    case oneMonth = 30
    case twoMonths = 60
    case threeMonths = 91
    case sixMonths = 182
    case oneYear = 365
    case twoYears = 730
    case threeYears = 1095
    case fiveYears = 1825
    case tenYears = 3650
    case fifteenYears = 5475
    case twentyYears = 7300
    
    var id: Int { rawValue }
    
    var message: String {
        switch self {
        case .oneWeek:
            return "Congratulations on reaching 7 days of being smoke-free! Your determination inspires us. Keep it up!"
        case .twoWeeks:
            return "Two weeks smoke-free! It’s going to get easier from here. Stay strong!"
        case .threeWeeks:
            return "Congrats on hitting the 3-week mark without smoking! You are a superstar."
        case .oneMonth:
            return "Wow, a whole month without smoking! Keep up the awesome work!"
        case .twoMonths:
            return "Two months smoke-free! You’re doing an amazing job on your journey to a healthier life."
        case .threeMonths:
            return "Three months without smoking! You’ve overcome a big hurdle. Stay strong!"
        case .sixMonths:
            return "You’re halfway through your first year. This is a major milestone. Spread the word!"
        case .oneYear:
            return "A year smoke-free! You’ve made a huge change in your life. So proud of you!"
        case .twoYears:
            return "Two years without smoking! Keep taking care of yourself, keep enjoying the healthier life!"
        case .threeYears:
            return "Three years smoke-free! You’ve come so far. Celebrate this milestone!"
        case .fiveYears:
            return "Five years without smoking! You're our inspiration. Share your story with others!"
        case .tenYears:
            return "Ten years smoke-free! Can you believe it? You’ve come such a long way!"
        case .fifteenYears:
            return "Fifteen years without smoking! You’re a true champion. Celebrate this amazing milestone!"
        case .twentyYears:
            return "Twenty years smoke-free! Can you believe it’s been that long? Our lives (not just yours) have changed so much for the better. Here’s to many more healthy years ahead!"
        }
    }
}
