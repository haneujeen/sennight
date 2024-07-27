//
//  StringToDateFormatter.swift
//  Sennight
//
//  Created by 한유진 on 7/26/24.
//

import Foundation

let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    return formatter
}()
