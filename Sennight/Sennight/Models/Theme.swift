//
//  Theme.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//

import SwiftUI

enum Theme: String, CaseIterable, Identifiable {
    case bubblegum
    case buttercup
    case indigo
    case lavender
    case magenta
    case navy
    case orange
    case periwinkle
    case poppy
    case purple
    case red
    case seafoam
    case sky
    case tan
    case teal
    case yellow
    
    var accentColor: Color {
        switch self {
        case .bubblegum, .buttercup, .lavender, .orange, .periwinkle, .seafoam, .tan, .teal, .yellow: return .black
        case .indigo, .magenta, .navy, .purple, .red, .poppy, .sky: return .white
        }
    }
    var mainColor: Color {
        Color(rawValue)
    }
    var name: String {
        rawValue.capitalized
    }
    var id: String {
        name
    }
}
