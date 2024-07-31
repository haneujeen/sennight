//
//  ElapsedTimeString.swift
//  Sennight
//
//  Created by 한유진 on 7/26/24.
//

import Foundation

func elapsedTimeStringSeconds(from start: Date, to end: Date) -> String {
    let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: start, to: end)
    return components.second ?? 0 > 1 ? "\(components.second ?? 0) seconds" : "\(components.second ?? 0) second"
}

func elapsedTimeStringMinutes(from start: Date, to end: Date) -> String {
    let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: start, to: end)
    return components.minute ?? 0 > 1 ? "\(components.minute ?? 0) minutes" : "\(components.minute ?? 0) minute"
}

func elapsedTimeStringHours(from start: Date, to end: Date) -> String {
    let components = Calendar.current.dateComponents([.year, .month, .day, .hour], from: start, to: end)
    return components.hour ?? 0 > 1 ? "\(components.hour ?? 0) hours" : "\(components.hour ?? 0) hour"
}

func elapsedTimeStringDays(from start: Date, to end: Date) -> String {
    let components = Calendar.current.dateComponents([.year, .month, .day], from: start, to: end)
    return components.day ?? 0 > 1 ? "\(components.day ?? 0) days" : "\(components.day ?? 0) day"
}

func elapsedTimeStringMonths(from start: Date, to end: Date) -> String {
    let components = Calendar.current.dateComponents([.year, .month], from: start, to: end)
    return components.month ?? 0 > 1 ? "\(components.month ?? 0) months" : "\(components.month ?? 0) month"
}

func elapsedTimeStringYears(from start: Date, to end: Date) -> String {
    let components = Calendar.current.dateComponents([.year, .month], from: start, to: end)
    return components.year ?? 0 > 1 ? "\(components.year ?? 0) years" : "\(components.year ?? 0) year"
}
