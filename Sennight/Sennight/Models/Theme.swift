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
    case darkGray
    case indigo
    case lavender
    case lightBlue
    case lightGray
    case lightGreen
    case magenta
    case mint
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
        case .bubblegum, .buttercup, .lavender, .lightBlue, .lightGray, .lightGreen, .mint, .orange, .seafoam, .tan, .yellow: return .black
        case .darkGray, .indigo, .magenta, .navy, .periwinkle, .purple, .red, .poppy, .sky, .teal: return .white
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
