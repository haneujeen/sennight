//
//  Config.swift
//  Sennight
//
//  Created by 한유진 on 6/28/24.
//

import Foundation

class Settings {
    static let shared = Settings()
        
    private init() {}
    
    let HOST = ProcessInfo.processInfo.environment["HOST"] ?? ""
}
