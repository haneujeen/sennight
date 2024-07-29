//
//  StringToDateFormatter.swift
//  Sennight
//
//  Created by 한유진 on 7/26/24.
//

import Foundation

func dateFormatter() -> DateFormatter {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    return formatter
}

func displayFormatter() -> DateFormatter {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    formatter.timeStyle = .none
    return formatter
}

func formattedDate(from string: String) -> String {
    let inputFormatter = dateFormatter()
    let displayFormatter = displayFormatter()
    
    if let date = inputFormatter.date(from: string) {
        return displayFormatter.string(from: date)
    } else {
        return string
    }
}
