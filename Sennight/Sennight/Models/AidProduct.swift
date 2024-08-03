//
//  Factor.swift
//  Sennight
//
//  Created by 한유진 on 6/27/24.
//  Edited by 한유진 on 2024-07-19: Factor.swift 파일 이름 수정
//

import SwiftUI

enum AidProduct: Int, CaseIterable, Identifiable {
    case patch = 1
    case gum
    case lozenge
    case oralInhaler
    case nasalSpray
    case varenicline
    case bupropion
    case nicotinePouch

    var id: Int { rawValue }
    
    var category: String {
        switch self {
        case .patch, .gum, .lozenge, .oralInhaler, .nasalSpray:
            return "NRT"
        case .varenicline, .bupropion:
            return "Pill"
        case .nicotinePouch:
            return "Other"
        }
    }
    
    var name: String {
        switch self {
        case .patch:
            return "Nicotine Patch"
        case .gum:
            return "Nicotine Gum"
        case .lozenge:
            return "Lozenge"
        case .oralInhaler:
            return "Nicotine Oral Inhaler"
        case .nasalSpray:
            return "Nicotine Nasal Spray"
        case .varenicline:
            return "Varenicline (Chantix)"
        case .bupropion:
            return "Bupropion (Zyban)"
        case .nicotinePouch:
            return "Nicotine Pouch"
        }
    }
}
